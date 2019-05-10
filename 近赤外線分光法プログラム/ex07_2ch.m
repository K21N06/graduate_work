%% NIRO-200NX (2ch) �ǂݍ��݁Ez-score ��
%  �v���O�������s�O��
%  �������� nx2 �t�@�C���� Excel �ŊJ���āC
%  ��������܂ޖ`�� 14 �s���폜���Cxlsx �`���ŕۑ�

clear all;
close all;

%% �ݒ�E�t�@�C���Ǎ�
dt=input(' �T���v������ [s]�F');
fname=input('File name (.xlsx):','s');
%dat=importdata(fname); 13  %dt=1/Fs;
dat=xlsread(fname);
t=[1:length(dat(:,1))]*dt-dt;

%% ����E�[���Z�b�g
O2Hb1 = dat(:,3)-dat(1,3);
HHb1  = dat(:,4)-dat(1,4);
TOI1  = dat(:,5)-dat(1,5);

%% z �X�R�A�̎Z�o
aO = mean(O2Hb1);
sO = std(O2Hb1);
aH = mean(HHb1);
sH = std(HHb1);
disp('���Î��̃f�[�^�ł���΁C�������Ă����Ă���������');
disp(['O2Hb �� ��: ',num2str(aO)]);
disp(['O2Hb �W���΍�: ',num2str(sO)]);
disp(['HHb �� ��: ',num2str(aH)]);
disp(['HHb �W���΍�: ',num2str(sH)]);
flag = input('z �X�R�A�̎Z�o�ɏ�L�̓��v�ʂ��g���܂���? yes=0����́F');
if flag ~= 0,
    aO = input('O2Hb �� ��: ');
    sO = input('O2Hb �W���΍��F ');
    aH = input('HHb ����: ');
    sH = input('HHb �W���΍�: ');
end
zO = (O2Hb1-aO)/sO;
zO = zO-zO(1);
zH = (HHb1-aH)/sH;
zH = zH-zH(1);

%% �O���t�`��
subplot(2,1,1),
plot(t,zO,'r-'); hold on;
plot(t,zH,'b-');
ylabel('z-score'); legend('O2Hb','HHb');
subplot(2,1,2),plot(t,TOI1,'g-'); ylabel('TOI [%]');
xlabel('Time [s]');
saveas(gca,[fname,'.fig']);
saveas(gca,[fname,'.png']);