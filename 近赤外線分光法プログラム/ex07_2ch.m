%% NIRO-200NX (2ch) 読み込み・z-score 化
%  プログラム実行前に
%  いったん nx2 ファイルを Excel で開いて，
%  文字列を含む冒頭 14 行を削除し，xlsx 形式で保存

clear all;
close all;

%% 設定・ファイル読込
dt=input(' サンプル時間 [s]：');
fname=input('File name (.xlsx):','s');
%dat=importdata(fname); 13  %dt=1/Fs;
dat=xlsread(fname);
t=[1:length(dat(:,1))]*dt-dt;

%% 代入・ゼロセット
O2Hb1 = dat(:,3)-dat(1,3);
HHb1  = dat(:,4)-dat(1,4);
TOI1  = dat(:,5)-dat(1,5);

%% z スコアの算出
aO = mean(O2Hb1);
sO = std(O2Hb1);
aH = mean(HHb1);
sH = std(HHb1);
disp('安静時のデータであれば，メモしておいてください↓');
disp(['O2Hb 平 均: ',num2str(aO)]);
disp(['O2Hb 標準偏差: ',num2str(sO)]);
disp(['HHb 平 均: ',num2str(aH)]);
disp(['HHb 標準偏差: ',num2str(sH)]);
flag = input('z スコアの算出に上記の統計量を使いますか? yes=0を入力：');
if flag ~= 0,
    aO = input('O2Hb 平 均: ');
    sO = input('O2Hb 標準偏差： ');
    aH = input('HHb 平均: ');
    sH = input('HHb 標準偏差: ');
end
zO = (O2Hb1-aO)/sO;
zO = zO-zO(1);
zH = (HHb1-aH)/sH;
zH = zH-zH(1);

%% グラフ描画
subplot(2,1,1),
plot(t,zO,'r-'); hold on;
plot(t,zH,'b-');
ylabel('z-score'); legend('O2Hb','HHb');
subplot(2,1,2),plot(t,TOI1,'g-'); ylabel('TOI [%]');
xlabel('Time [s]');
saveas(gca,[fname,'.fig']);
saveas(gca,[fname,'.png']);