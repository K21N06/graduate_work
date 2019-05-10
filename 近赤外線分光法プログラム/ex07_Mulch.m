%% NIRO-200NX (脳活動Mulch-ch) 読み込み
%  �?��たんcsvファイルをExcelで開いて?�上�?3行を削除
%  (1行目が数値から始まるよ�?��する)
%  Excel形�?(.xlsx)で保存す�?

clear all;
close all;

pos8ch=[2,1,9,10;4,3,11,12;6,5,13,14;8,7,15,16];
pos16ch=[10,12,14,16;9,11,13,15;2,4,6,8;1,3,5,7];
pos4chF=[4,2,6,8;3,1,5,7];
pos4chT=[2,1,5,6;4,3,7,8];

Fs=input('Sampling Frequency [Hz]: ');
fname=input('File name (.xlsx): ','s');
disp('Probe positions: ');
disp(' [8] 8ch x2, [16] 16ch, [41] 4ch x2(Frontal), [42] 4ch x2(Temporal)');
posMode=input('Choose from [8,16,41,42]: ');
%dat=importdata(fname);
dat=xlsread(fname);
dt=1/Fs;
t=[1:length(dat(:,1))]*dt-dt;

pos=[];
if posMode==8,
  pos=pos8ch;
elseif posMode==16,
  pos=pos16ch;
elseif posMode==41,
  pos=pos4chF;
elseif posMode==42,
  pos=pos4chT;
else
  disp('invalid choice.M-file will be terminated.');
end
[plotRow, plotCol]=size(pos);

Nrow=length(dat(1,:))-1;
if Nrow>35, Nrow=34; end;
ColOHb=[];
ColHHb=[];
for i=3:Nrow,
  if mod(i,2)==1, ColOHb=[ColOHb, i]; 
  else ColHHb=[ColHHb, i]; 
  end;
end
NCh=length(ColOHb);
MaxHb=max(max(dat(:,3:Nrow)));
MinHb=min(min(dat(:,3:Nrow)));
if MaxHb>20, MaxHb=20; end;
if MinHb<-20, MinHb=-20; end;

for  i=1:NCh,
  [xx,yy]=find(pos==i);
  ii=(xx-1)*plotCol + yy;
  subplot(plotRow, plotCol, ii);
  plot(t, dat(:,ColOHb(i))-dat(1,ColOHb(i)),'r');
  hold on; grid on;
  plot(t, dat(:,ColHHb(i))-dat(1,ColHHb(i)),'b');
  axis tight;
  ylim([MinHb MaxHb]);
  xlabel('Time [s]');
  ylabel(['P',num2str(i)])
end

saveas(gca,[fname(1:length(fname)-4),'.fig']);
saveas(gca,[fname(1:length(fname)-4),'.png']);

 