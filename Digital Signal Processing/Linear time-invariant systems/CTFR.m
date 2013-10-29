% Construct the impulse response of the system of length 100
M=10;
lambda=(M-1)/M;
h=(1-lambda)*lambda.^(0:99);

% Generate two tones
x1=sin(2*pi*40*(1:1000)/1000);
x2=sin(2*pi*80*(1:1000)/1000);
x=[x1 x2];

% Generate the noise
sigma2=0.1;
noise=sigma2*randn(1,2000);

% Add noise to signal
xNoisy=noise+x;

N=length(xNoisy);
L=length(h);

% DFT/DFS of noisy signal and impulse response
XNoisy=fft(xNoisy,N-L+1);
H=fft(h,N-L+1);


normFreq=(1:(N-L+1))/(N-L+1);
subplot(3,1,1);
plot(normFreq,abs(XNoisy)); ylabel('|XNoisy|');
subplot(3,1,2);
plot(normFreq,abs(H)); ylabel('|H|');
Y=H.*XNoisy;
subplot(3,1,3);
plot(normFreq,abs(Y)); ylabel('|H*XNoisy|');