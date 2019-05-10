%% funcFFT.m
% FFT�ɂ��U���X�y�N�g�����
%
% ����m�F��testfuncFFT.m�ōs��

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

%% ��͂ƌ��ʂ̕\��
for i=1:Nchan,
    fdat=dat(:,i+1)-mean(dat(:,i+1));
    fftdat(:,i)=abs (fft(fdat.*win))/(length (dat)/2);
    subplot(Nchan,1,i),bar(ff,fftdat(:,i));
    xlim([0 Fs/2]);
    ylabel([num2str(i+1),' rows']);
end;
xlabel('Frequency [Hz]');

%% ���ʂ̕ۑ�
out.f=ff';
out.dat=fftdat;
out.pdat=fftdat.^2;
extdat=[ff' fftdat];
filename=[fname(1:length(fname)-4),'_fft'];
saveas(gca,[filename,'.png']);
disp(['�O���t�� ',filename,'.png �Ƃ��ĕۑ����܂����D']);
csvwrite([filename,'.csv'],extdat);
disp(['�f�[�^�� ',filename,'.csv �Ƃ��ĕۑ����܂����D']);

%% end of file