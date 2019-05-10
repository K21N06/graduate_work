%% ex08anaPolymate.m
% �t�@�C���̕���
% 2016.10.11 �C���@( csv �t�@�C���𒼐ړǂݍ��߂�悤��)

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
    disp([num2str(i),' �i�ڂ̃f�[�^���̔g�`�ł��� ?']);
    sw=input('ECG->1, ����->2, �ċz->3, �X�L�b�v->0 ����I�����Ă�������:');
    switch sw
        case 1
            filename=[fname(1:length(fname)-4),'_ecg.csv'];
        case 2
            filename=[fname(1:length(fname)-4),'_pulse.csv'];
        case 3
            filename=[fname(1:length(fname)-4),'_resp.csv'];
        otherwise
            disp(' �X�L�b�v���܂�');
     end
     if sw>0,
         disp([filename,' ���o�͂��܂���']);
         csvwrite(filename,[t' rawdat(:,i)]);
     end
end;
