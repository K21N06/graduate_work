%% funcLPF.m
% butterworthフィルタ,filtfitコマンドによる
% High Passフィルタの実装
% 動作確認はtestfuncLPF.mで行う

function out=funcLPF(dat,Fc,Fs)
[B,A]=butter(2,Fc/(Fs/2),'low');
out=filtfilt(B,A,dat);