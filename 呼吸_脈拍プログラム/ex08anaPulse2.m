%% ex08anaPulse2
%　脈拍解析. 周波数分析 (a-a 間隔/SBP)
%　このプログラムに必要なファイル：
% anaPluse_fftv.m
% funcFFT.m

clear all;
close all;

%%
fname=input('Peak-time File name (_tp.csv) : ','s');
iaflag=input('a-a間隔の解析->0 / SBPの解析->1');
tP=csvread(fname);

%%
close all;
anaPulse_fftv 

% End of File



