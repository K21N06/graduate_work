%% anaPulse_dv.m
% 時系列�?2階微�?

close all;
disp(' ** 時系列�?2階微�?��実施しま�?**');
d=1/Fs;
t0=[1:length(fdat)]*d-d;
t1=t0(1:length(t0)-1);
t2=t0(2:length(t0)-1);
dat0=fdat;
dat1=funcDeriv(dat0,d);
dat2=funcDeriv(dat1,d);
fdat=dat2;

subplot(3,1,1); plot(t0,dat0); ylabel('Raw');
xlim([20 30])
subplot(3,1,2); plot(t1,dat1); ylabel('1st Deriv.');
xlim([20 30])
subplot(3,1,3); plot(t2,dat2); ylabel('2nd Deriv.');
set(gca,'FontSize',14)
xlim([20 30])
xlabel('Time [s]')

s=input('Enterをおしてください')