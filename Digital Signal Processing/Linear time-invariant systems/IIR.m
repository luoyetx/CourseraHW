clear all
close all
clc

F0 = 697;
FS = 2000;
LAMBDA = 0.98;

% Generate discrete-time signal x
n = 1/FS:1/FS:0.1;
x = sin(2*pi*697*n) + sin(2*pi*1209*n);
figure
plot(x)
grid on

% Plot pole diagram of the filter
omega0 = 2*pi*F0/FS;
figure
poles = [exp(j*omega0) exp(-j*omega0)];
plot(real(poles(1)), imag(poles(1)), 'xr');
hold on
plot(real(poles(2)), imag(poles(2)), 'xr');
plot(exp(j*(0:0.01:1)*2*pi), 'b')
axis square
grid on

% Filter signal
omega0 = 2*pi*F0/FS;
b = 1;
a = [1; -2*LAMBDA*cos(omega0); LAMBDA^2];
y1 = my_filter(x, b, a); 

% Plot the filtered signal
figure
plot(y1)
grid on

% Plot the magnitude of the DFT/DFS of the filtered signal
figure
Y1 = fft(y1);
plot((1:length(Y1))/length(Y1),abs(Y1))