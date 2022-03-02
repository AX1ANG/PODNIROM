clc;clear all
load iomat.mat
%%
mu = mean([TX{:}],2);
sig = std([TX{:}],0,2);
for i = 1:numel(TrainX)
    TrainXnorm{i} = (TrainX{i} - mu) ./ sig;
end
for i = 1:numel(TestX)
    TestXnorm{i} = (TestX{i,1} - mu) ./ sig;
end

numResponses = size(TrainY{1},1);
featureDimension = size(TrainX{1},1);
numHiddenUnits =2000;
layers = [ ...
    sequenceInputLayer(featureDimension)
    lstmLayer(numHiddenUnits,'OutputMode','sequence')
    fullyConnectedLayer(numResponses)
    regressionLayer];

maxEpochs =4000;miniBatchSize =12;

options = trainingOptions('adam', ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'ValidationData',{TestXnorm,TestYnorm},...
    'InitialLearnRate',0.001, ...
    'GradientThreshold',1, ...
    'Shuffle','never', ...
    'Plots','training-progress',...
    'Verbose',0);
%%
[mynet,myinfo] = trainNetwork(TrainXnorm,TrainYnorm,layers,options);

save mynet.mat mynet 
save myinfo.mat myinfo 

myPred = predict(mynet,TestXnorm{:},'MiniBatchSize',1);
