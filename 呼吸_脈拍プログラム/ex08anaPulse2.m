%% ex08anaPulse2
%�@�������. ���g������ (a-a �Ԋu/SBP)
%�@���̃v���O�����ɕK�v�ȃt�@�C���F
% anaPluse_fftv.m
% funcFFT.m

clear all;
close all;

%%
fname=input('Peak-time File name (_tp.csv) : ','s');
iaflag=input('a-a�Ԋu�̉��->0 / SBP�̉��->1');
tP=csvread(fname);

%%
close all;
anaPulse_fftv 

% End of File



