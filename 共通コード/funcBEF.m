%% funcBEF.m
% butterworthフィルタ,filtfitコマンドによる
% Band Stopフィルタの実装
% 動作確認はtestfuncBEF.mで行う

function out=funcBPF(dat,Fc1,Fc2,Fs)
[B,A]=butter(5,[Fc1/(Fs/2) Fc2/(Fs/2)],'stop');
out=filtfilt(B,A,dat);