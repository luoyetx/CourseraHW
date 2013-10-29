clear all
close all
clc

% Parameters
M = 10:10:50;

x = randn(100, 1);
figure
plot(x);

for i=1:length(M)

current_M = M(i);
h = 1/current_M*ones(current_M, 1);

y = conv2(x(:), h(:), 'valid');

figure
title(sprintf('M=%d', M));
plot(y)

end