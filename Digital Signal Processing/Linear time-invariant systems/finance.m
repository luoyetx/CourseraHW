clear all
close all
clc

% Parameters
FILENAME = 'data.mat';
M = 100;
LAMBDA = 0.94;

% Load data
% - dates_ts: vector of dates
% - price_ts: vector of price
load(FILENAME);

% Plot price
figure
semilogy(price_ts)
ylabel('Log-price')
datetick(gca, [1 length(price_ts)], dates_ts)
grid on

% Compute simple return time-series
return_ts = (price_ts(2:end) - price_ts(1:(end - 1)))./price_ts(2:end);
dates_ts = dates_ts(2:end);
length_ts = length(return_ts);

% Plot return
figure
plot(return_ts, 'x');
ylabel('Return')
datetick(gca, [1 length_ts], dates_ts);
grid on

% Compute the M-point volatility
volatility = zeros(length_ts, 1);
h = 1/M*ones(M, 1);
for i = M:length_ts
temp = return_ts((i - M + 1):i);
moving_average = h'*temp;
volatility(i) = h'*(temp - moving_average).^2;
end
volatility = sqrt(volatility);

% Plot
figure
plot(volatility);
ylabel('M points volatility')
datetick(gca, [M length_ts], dates_ts)
grid on

% Compute the exponentially weighted volatility
exp_average = 0;
exp_volatility = zeros(length_ts + 1, 1);
for i = 1:length_ts
exp_average = LAMBDA*exp_average + (1 - LAMBDA)*return_ts(i);
exp_volatility(i+1) = LAMBDA*exp_volatility(i) + (1 - LAMBDA)*(return_ts(i) - exp_average)^2;
end
exp_volatility = sqrt(exp_volatility(2:end));


figure
plot(exp_volatility)
ylabel('Exponentially weighted volatility')
datetick(gca, [1 length_ts], dates_ts)
grid on