%% funcLPF.m
% butterworthフィルタ?��filtfiltコマンドによる
% Low Passフィルタの実�?
% 動作確認�?�testfuncLPF.mで行う

function out=funcLPF(dat,Fc,Fs)
[B,A]=butter(2,Fc/(Fs/2),'low');
out=filtfilt(B,A,dat);