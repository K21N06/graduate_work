% anaPulse_detectR.m
%

disp(' ** ?????????????????????????????? **')
if iaflag==0,
    plot(t2, fdat);
    xlabel('Time[s]');
    xlim([Tview Tview+3]);
else
    plot(fdat);
    xlim([Tview Tview+10*Fs]);
end
Vth=input('Threshold????');
tP=[];
i=2;
while i<length(fdat)-1001,
    close all;
    if fdat(i)>Vth && fdat(i)>fdat(i-1) && fdat(i)>fdat(i+1),
        it_end   = i+500;
        if it_end>=length(fdat),
            it_end=length(fdat);
        end
        %[Vmax, ip]=max(fdat(i:it_end));
        %if Vmax>=fdat(i),
            %i=i+ip;
            %it_end=it_end+ip;
        %end
        it_start = i-500;
        if it_start<=0,
            it_start=1;
        end
        %if it_end>=length(dat),
            %it_end=length(dat);
        %end
        hold on, grid on;
        plot([it_start:it_end]*Ts,fdat(it_start:it_end));
        plot([i,i]*Ts,[min(fdat(it_start:it_end))*1.2,max(fdat(it_start:it_end))*1.2],'r--');
        plot([it_start,it_end]*Ts,[Vth,Vth],'g--');
        xlim([it_start,it_end]*Ts);
        ylim([min(fdat(it_start:it_end))*1.2,max(fdat(it_start:it_end))*1.2]);
        %flag2=input('Is this a peak? Yes=0/No=1/Skip=2  ');
        flag2=0;
        if flag2==0,
            tP=[tP; i*(1/Fs) fdat(i)];
            i=i+round(t_dead/Ts);
        elseif flag2==2,
            break;
        end;
    end;
    i=i+1;
end;
csvwrite([fname(1:length(fname)-4),'_tP.csv'],tP);
disp([fname(1:length(fname)-4),'_tP.csv is completed'])