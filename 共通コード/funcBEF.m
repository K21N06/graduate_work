%% funcBEF.m
% butterworth�t�B���^,filtfit�R�}���h�ɂ��
% Band Stop�t�B���^�̎���
% ����m�F��testfuncBEF.m�ōs��

function out=funcBPF(dat,Fc1,Fc2,Fs)
[B,A]=butter(5,[Fc1/(Fs/2) Fc2/(Fs/2)],'stop');
out=filtfilt(B,A,dat);