clc;clear all
filepath = [''];

%%
%split the input matrices (initial boundary displacement bx by)
fileinput=[];
for T=[125]
    for k=40:2:160
        filename = ['allink0' int2str(k) 'T' int2str(T) '.txt'];
        step2 = textread([filepath filename]);

        numtimestep = (size(step2,2)-2)./2;
        numpoint = size(step2,1);
        for i = 1:1:numtimestep
            stepbx(:,i) = step2(:,2*(i-1)+1+2);
            stepby(:,i) = step2(:,2*(i-1)+2+2);
        end
        fileinput=[...
            stepbx;...
            stepby;...
            ];
        cd ''
        save(['allink0' int2str(k) 'T' int2str(T) '.mat'],'fileinput')  
        filename
        datetime('now')
        clear step2
    end
end

%%
%split the solution matrices 
fileU=[];fileV=[];fileP=[];fileX=[];fileY=[];
for T=[125]
    for k=40:2:160
        filename = ['allectk0' int2str(k) 'T' int2str(T) '.txt'];
        
        step1 = textread([filepath filename]);

        numtimestep = (size(step1,2)-2)./5;
        numpoint = size(step1,1);
            for i = 1:1:numtimestep
            stepU(:,i) = step1(:,5*(i-1)+1+2);
            stepV(:,i) = step1(:,5*(i-1)+2+2);
            stepP(:,i) = step1(:,5*(i-1)+3+2);
            stepX(:,i) = step1(:,5*(i-1)+4+2);
            stepY(:,i) = step1(:,5*(i-1)+5+2);
            end

        fileU=[fileU stepU];
        fileV=[fileV stepV];
        fileP=[fileP stepP];
        fileX=[fileX stepX];
        fileY=[fileY stepY];
%         cd ''
        save fileU.mat fileU
        save fileV.mat fileV
        save fileP.mat fileP
        save fileX.mat fileX
        save fileY.mat fileY
        filename
        datetime('now')
        clear step1
    end
end

%%
%Snapshot POD Analysis

load fileU.mat fileU
load fileV.mat fileV
load fileP.mat fileP
load fileX.mat fileX
load fileY.mat fileY
% clear fileU fileV fileP fileX fileY 

[phiU,lamU,meanU,basisU] = POD(fileU(:,:),99.8);
datetime('now')
[phiV,lamV,meanV,basisV] = POD(fileV(:,:),99.8);
datetime('now')
[phiP,lamP,meanP,basisP] = POD(fileP(:,:),99.8);
datetime('now')
[phiX,lamX,meanX,basisX] = POD(fileX(:,:),99.8);
datetime('now')
[phiY,lamY,meanY,basisY] = POD(fileY(:,:),99.8);
datetime('now')

save('phiUlammeanbasis.mat','phiU','lamU','meanU','basisU')
save('phiVlammeanbasis.mat','phiV','lamV','meanV','basisV')
save('phiPlammeanbasis.mat','phiP','lamP','meanP','basisP')
save('phiXlammeanbasis.mat','phiX','lamX','meanX','basisX')
save('phiYlammeanbasis.mat','phiY','lamY','meanY','basisY')



