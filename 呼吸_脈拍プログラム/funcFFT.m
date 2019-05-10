%% funcFFT.m
% FFTによる振幅スペクトル解析
%
% 動作確認はtestfuncFFT.mで行う

function out=funcFFT(varargin)
dat=varargin{1};
fname='resFFT';
win=ones(length(dat),1);
if nargin==2,
    fname=varargin{2};
elseif nargin==3,
    fname=varargin{2};
    win=varargin{3};
end

t = dat(:,1);
Ts=t(2)-t(1);
Fs=1/Ts;
duration=Ts*length(t);
ff=(Fs/(duration*Fs):Fs/(duration*Fs):Fs)-Fs/(duration*Fs);
Nchan=length(dat(1,:))-1;
fftdat=zeros(length(dat),Nchan);

%% 解析と結果の表示
for i=1:Nchan,
    fdat=dat(:,i+1)-mean(dat(:,i+1));
    fftdat(:,i)=abs (fft(fdat.*win))/(length (dat)/2);
    subplot(Nchan,1,i),bar(ff,fftdat(:,i));
    xlim([0 Fs/2]);
    ylabel([num2str(i+1),' rows']);
end;
xlabel('Frequency [Hz]');

%% 結果の保存
out.f=ff';
out.dat=fftdat;
out.pdat=fftdat.^2;
extdat=[ff' fftdat];
filename=[fname(1:length(fname)-4),'_fft'];
saveas(gca,[filename,'.png']);
disp(['グラフを ',filename,'.png として保存しました．']);
csvwrite([filename,'.csv'],extdat);
disp(['データを ',filename,'.csv として保存しました．']);

%% end of file