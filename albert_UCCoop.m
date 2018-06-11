%% Personal file
%   Used for getting results from the UC Cooperative extension experiments

file_location = '/home/acruz/MATLAB-Deep-Learning';
file_prefix = 't_vgg_epochVal';
epoch = 32;
file_name = fullfile( file_location, [ file_prefix num2str(epoch) '.mat' ] );

[a,b] = confusionMatrixCNN( 'formatAshraf', file_name );