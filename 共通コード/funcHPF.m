%% funcHPF.m
% butterworthフィルタ,filtfitコマンドによる
% High Passフィルタの実装
% 動作確認はtestfuncHPF.mで行う

Function out=funcHPF(dat,Fc,Fs)
[B,A]=butter(2,Fc/(Fs/2),'high');
out=filtfilt(B,A,dat);