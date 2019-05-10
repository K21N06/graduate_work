%% funcHPF.m
% butterworthフィルタ?��filtfiltコマンドによる
% High Passフィルタの実�?
% 動作確認�?�testfuncHPF.mで行う

function out=funcHPF(dat,Fc,Fs)
[B,A]=butter(2,Fc/(Fs/2),'high');
out=filtfilt(B,A,dat);