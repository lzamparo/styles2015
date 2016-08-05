% Perform a Wilcoxon ranksum test on each column of D (MxN)
% Split each column of D according to the class labels given in L (Mx1),
% features(i,1) contains the p-value of the Wilcoxon ranksum test
% features(i,2) indicates whether the i th column was statistically
% separable under the Wilcoxon test.

% 916 columns measured in object table
% columns 3 through 611 are Nuclei or ExtendedNuclei features subjected to the test.
% Test all the features, ignore D columns (1,2) and (612:) later.

function [features] = rankFeatures(D,L,alpha)
    [Drow,Dcol] = size(D);
    features = zeros(Dcol,2);
    positives = D(L(:,1) == 1,:);
    negatives = D(L(:,1) == -1,:);
    for i=1:Dcol 
        [features(i,1),features(i,2)] = ranksum(positives(:,i),negatives(:,i),'alpha',alpha);
    end    
end