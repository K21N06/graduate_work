%% ex08anaPulse1
%�������(a-a�Ԋu/SBP)
%���̃v���O�����ɕK�v�ȃt�@�C��:
% anaECG_hpf.m(�S�d�}�̎����ō쐬)
% anaPulse_dv.m
% anaPluse_detectPeak.m
% funcHPF.m
% funcLPF.m
% funcFFT.m

clear all;
close all;

%%
t_dead=0.25;

%%
fname=input('Pulse File name (_pulse.csv) : ','s' );
Fs=input('Sampling Frequency [Hz] : ');
iaflag=input('a-a�Ԋu�̉��->0 / SBP �̉��->1' );
dat=csvread(fname);
plot(dat(:,1),dat(:,2))
Tview=max(dat(:,1))*0.8*rand(1,1);
Ts=1/Fs;

%%
close all;
anaECG_hpf     %ECG �����ō쐬�E�g�p��������
if iaflag==0,
 anapulse_dv
 close all;
end
anaPulse_detectPeak

% End of File