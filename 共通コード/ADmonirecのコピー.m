% ADmonirec.m
% contec 用 ADC モニタリング・計測スクリプト
% 実行には DAQ Toolbox が必要
% 実行には AIOcontec_init.m が必要
% 2016.5.2. Notch フィルタ追加 (funcBEF.m 使用) 6
clear all;
close all;

%% 初期設定
AIOcontec_init;
Tsave=input(' 記録時の記録時間 [s]：');
savedat=zeros(Tsave*ActualRate,Nch);
t=[0:1/ActualRate:Tsave-1/ActualRate]; 
%% グラフ準備
ss = input('Enter キーを押すとモニタリングが開始されます \n (r を押すと記録開始，q を押すと終了します．)','s'); 
1hf=figure('position',[650 100 800 600]);
	set(gcf,'doublebuffer','on'); %Reduce plot flicker
for i=1:Nch,
str=['P',num2str(i),'=plot(subplot(',num2str(Nch),',1,',num2str(i),'),dat(:,',num2str(i),'),''b'');'];
eval(str);
end 
%% スタート
start(AI);
recflag=0;
while AI.SamplesAcquired < AI.SamplesPerTrigger,
if strcmp(get(hf,'currentcharacter'),'q')
stop(AI);
break;	%q を押したら終了
end
if strcmp(get(hf,'currentcharacter'),'r')
recflag=1; %r を押したらファイル出力
disp('記録しています．．')
end
while AI.SamplesAcquired < round(duration*ActualRate)
end
samples=round(duration*ActualRate);
% データの取得
dat = peekdata(AI,samples);
%dat = funcBEF(dat, 49, 51, Fs); %交流雑音が大きい時に使用 (2016.5.2) 
% グラフの描画
for i=1:Nch,
str=['set(P',num2str(i),',''ydata'',dat(:,',num2str(i),... 	'),''Color'’,[0 0 1])’];
eval(str);
str=[’subplot(’,num2str(Nch),’,1,’,num2str(i),...
	’),ylabel(’’Ch  ’,num2str(i),’’’,’’FontSize’’,16);ylim([-5 5]);’];
eval(str);
end
xlabel(’Samples’,’FontSize’,16); 
drawnow
if recflag==1,
stop(AI);
start(AI);
samples=round(Tsave*ActualRate);
savedat=getdata(AI,samples);
stop(AI);
%savedat = funcBPF(savedat, 49, 51, Fs); %交流雑音が大きい時に使用 (2016.5.2)
% グラフの描画
for i=1:Nch,
str=[’set(P’,num2str(i),’,’’ydata’’,savedat(:,’,num2str(i),...
 


’),’’xdata’’,t,’’Color’’,[1 0 0])’];
eval(str);
str=[’subplot(’,num2str(Nch),’,1,’,num2str(i),...
’),ylabel(’’Ch  ’,num2str(i),’’’,’’FontSize’’,16);ylim([-5 5]);’];
eval(str);
end
xlabel(’Time [s]’,’FontSize’,16);
break;
end
end
while strcmp(AI.Running,’On’)
end
delete(AI);
disp(’ 測定が終了しました.’); 80
%% 結果の出力
if recflag==1,
str=[’ADmonirec_’,datestr(now,’yyyymmdd_HHMMSS’)];
csvwrite([str,’.csv’],[t’ savedat]);
disp([’ ファイル ’,str,’.csv を出力しました’]);
saveas(gca,[str,’.fig’]);
saveas(gca,[str,’.png’]);
disp([’ グラフ ’,str,’[.fig/.png] を出力しました’]);
end 90
  %% end of file