

% anaECG_hpf.m 2  %
% ex02anaECG1.m �̎��s�ɕK�v
%

% ����m�F���ɂ�
% ���̃t�@�C���̕ۑ��ӏ��Ɠ����ꏊ�� ECGsample.mat ������
% ����m�F���ɂ� �� �̃R�����g������ (�s����%���폜����)
% load(�fECGsample�f);
% plot(dat(:,1),dat(:,2));
% ����m�F���ɂ� �� �̃R�����g������
% �G���[���\������Ȃ���� Ok 13

flag=0;
while flag==0,
    flag=input(' �O�����Ƃ��Ē�搬�����������܂���? \n Yes=0/No=1 ����� : ');
    if flag==0,
        fdat=dat(:,2);
        break;
    else
        fdat=dat(:,2)*0;
        flag2=1;
        while flag2==1,
            Fc=input(' �J �b �g �I �t �� �g �� [Hz]�F ');
            fdat = funcHPF(dat(:,2),Fc,Fs) ;
            disp('�t�B���^�����O���ʂ�\�����܂��D')
            plot(dat(:,1),fdat); xlim([Tview Tview+10]);
            flag2=input(' ���̌��ʂł�낵���ł���? \n Yes=0/No=1 ����� : ')
        end;
        flag=1;
    end;
end;
