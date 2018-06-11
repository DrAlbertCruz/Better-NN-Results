%% RESULT = CONFUSIONMATRIXCNN( FEVAL, FILENAME )
%   MATLAB function to format the results of CNN into a confusion matrix.
%   The first argument should be the parsing function to format the data
%   into an expected format, passed as a function pointer. The second
%   argument is the filename.
%
%   This was made specifically for the Ashraf data set collected in 2017.

function [ u_cmat, std_cmat ] = confusionMatrixCNN( PARSEFUNCTION, FILENAME )
if nargin == 0
    FILENAME = 'test_results.mat';
    PARSEFUNCTION = 'formatAshraf';
end
results = feval( PARSEFUNCTION, FILENAME );
[~, N] = size( results.gt );
labels = unique( results.gt );
numLabels = length( labels );
cmat = zeros(numLabels, numLabels, N );

for fold = 1:N
    for gti = 1:numLabels
        for predi = 1:numLabels
            cmat( gti, predi, fold ) = ...
                sum( results.gt(:,fold) == labels( gti ) & ...
                results.prediction(:,fold) == labels( predi ) );
        end
        % At the end of the row you have to normalize the row
        sum_ = sum( cmat( gti, :, fold ) );
        cmat( gti, :, fold ) = cmat( gti, :, fold ) ./ sum_;
    end
end

u_cmat = mean( cmat, 3 );
std_cmat = var( cmat, 0, 3 );