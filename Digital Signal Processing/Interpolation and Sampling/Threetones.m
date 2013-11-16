x1=sin(2*pi*40*(1:1000)/1000);
x2=sin(2*pi*80*(1:1000)/1000);
x3=sin(2*pi*160*(1:1000)/1000);
x=[x1 zeros(1,1000) x2 zeros(1,1000) x3];

%sound(x,9000)

N=length(x);
X=fft(x);
figure;
normFreq=(1:N)/N;
plot(normFreq,abs(X))

sizex=length(x);
% Down-sampling by a factor 2
x2=x(1:2:sizex);
N=length(x2);
% DFT / DFS of the down-sampled signal
X2=fft(x2);
% Plot of the spectrum of the down-sampled signal in normalized frequencies
figure; 
normFreq=(1:N)/N;
plot(normFreq,abs(X2))

% Zero padding
XX2=(sizex/N)*[X2(1:(N/2)) zeros(1,sizex-N) X2((1+N/2):N)];
% Reconstruction by inverse DFT /DFS
xx2=real(ifft(XX2));

sizex=length(x);
% Down-sampling by a factor 2
x10=x(1:10:sizex);
N=length(x10);
% DFT / DFS of the down-sampled signal
X10=fft(x10);
% Plot of the spectrum of the down-sampled signal in normalized frequencies
figure; 
plot((1:N)/N,abs(X10))

% Zero padding
XX10=(sizex/N)*[X10(1:(N/2)) zeros(1,sizex-N) X10((1+N/2):N)];
% Reconstruction by inverse DFT /DFS
xx10=real(ifft(XX10));
