x = (-499:500)/20;
indexZero = find(x==0);
x(indexZero) = 1;
y = (sin(pi*x)./(pi*x)).^2;
y(indexZero) = 1;

Y = fft(y);

N = length(y);
figure;
% Plot the square sinc function
subplot(2,1,1); plot(y);
% Plot its DFT / DFS in normalized frequencies
normFreq = (1:N)/N;
subplot(2,1,2); plot(normFreq, abs(Y));

%Down Sample By 5
sizey = length(y);
y5 = y(1:5:sizey);
Y5 = fft(y5);

N = length(y5);
figure;
subplot(2,1,1); plot(y5, 'or');
hold on;
% Plot the down-sampled signal and the original signal for reference 
% paying attention to sample index matching
plot(linspace(1,N,sizey-5+1), y(1:sizey-5+1));
% Plot the DFT / DFS of the down-sampled signal in normalized frequencies
normFreq = (1:N)/N;
subplot(2,1,2); plot(normFreq, abs(Y5));

%Down Sample By 10
sizey=length(y);
y10=y(1:10:sizey);
Y10=fft(y10);

N=length(y10);
figure;

subplot(2,1,1); plot(y10,'or');
hold on; 
% Plot the down-sampled signal and the original signal for reference 
% paying attention to sample index matching
plot(linspace(1,N,sizey-10+1),y(1:sizey-10+1)); 

% Plot the DFT / DFS of the down-sampled signal in normalized frequencies
normFreq=(1:N)/N;
subplot(2,1,2); plot(normFreq,abs(Y10)); 

%Down Sample By 20
sizey=length(y);
y20=y(1:20:sizey);
Y20=fft(y20);

N=length(y20);
figure;

subplot(2,1,1); plot(y20,'or');
hold on; 
% We plot the original signal for reference 
% paying attention to sample index matching
plot(linspace(1,N,sizey-20+1),y(1:sizey-20+1)); 

% Plot the DFT / DFS of the down-sampled signal in normalized frequencies
normFreq=(1:N)/N;
subplot(2,1,2); plot(normFreq,abs(Y20));



%Recover Signals
sizeY=length(Y);

N=length(Y5);
% Zero padding
YY5=[Y5(1:N/2) zeros(1,sizeY-N) Y5((N/2+1):N)];
% Scaling of the DFT / DFS due to the increased number of samples 
scalingFactor=(sizeY/N);
% Scaled inverse DFT / DFS. 
% Notice that the signal is must be real and any imaginary part is due to numerical errors
yy5=scalingFactor*real(ifft(YY5));

N=length(Y10);
% Zero padding
YY10=[Y10(1:N/2) zeros(1,sizeY-N) Y10((N/2+1):N)];
% Scaling of the DFT / DFS due to the increased number of samples 
scalingFactor=(sizeY/N);
% Scaled inverse DFT / DFS. 
% Notice that the signal is must be real and any imaginary part is due to numerical errors
yy10=scalingFactor*real(ifft(YY10));


N=length(Y20);
% Zero padding
YY20=[Y20(1:N/2) zeros(1,sizeY-N) Y20((N/2+1):N)];
% Scaling of the DFT / DFS due to the increased number of samples 
scalingFactor=(sizeY/N);
% Scaled inverse DFT / DFS. 
% Notice that the signal is must be real and any imaginary part is due to numerical errors
yy20=scalingFactor*real(ifft(YY20));


figure;
% Superpose the plot of the reconstructed signal
% and the original signal y

subplot(3,1,1); plot(yy5);
hold on
plot(y,'--r');

subplot(3,1,2); plot(yy10);
hold on
plot(y,'--r') 

subplot(3,1,3); plot(yy20);
hold on
plot(y,'--r') 
