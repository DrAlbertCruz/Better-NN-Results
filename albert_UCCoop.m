%% Personal file
%   Used for getting results from the UC Cooperative extension experiments

file_location = '/home/acruz/MATLAB-Deep-Learning/UCCoopExt';
file_prefix = 'alexNet-';
epoch = 26;
file_name = fullfile( file_location, [ file_prefix num2str(epoch) '.mat' ] );

x = confusionMatrixCNN( 'formatAshraf', file_name );
y = fullMetricsCNN( 'formatAshraf', file_name );

a = mean(x,3);
b = var(x,0,3);
c = mean(y,3);
d = var(y,0,3);