%% ex08anaPolymate.m
% ファイルの分割
% 2016.10.11 修正　( csv ファイルを直接読み込めるように)

clear all;
close all;

%% Read & Plot
fname =input('Raw File Name (* .csv): ','s');
Fs    =input('Sampling Frequency [Hz]: ');
dt    =1/Fs;
%rawdat=csvread(fnam);
a=importdata(fname);
rawdat=a.data;
col    =length(rawdat(1,:));
N=col;
t     =[1:length(rawdat(:,1))]*dt-dt;

for i=1:col,
    subplot(N,1,i),plot(rawdat(:,i));
end; 

%% Split & Generate
for i=1:col,
    disp([num2str(i),' 段目のデータ何の波形ですか ?']);
    sw=input('ECG->1, 脈拍->2, 呼吸->3, スキップ->0 から選択してください:');
    switch sw
        case 1
            filename=[fname(1:length(fname)-4),'_ecg.csv'];
        case 2
            filename=[fname(1:length(fname)-4),'_pulse.csv'];
        case 3
            filename=[fname(1:length(fname)-4),'_resp.csv'];
        otherwise
            disp(' スキップします');
     end
     if sw>0,
         disp([filename,' を出力しました']);
         csvwrite(filename,[t' rawdat(:,i)]);
     end
end;
