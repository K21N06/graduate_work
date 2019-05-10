%% ex08anaResp

clear all;
close all;
df=.001;
%% Read
fname =input('Resp File Name (*_resp.csv): ','s');
Fs=input('Sampling frequency [Hz]: ');
dat=csvread(fname);

%%解析範囲の設定
dt=1/Fs;
plot(dat(:,1),dat(:,2),'b'); xlabel('Time [s]'); hold on;
t1=input('解析開始時刻は[s]?: ');
t2=input('解析終了時刻は[s]?: ');
t1=round(t1/dt);
if t1<=0, t1=1; end;
t2=round(t2/dt);
if t2>length(dat(:,1)), t2=length(dat(:,1)); end;
plot(dat(t1:t2,1),dat(t1:t2,2),'r');
disp('解析区間を赤色で示しています');
s=input('Enter を押してください');
close all;

%% 振幅スペクトル
fdat=funcFFT(dat(t1:t2,:),fname(1:length(fname)-4),hanning(length(dat(t1:t2,1))));
close all;
fxx=[min(fdat.f):df:max(fdat.f)];
ayy=interp1(fdat.f, fdat.dat, fxx, 'linear');

%% ピーク周波数 (PF)
[Vpeak,ipeak]=max(ayy(1:round(length(ayy)/2)));
PF=fxx(ipeak);
disp(['PF=',num2str(PF),'[Hz]']);

%% PF のスペクトル振幅の半値幅
pflag=0;
if1=ipeak-1;
while pflag==0,
if ayy(if1)>=ayy(ipeak)/2 && ayy(if1-1)<ayy(ipeak)/2,
pflag=1;
end
if1=if1-1;
end
pflag=0;
if2=ipeak+1;
while pflag==0,
if ayy(if2)>=ayy(ipeak)/2 && ayy(if2+1)<ayy(ipeak)/2,
pflag=1;
end
if2=if2+1;
end

%% 重心周波数 (GF)
pflag=0;
if0=if2-1;
while pflag==0,
sum1=sum(ayy(if1:if0));
sum2=sum(ayy(if0:if2));
if sum1<sum2,
pflag=1;
end
if0=if0-1;
end
GF=fxx(if0);
disp(['GF=',num2str(GF),'[Hz]']);
disp(['|PF-GF|=',num2str(abs(PF-GF)),'[Hz]']);

%% グラフに描画
subplot(3,1,1), plot(dat(t1:t2,1),dat(t1:t2,2),'r'); grid on;
ylabel('V_{Resp}','FontSize',18); xlabel('Time [s]','FontSize',18);
axis tight;
subplot(3,1,[2 3]),
plot(fxx,ayy,'b.-'); hold on; grid on;
plot(fxx,ayy*0+Vpeak/2,'b--')
area(fxx(if1:if0),ayy(if1:if0),'FaceColor',[0 1 0]);
area(fxx(if0:if2),ayy(if0:if2),'FaceColor',[1 0 0]);
text(fxx(ipeak),ayy(ipeak)*1.1,['PF=',num2str(PF),'Hz']);
text(fxx(if0),ayy(if0)*1.1,['GF=',num2str(GF),'Hz']);
xlim([fxx(1), 0.5]);
%ylim([vmin, peak*10?1.2]);
ylabel('Amplitude Spectrum','FontSize',18); xlabel('Frequency [Hz]','FontSize',18);
saveas(gca,[fname(1:length(fname)-4),'_resresp.png']);
saveas(gca,[fname(1:length(fname)-4),'_resresp.fig']);

%% end of file