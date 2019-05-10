%% anaPulse_fft
% funcFFT.m を使用
%
%%
Fst = 20; % tP trend のサンプリング周波数[Hz]
dt = 1/Fst;
freqLFHF = [0.05 0.15; 0.15 0.4]; % LF(1行目),HF(2行目)[Hz]

t=[0:dt:tP(length(tP),1)];
if iaflag==1,
 tPT=interp1(tP(:,1),tP(:,2),t,'linear','extrap');
else,
 tPi=[ ];
 for i = 1:length(tP)-1,
  tPi=[tPi; tP(i,1) tP(i+1,1)-tP(i)];
 end;
 csvwrite([fname(1:length(fname)-4),'_aai.csv'],tPi);
 tPT=interp1(tPi(:,1),tPi(:,2),t,'linear','extrap');
end
meanV=mean(tPi(:,2));
sdV=std(tPi(:,2));

%%
ftP=funcFFT([t' tPT'-meanV],fname);
close all;
resLFHF=zeros(2,1);
imin=zeros(2,1);
imax=zeros(2,1);
for i=1:length(resLFHF),
    imin(i)=min(find(ftP.f>=freqLFHF(i,1)));
    imax(i)=max(find(ftP.f<=freqLFHF(i,2)));
    %resLFHF(i)=sum(ftP.pdat(imin(i):imax(i)))*(freqLFHF(i,2)-freqLFHF(i,1));
    resLFHF(i)=sum(ftP.pdat(imin(i):imax(i)))/sum(ftP.pdat);
end

%%
subplot(3,1,1),
plot(t,tPT,'b'); hold on;
plot([min(t),max(t)],[meanV,meanV],'g:')
text((min(t)+max(t))/2, meanV*1.05,['Mean: ',num2str(meanV),', SD:',num2str(sdV)]);
xlabel('Time [s]');
if iaflag==1,
    ylabel('V_{SBP} [V]');
else
    ylabel('AAI [s]');
end
subplot(3,1,[2 3]),hold on;
loglog(ftP.f, ftP.pdat); axis tight;
area(ftP.f(imin(1):imax(1)),ftP.pdat(imin(1):imax(1)),'FaceColor',[1,0,0]);
area(ftP.f(imin(2):imax(2)),ftP.pdat(imin(2):imax(2)),'FaceColor',[0,1,0]);
for i=1:length(resLFHF),
    text((ftP.f(imin(i))+ftP.f(imax(i)))/2, max(ftP.pdat(imin(i):imax(i))),[num2str(resLFHF(i))])
end
axis tight;
xlim([0 0.5]);
xlabel('Frequency [Hz]');
if iaflag==1,
 ylabel('Power Spectrum [V^2/Hz]');
else
 ylabel('Power Spectrum [s^2/Hz]');
end

%%
fname=fname(1:length(fname)-4);
if iaflag==1,
    saveas(gca,[fname,'_sbp.png']);
    saveas(gca,[fname,'_sbp.fig']);
else
    saveas(gca,[fname,'_aai.png']);
    saveas(gca,[fname,'_aai.fig']);
end


disp(['LF: ',num2str(resLFHF(1))]);
disp(['HF: ',num2str(resLFHF(2))]);