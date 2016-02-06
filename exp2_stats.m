close all
clear all

%%this program is to run tests of significance

path = 'forReport';

%% load the mineral data
[Mtx,variables]= xlsread('D:\Field_data\2013\Summer\Geochemistry\EXP2_results.xlsx',2,'A1:U137');


% choose which glaciers you will not use
glOrd = [1 2 3 4 5 6 7 8 9 10 11 13 14 15 16 17 18 19 20 21];
% surge-type = [1 3 5 6 7 8 11 13 14 18 19]
% non-surge-type = [2 3 4 9 10 15 16  17 20 21]
% mixed = [1 8 14 15 16 17 18 19 20 21]
% meta = [2 3 4 5 6 7  9 10 11 13]
glPick = [8];


for l = 1:length(glPick)
    glConv(l) = find(glPick(l) == glOrd);
end

Mtx(:,glConv) = [];

Mtx = Mtx';

ssc =Mtx(:,22);
Q =  Mtx(:,23);
li = Mtx(:,41);
sp = Mtx(:,42);
fms= Mtx(:,43);
lg = Mtx(:,44);
ar = Mtx(:,45);
% fh = Mtx(:,150);
% or = Mtx(:,151);

varNums = [variables';num2cell(1:length(variables))];
varStr = cellstr(variables);

MSS = []
MSNS = []
MXS = []
MXNS = []
MS =[]
MX = []
ST = []
NST = []

type = {'MSS','MSNS','MXS','MXNS','MS','MX','ST','NST'}
for i = 1:length(sp)
    if sp(i) == 1 && li(i) == 1
        typeA(i) = type(1);
        MSS(end+1) = i;
    end
    if sp(i) == 2 && li(i) == 1
        typeA(i) = type(2);
        MSNS(end+1) = i;
    end
    if sp(i) == 1 && li(i) == 2
        typeA(i) = type(3);
        MXS(end+1) = i;
    end
    if sp(i) == 2 && li(i) == 2
        typeA(i) = type(4);
        MXNS(end+1) = i;
    end    
    
    if sp(i) == 1 
        typeS(i) = type(7);
        ST(end+1) = i;
    end
    if sp(i) == 2 
        typeS(i) = type(8);
        NST(end+1) = i;
    end
    if li(i) == 1 
        typeL(i) = type(5);
        MS(end+1) = i;
    end
    if li(i) == 2 
        typeL(i) = type(6);
        MX(end+1) = i;
    end
    
end
i = 130
    x = Mtx(:,i)
    close all
    [p,anovatab,stats] = anova1(x,typeA)
    [c,m,h,nms] = multcompare(stats,'ctype','hsd','alpha',0.10)
    title(['************' varStr(i) '*************'])
   

