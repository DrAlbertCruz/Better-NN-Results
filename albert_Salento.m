%% Personal file
clear all
close all
clc

file_name = fullfile( 'C:\code\MATLAB-Deep-Learning\localized3', 'squeezenet_frozen_e5.mat')

x = confusionMatrixCNN( 'formatAshraf', file_name );
y = fullMetricsCNN( 'formatAshraf', file_name );

a = mean(x,3);
b = var(x,0,3);
c = mean(y,3);
d = var(y,0,3);

% Results for Table 3
for i=1:9
    t3row(i) = { [ sprintf('%.4f',c(4,i)), ' (', sprintf('%.4f',d(4,i)*10^3), ')' ] };
end

% Conf mat
for i=1:6
    for j=1:6
        cmat_(i,j) = { [ sprintf('%.4f',a(i,j)), ' (', sprintf('%.4f',b(i,j)*10^3), ')' ] };
    end
end