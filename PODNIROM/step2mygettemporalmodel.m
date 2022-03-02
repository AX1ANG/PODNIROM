%%
clc; clear all
load fileU.mat
load fileV.mat
load fileP.mat
load fileX.mat
load fileY.mat

% load fileU.mat
load phiUlammeanbasis.mat
Umode = (bsxfun(@minus,fileU(:,:),meanU(:,1))'*phiU(:,:))';
Umodeout=Umode([1:basisU],:);
1
% load fileV.mat
load phiVlammeanbasis.mat
Vmode = (bsxfun(@minus,fileV(:,:),meanV(:,1))'*phiV(:,:))';
Vmodeout=Vmode([1:basisV],:);
2
% load fileP.mat
load phiPlammeanbasis.mat
Pmode = (bsxfun(@minus,fileP(:,:),meanP(:,1))'*phiP(:,:))';
Pmodeout=Pmode([1:basisP],:);
3
% load fileX.mat
load phiXlammeanbasis.mat
Xmode = (bsxfun(@minus,fileX(:,:),meanX(:,1))'*phiX(:,:))';
Xmodeout=Xmode([1:basisX],:);
4
% load fileY.mat
load phiYlammeanbasis.mat
Ymode = (bsxfun(@minus,fileY(:,:),meanY(:,1))'*phiY(:,:))';
Ymodeout=Ymode([1:basisY],:);
5
%%
clear Umode Vmode Pmode Xmode Ymode 
save('PODtemporalmode.mat','Umodeout','Vmodeout','Pmodeout','Xmodeout','Ymodeout') 

