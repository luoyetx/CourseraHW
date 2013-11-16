load('jingle.mat');

N=length(jingle);
% DFT / DFS of the jingle
Jingle=fft(jingle);
% Plot of the spectrum in normalized frequencies
figure; 
normFreq=(1:N)/N;
plot(normFreq,abs(Jingle));

sizejingle=length(jingle);
% Down-sampling by a factor 2
jingle2=jingle(1:2:sizejingle);
N=length(jingle2);
% DFT / DFS of the down-sampled jingle
Jingle2=fft(jingle2);
% Zero padding
JJingle2=(sizejingle/N)*[Jingle2(1:(N/2)) zeros(1,sizejingle-N) Jingle2((N/2+1):N)];
% Reconstruction by inverse DFT /DFS
jjingle2=real(ifft(JJingle2));

sizejingle=length(jingle);
% Down-sampling by a factor 10
jingle10=jingle(1:10:sizejingle);
N=length(jingle10);
% DFT / DFS of the down-sampled jingle
Jingle10=fft(jingle10);
% Zero padding
JJingle10=(sizejingle/N)*[Jingle10(1:(N/2)) zeros(1,sizejingle-N) Jingle10((N/2+1):N)];
% Reconstruction by inverse DFT /DFS
jjingle10=real(ifft(JJingle10));

N=length(Jingle);
N1=0.05*N;
N2=0.95*N;
JingleLP=Jingle;
% Low pass filtering of the jingle spectrum
JingleLP(N1:N2)=zeros(1,N2-N1+1);
% Low pass version of the jingle
jingleLP=real(ifft(JingleLP));

figure;
% Plot of the spectral content of the jingle and of its low passed version
% in normalized frequencies
normFreq=(1:N)/N;
subplot(2,1,1); plot(normFreq,abs(Jingle));
subplot(2,1,2); plot(normFreq,abs(JingleLP));

sizejingle=length(jingleLP);
% Down-sample the low pass version of the jingle by a factor 10
jingleLP10=jingleLP(1:10:N);
N=length(jingleLP10);
% DFT / DFS of the down-sampled low pass version of the jingle
JingleLP10=fft(jingleLP10);
% Zero padding
JJingleLP10=(sizejingle/N)*[JingleLP10(1:(N/2)) zeros(1,sizejingle-N) JingleLP10((N/2+1):N)];
% Reconstruction by inverse DFT /DFS
jjingleLP10=real(ifft(JJingleLP10));