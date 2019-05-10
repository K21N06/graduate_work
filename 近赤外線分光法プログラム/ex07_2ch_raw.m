%% NIRO-200NX (2ch) �ǂݍ��݁E�� Hb �v���b�g

%  �v���O�������s�O��
%  ��������nx2�t�@�C����Excel�ŊJ���āC
%  ��������܂ޖ`��14�s���폜���Axlsx�`���ŕۑ�

clear all;
close all;

%% �ݒ�E�t�@�C���Ǎ�
dt=input('�T���v������[s]:');
fname=input('File name(.xlsx): ','s');
%dat=importdata(fname);
dat=xlsread(fname);
t=[1:length(dat(:,1))]*dt-dt;

%% �� ��
O2Hb1 = dat(:,3);
HHb1  = dat(:,4);
cHb1  = O2Hb1+HHb1;

%% �O���t�`��

plot(t,O2Hb1,'r-'); hold on;
plot(t,HHb1,'b-');
plot(t,cHb1,'g-');
ylabel('\Delta Hb [\mumol/l]'); legend('O2Hb','HHb','CHb');
xlabel('Time [s]');
saveas(gca,[fname,'_raw.fig']);
saveas(gca,[fname,'_raw.png']);
