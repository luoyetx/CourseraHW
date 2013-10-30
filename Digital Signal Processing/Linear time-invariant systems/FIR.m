clear all
close all
clc

% Parameters
F0 = 697;
FS = 2000;

% Generate discrete-time signal x
n = 1/FS:1/FS:0.1;
x = sin(2*pi*697*n) + sin(2*pi*1209*n);
% figure
% plot(x)
% grid on

% Parks-McClellan
numbands = 3;
bands = 0.5*(1/FS)*[0 F0-200 F0-50 F0+50 F0+200 FS];
df = bands(3) - bands(2);
des = [0 0 1 1 0 0];
dp = 0.1;
ds = 0.05;
k = ds/dp;
weight = [1 k 1];
type = 'bandpass';
griddensity = 16;
numtaps = ceil(1-(10*log10(dp*ds)+13)/(2.324*2*pi*df)) + 1;
h = my_remez(numtaps, numbands, bands, des, weight, type, griddensity);


% Filter
y1 = my_filter(x, h, 1);
figure
plot(y1);
grid on

figure
Y1 = fft(y1);
plot((1:length(Y1))/length(Y1),abs(Y1))
grid on