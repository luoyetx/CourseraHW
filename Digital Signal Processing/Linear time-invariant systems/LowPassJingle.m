load('jingle.mat')

N=length(jingle);

% Generate the noise
sigma2=0.01;
noise=sigma2*randn(1,N);

% Add noise to signal
jingleNoisy=jingle+noise;

% Construct the impulse response of the system of length 100
M=10;
lambda=(M-1)/M;
h=(1-lambda)*lambda.^(0:99);

L=length(h);

% DFT/DFS of noisy signal and impulse response
JingleNoisy=fft(jingleNoisy,N-L+1);
H=fft(h,N-L+1);

figure;
normFreq=(1:(N-L+1))/(N-L+1);
subplot(2,1,1);  plot(normFreq,abs(JingleNoisy));
subplot(2,1,2);  plot(normFreq,abs(H)); 

Y=H.*JingleNoisy;
Jingle=fft(jingle,N-L+1);

figure;
normFreq=(1:50000)/(N-L+1);
subplot(2,1,1);  plot(normFreq,abs(Jingle(1:50000)));
subplot(2,1,2);  plot(normFreq,abs(Y(1:50000))); 