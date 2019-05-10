%% ex08anaPulse1
%脈拍解析(a-a間隔/SBP)
%このプログラムに必要なファイル:
% anaECG_hpf.m(心電図の実験で作成)
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
iaflag=input('a-a間隔の解析->0 / SBP の解析->1' );
dat=csvread(fname);
plot(dat(:,1),dat(:,2))
Tview=max(dat(:,1))*0.8*rand(1,1);
Ts=1/Fs;

%%
close all;
anaECG_hpf     %ECG 実験で作成・使用したもの
if iaflag==0,
 anapulse_dv
 close all;
end
anaPulse_detectPeak

% End of File