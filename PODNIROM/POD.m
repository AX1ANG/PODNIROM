function [phi, lam, Xmean, nbasis]=POD(X,cenergy)
%% This function calculates the POD basis vectors 
% Function inputs:
% X       :  (n x nsnap) snapshot matrix
%            n = number of states in full space
%            nsnap = number of snapshots
% cenergy :  how much energy of the ensemble you want 
%            to capture, i.e. cenergy = 99.8 (percent)

% Function outputs:
% phi     :   (n x nsnap) matrix containing POD basis vectors
% lam     :   (nsnap x 1) vector containing POD eigenvalues
% Xmean   :   (n x 1) the mean of the ensemble X
% nbasis  :   number of POD basis vectors you should use
%             to capture cenergy (percent) of the ensemble

%% calculate the mean of the snapshots
nsnap = size(X,2);
Xmean = sum(X,2)/nsnap;
% Obtain new snapshot ensemble with zero mean
for i=1:nsnap
    X1(:,i) = X(:,i)-Xmean;
end
%   METHOD OF SNAPSHOTS
% calculate the empirical correlation matrix C
C = X1'*X1/nsnap;
% Calculate the POD basis
[evectorC,evalueC] = eig(C);
phi = X1 * evectorC;
% Normalize the POD basis
for i=1:nsnap
    phi(:,i) = phi(:,i)/norm(phi(:,i),2);
end
% return the POD eigenvalues in a vector
lam = diag(evalueC);
% Rearrange POD eigenvalues, vectors in descending order.
% Note that the correlation matrix C is symmetric, so SVD and EIG
% will give the same evectorC and evalueC but they are already in
% descending order and hence we don't need to rearrange evectorC and
% evalueC 
% if SVD is used
lam = rot90(lam,2);
phi = fliplr(phi);

%%     Find the number of POD basis vectors capturing cenergy (percent) of energy 
% total energy
tenergy = sum(lam);
energy = 0.;
nbasis = 0;
i = 1;
while (((energy/tenergy)*100) < cenergy)
    energy = energy + lam(i);
    i = i+1;
end
nbasis = i;
% plot eigenvalues corresponding to nbasis vectors
plot(lam(1:nbasis)/tenergy/100,'*')
xlabel('Number of POD eigenvalues')
ylabel('Energy captured')
        


