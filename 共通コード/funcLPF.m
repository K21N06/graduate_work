%% funcLPF.m
% butterworth�t�B���^,filtfit�R�}���h�ɂ��
% High Pass�t�B���^�̎���
% ����m�F��testfuncLPF.m�ōs��

function out=funcLPF(dat,Fc,Fs)
[B,A]=butter(2,Fc/(Fs/2),'low');
out=filtfilt(B,A,dat);