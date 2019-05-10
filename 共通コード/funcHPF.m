%% funcHPF.m
% butterworth�t�B���^,filtfit�R�}���h�ɂ��
% High Pass�t�B���^�̎���
% ����m�F��testfuncHPF.m�ōs��

Function out=funcHPF(dat,Fc,Fs)
[B,A]=butter(2,Fc/(Fs/2),'high');
out=filtfilt(B,A,dat);