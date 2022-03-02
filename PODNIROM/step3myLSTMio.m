clc;clear all

numTrain=randperm(61,48);
numTest=setdiff([1:61],numTrain);

%%
load PODtemporalmode.mat
myi=1;
TX=[];TY=[];
for T=[125]
    for k=40:2:160
        filename = ['allink0' int2str(k) 'T' int2str(T) '.mat'];
        load (filename) 
        TX{myi,1}=fileinput(:,:);
        TY{myi,1}=[...
            Umodeout(:,1+201*(myi-1):201+201*(myi-1));...
            Vmodeout(:,1+201*(myi-1):201+201*(myi-1));...
            Pmodeout(:,1+201*(myi-1):201+201*(myi-1));...
            Xmodeout(:,1+201*(myi-1):201+201*(myi-1));...
            Ymodeout(:,1+201*(myi-1):201+201*(myi-1));...
            ];
        myi=myi+1;
        filename
        datetime('now')
        clear fileinput
    end
end

clear myi TestX TestY TrainX TrainY
for myi=1:size(numTrain,2)
TrainX{myi,1}=TX{numTrain(1,myi),1};
TrainY{myi,1}=TY{numTrain(1,myi),1};
end
for myi=1:size(numTest,2)
TestX{myi,1}=TX{numTest(1,myi),1};
TestY{myi,1}=TY{numTest(1,myi),1};

end
save('iomat.mat','numTrain','numTest','TX','TY','TrainX','TrainY','TestX','TestY')

