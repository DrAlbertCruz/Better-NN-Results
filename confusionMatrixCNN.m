%% RESULT = CONFUSIONMATRIXCNN( FEVAL, FILENAME )
%   MATLAB function to format the results of CNN into a confusion matrix.
%   The first argument should be the parsing function to format the data
%   into an expected format, passed as a function pointer. The second
%   argument is the filename.
%
%   This was made specifically for the Ashraf data set collected in 2017.

function afConfusionMatrix = confusionMatrixCNN( szPARSEFUNCTION, szFILENAME )
if nargin == 0
    szFILENAME = 'test_results.mat';
    szPARSEFUNCTION = 'formatAshraf';
end
objResults = feval( szPARSEFUNCTION, szFILENAME );
[~, iNumFolds] = size( objResults.gt );
acatLabelNames = unique( objResults.gt );
iNumLabels = length( acatLabelNames );
afConfusionMatrix = zeros(iNumLabels, iNumLabels, iNumFolds );

for iFold = 1:iNumFolds
    for iGT = 1:iNumLabels
        for predi = 1:iNumLabels
            afConfusionMatrix( iGT, predi, iFold ) = ...
                sum( objResults.gt(:,iFold) == acatLabelNames( iGT ) & ...
                objResults.prediction(:,iFold) == acatLabelNames( predi ) );
        end
        % At the end of the row you have to normalize the row
        iSum = sum( afConfusionMatrix( iGT, :, iFold ) );
        afConfusionMatrix( iGT, :, iFold ) = afConfusionMatrix( iGT, :, iFold ) ./ iSum;
    end
end