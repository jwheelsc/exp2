close all
clear all

%%this program started a as a means to do PCA, but has since become a
%%smorgus borg of plotting. The new data matrix mill include all read-in
%%material but will also be appended with the flux of ions and minerals and
%%the fraction of ions. 

path = 'ionRatios';
legLoc = 'northwest'


ALL = 1
MX  = 0
MS = 0
MXS = 0
MXNS = 0
MSS = 0
MSNS = 0
ST = 0
NST = 0

%all mins = 24:40
%MXmin = 24:35,37:40
%MSmins = 24,25,26,27,28,29,30,32,34,35,36
%Frac cation = 114:128
%cations = 2:16
%anions = 17:20
%frac anions = 129:132
arr = [129:132, 21, 23];


%% load the mineral data
[Mtx,variables]= xlsread('D:\Field_data\2013\Summer\Geochemistry\EXP2_results.xlsx',2,'A1:V137');
stdGL1 = Mtx(:,end)
Gl1dat = Mtx(:,1)

[MtxGL1,variablesGL1]= xlsread('D:\Field_data\2013\Summer\Geochemistry\gl1Temp.xlsx',4,'A1:W28');

MtxGL1 = [zeros(1,length(MtxGL1(:,1)))',MtxGL1]

% keyboard

if ALL == 1
    %ALL
    glPick = [1 2 3 4 5 6 7 9 10 11 13 14 15 16 17 18 19 20 21]
    strSPT = 'All Glaciers' 
end
if MS == 1
    %MS
    glPick = [2 3 4 5 6 7 9 10 11 13]
    strSPT = 'All Metaseds' 
end
if MX == 1
    %MX
    glPick = [1 14 15 16 17 18 19 20 21]
    strSPT = 'All Mixed' 
end
if MSNS == 1
    %MSNS
    glPick = [2 4 9 10]
    strSPT = 'Metaseds non-surge' 
end
if MSS == 1
    %MSS
    glPick = [3 5 6 7 11]
    strSPT = 'Metaseds surge'
end
if MXS == 1
    %MXS
    glPick = [1 14 18 19]
    strSPT = 'Mixed surge'
end
if MXNS == 1
    %MXNS
    glPick = [15 16 17 20 21]
    strSPT = 'Mixed non-surge'
end
if ST == 1
    %ST
    glPick = [1 3 5 6 7 11 13 14 18 19]
    strSPT = 'All surge-type'
end
if NST == 1
    %NST
    glPick = [2 4 9 10 15 16 17 20 21]
    strSPT = 'All non-surge-type'
end


NM = Mtx(1,:);
c1 = 1
for i = 1:length(glPick)
    gl = glPick(i);
    c2 = 1
    for j = 1:length(NM)     
        if gl == NM(j)
            elems(c1) = c2;
            c1 = c1+1;
        else
            c2 = c2+1;
        end
    end
    
end


Mtx = [Mtx(:,elems)]';

varNums = [variables';num2cell(1:length(variables))];
varStr = cellstr(variables);

li = Mtx(:,41);
sp = Mtx(:,42);
fms= Mtx(:,43);

%%
RR = 5
f12 = figure(12);
for subP = [1:3]

    subplot(2,2,subP)
%     pA = [1:4]+4
    pA = [114:117]+(4*(RR-1))
    a = pA(subP)
    fs6 = 12;
    msf = (fms+0.1)*10
    xos = 0.2
    AA = [2:5]+(4*(RR-1))
    a1 = AA(subP)
    yy = Mtx(:,a);
    
%     boxplot(MtxGL1(:,a),3*ones(1,length(MtxGL1(:,a))))
    xq = MtxGL1(:,a1)
    yq1 = quantile(MtxGL1(:,a1),0.01)
    yq2 = quantile(MtxGL1(:,a1),0.25)
    yq3 = quantile(MtxGL1(:,a1),0.75)
    yq4 = quantile(MtxGL1(:,a1),0.9)
    
    plot([3,3],[yq1,yq4], 'k')
    hold on 
    plot([3,3],[yq2,yq3],'linewidth', 2,'color','b')
    hold on
    hold on
    plot([2.9,3.1],[yq1, yq1], 'k')
    hold on
    plot([2.9,3.1],[yq4, yq4], 'k')

    for i = 1:length(elems)
        hold on
        y = yy(i)
        if sp(i) == 1 && li(i) == 2
        [ls,fc,xx,ms,fac,ew] = specsExp2(sp(i),li(i));
        h1 = plot(xx,y,'marker',ls,'markerfacecolor',fac,...
                    'markeredgecolor',fc,'markersize',ms)
                text(xx+xos,y,num2str(Mtx(i,1)), 'fontsize', 6)
        end
        if sp(i) == 2 && li(i) == 2
        [ls,fc,xx,ms,fac,ew] = specsExp2(sp(i),li(i));
        h2 = plot(xx,y,'marker',ls,'markerfacecolor',fac,...
                    'markeredgecolor',fc,'markersize',ms)
                text(xx+xos,y,num2str(Mtx(i,1)), 'fontsize', 6)
        end
        if sp(i) == 1 && li(i) == 1
        [ls,fc,xx,ms,fac,ew] = specsExp2(sp(i),li(i));
        h3 = plot(xx,y,'marker',ls,'markerfacecolor',fac,...
                    'markeredgecolor',fc,'markersize',ms)
                text(xx+xos,y,num2str(Mtx(i,1)), 'fontsize', 6)
        end
        if sp(i) == 2 && li(i) == 1
        [ls,fc,xx,ms,fac,ew] = specsExp2(sp(i),li(i));
        h4 = plot(xx,y,'marker',ls,'markerfacecolor',fac,...
                    'markeredgecolor',fc,'markersize',ms)
                text(xx+xos,y,num2str(Mtx(i,1)), 'fontsize', 6)
        end
        hold on
 
    end
   
    
    
    xlim([0 5])

    xl1 = get(gca,'xlim')
    ylabel(varStr(a))
    % ylabel('SSC/Q')
    %     ylabel('Ca^{2+}/Mg^{2+}')
    % title(varStr(a),'fontsize',32)
    %     set(gca,'fontsize',20)
    xnames = {'MS-S','MS-NS','MX-S','MX-NS'}
    XX = [1:length(xnames)]
  
    set(gca, 'XTick', XX, 'XTickLabel', xnames, 'fontsize', 8)
%     set(gca,'fontsize',12)
    grid on
%     savePDFfunction(f12,['ion4plotFR' num2str(RR)])
end
%%

x = Mtx(:,18)
[p,anovatab,stats] = anova1(x,typeA)
[c,m,h,nms] = multcompare(stats,'ctype','hsd','alpha',0.10)

return

%% x y plots
f2  = figure(2)
xos = 0.01
% a = 24
% b = 25
yy = Mtx(:,27)+Mtx(:,118)+Mtx(:,35)+Mtx(:,37)
xa = Mtx(:,32)+Mtx(:,29)
for i = 1:length(yy)
    
    x = xa(i)
    y = yy(i)
    if sp(i) == 1 && li(i) == 2
    [ls,fc,xx,ms,fac,ew] = specsExp2(sp(i),li(i));
    h1 = plot(x,y,'marker',ls,'markerfacecolor',fac,...
                'markeredgecolor',fc,'markersize',10*fms(i)+4)
            text(x+xos,y,num2str(Mtx(i,1)))
    end
    if sp(i) == 2 && li(i) == 2
    [ls,fc,xx,ms,fac,ew] = specsExp2(sp(i),li(i));
    h2 = plot(x,y,'marker',ls,'markerfacecolor',fac,...
                'markeredgecolor',fc,'markersize',10*fms(i)+4)
            text(x+xos,y,num2str(Mtx(i,1)))
    end
    if sp(i) == 1 && li(i) == 1
    [ls,fc,xx,ms,fac,ew] = specsExp2(sp(i),li(i));
    h3 = plot(x,y,'marker',ls,'markerfacecolor',fac,...
                'markeredgecolor',fc,'markersize',ms)
            text(x+xos,y,num2str(Mtx(i,1)))
    end
    if sp(i) == 2 && li(i) == 1
    [ls,fc,xx,ms,fac,ew] = specsExp2(sp(i),li(i));
    h4 = plot(x,y,'marker',ls,'markerfacecolor',fac,...
                'markeredgecolor',fc,'markersize',ms)
            text(x+xos,y,num2str(Mtx(i,1)))
    end
    hold on
end
legend([h1 h2 h3 h4],{'MX-S','MX-NS','MS-S','MS-NS'},'location','northeast')
% xlim([0 5])
xl1 = get(gca,'xlim')
% ylabel(varStr(a))
% xlabel(varStr(b))
ylabel('Qtz + illite/mscvt')
xlabel('Albite + actinolite')

set(gca,'fontsize',20)
grid on
% savePDFfunction(f2,'QtzAc')