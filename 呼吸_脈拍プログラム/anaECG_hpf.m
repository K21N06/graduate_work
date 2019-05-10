

% anaECG_hpf.m 2  %
% ex02anaECG1.m の実行に必要
%

% 動作確認時には
% このファイルの保存箇所と同じ場所に ECGsample.mat をおく
% 動作確認時には ↓ のコメントを解除 (行頭の%を削除する)
% load(’ECGsample’);
% plot(dat(:,1),dat(:,2));
% 動作確認時には ↑ のコメントを解除
% エラーが表示されなければ Ok 13

flag=0;
while flag==0,
    flag=input(' 前処理として低域成分を除去しますか? \n Yes=0/No=1 を入力 : ');
    if flag==0,
        fdat=dat(:,2);
        break;
    else
        fdat=dat(:,2)*0;
        flag2=1;
        while flag2==1,
            Fc=input(' カ ッ ト オ フ 周 波 数 [Hz]： ');
            fdat = funcHPF(dat(:,2),Fc,Fs) ;
            disp('フィルタリング結果を表示します．')
            plot(dat(:,1),fdat); xlim([Tview Tview+10]);
            flag2=input(' この結果でよろしいですか? \n Yes=0/No=1 を入力 : ')
        end;
        flag=1;
    end;
end;
