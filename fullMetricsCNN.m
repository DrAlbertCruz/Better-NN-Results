%% RESULT = FULLMETRICSCNN( FEVAL, FILENAME )
%   MATLAB function to format the results of MATLAB's built in CNN
%   functions so that it reports some commonly used metrics that can be
%   found in:
%
%   https://en.wikipedia.org/wiki/Confusion_matrix
%
%   This was made specifically for the Ashraf data set collected in 2017.

function afMetrics = fullMetricsCNN( szPARSEFUNCTION, szFILENAME )
% Default arguments: Load an example from the Ashraf dataset
if nargin == 0
    szFILENAME = 'test_results.mat';
    szPARSEFUNCTION = 'formatAshraf';
end
objResults = feval( szPARSEFUNCTION, szFILENAME );
[~, iNumFolds] = size( objResults.gt );
acatLabelNames = unique( objResults.gt );
iNumClasses = length( acatLabelNames );
afMetrics = zeros(iNumClasses,9,iNumFolds);

for iFold = 1:iNumFolds
    for iGT = 1:iNumClasses
        abGT = objResults.gt(:,iFold);
        abPrediction = objResults.prediction(:,iFold);
        catLabel = acatLabelNames( iGT );
        
        iPositives = sum( abGT == catLabel );
        iNegatives = sum( abGT ~= catLabel ); % I suppose this could be total-p
        iTruePositives = sum( abGT == catLabel & abPrediction == catLabel );
        iTrueNegatives = sum( abGT ~= catLabel & abPrediction ~= catLabel );
        iFalsePositives = sum( abGT ~= catLabel & abPrediction == catLabel );
        iFalseNegatives = sum( abGT == catLabel & abPrediction ~= catLabel );
        
        % True positive rate, or sensitivity
        afMetrics(iGT,1,iFold) = iTruePositives / iPositives;
        % True negative rate, or specificity
        afMetrics(iGT,2,iFold) = iTrueNegatives / iNegatives;
        % Precision aka PPV
        afMetrics(iGT,3,iFold) = iTruePositives / (iTruePositives + iFalsePositives);
        % Negative predictive value
        afMetrics(iGT,4,iFold) = iTrueNegatives / (iTrueNegatives + iFalseNegatives);
        % False negative rate
        afMetrics(iGT,5,iFold) = 1 - afMetrics(iGT,1,iFold);
        % False positive rate
        afMetrics(iGT,6,iFold) = 1 - afMetrics(iGT,2,iFold);
%         % False discovery rate
%         afMetrics(iGT,7,iFold) = 1 - afMetrics(iGT,3,iFold);
%         % False omission rate
%         afMetrics(iGT,8,iFold) = 1 - afMetrics(iGT,4,iFold);
        % Accuracy
        afMetrics(iGT,7,iFold) = (iTruePositives + iTrueNegatives) / ...
            (iPositives + iNegatives);
        % F1 score
        afMetrics(iGT,8,iFold) = 2 * afMetrics(iGT,3,iFold) * afMetrics(iGT,1,iFold) / ...
             ( afMetrics(iGT,3,iFold) + afMetrics(iGT,1,iFold) );
         % Matthews correlation coefficient
        afMetrics(iGT,9,iFold) = (iTruePositives * iTrueNegatives - ...
            iFalsePositives * iFalseNegatives ) / sqrt( (iTruePositives + ...
            iFalsePositives) * (iTruePositives + iFalseNegatives) * ...
            (iTrueNegatives + iFalsePositives) * (iTrueNegatives + ...
            iFalseNegatives) );
    end
end