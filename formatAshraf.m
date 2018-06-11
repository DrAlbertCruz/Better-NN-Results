%% RESULT = FORMATASHRAF( FILENAME )
%   MATLAB function to format results into an Nx2, where N is the number of
%   folds. The first column should be the ground truth and the second
%   column should be the prediction.
%   
%   The result should be:
%       result.gt = An MxN matrix where M is the number of samples and N is
%       the number of folds. This is the ground truth for each run.
%       result.prediction = An MxN matrix where M is the number of samples
%       and N is the number of folds. This is the prediction matrix.
%       result.time = An 1xN matrix where N is the number of folds. This is
%       the amount of time that was spent in training.
%
%   This was made specifically for the Ashraf data set collected in 2017.

function out_results = formatAshraf( filename )
if nargin == 0
    load( 'test_results.mat' );
else
    load( filename );
end
M = size(results(1).prediction,1);
N = size(results,2);

out_results.gt = categorical(zeros(M,N));
out_results.prediction = categorical(zeros(M,N));
out_results.time = zeros(1,N);

for i=1:N
    out_results.gt(:,i) = results(i).groundTruth;
    out_results.prediction(:,i) = results(i).prediction;
    out_results.time(i) = results(i).time;
end