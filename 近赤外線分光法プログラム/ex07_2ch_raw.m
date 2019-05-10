%% NIRO-200NX (2ch) 読み込み・△ Hb プロット

%  プログラム実行前に
%  いったんnx2ファイルをExcelで開いて，
%  文字列を含む冒頭14行を削除し、xlsx形式で保存

clear all;
close all;

%% 設定・ファイル読込
dt=input('サンプル時間[s]:');
fname=input('File name(.xlsx): ','s');
%dat=importdata(fname);
dat=xlsread(fname);
t=[1:length(dat(:,1))]*dt-dt;

%% 代 入
O2Hb1 = dat(:,3);
HHb1  = dat(:,4);
cHb1  = O2Hb1+HHb1;

%% グラフ描画

plot(t,O2Hb1,'r-'); hold on;
plot(t,HHb1,'b-');
plot(t,cHb1,'g-');
ylabel('\Delta Hb [\mumol/l]'); legend('O2Hb','HHb','CHb');
xlabel('Time [s]');
saveas(gca,[fname,'_raw.fig']);
saveas(gca,[fname,'_raw.png']);
