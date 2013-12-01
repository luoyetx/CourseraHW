numberBits=3;

% Generate a two period sawtooth signal between -1 and 1
x=(-0.98:0.02:1);
x=[x x];

% Constrain the signal to have 2^numberBits values (0 to 2^(numberBits-1) 
xQuant=floor((x+1)*2^(numberBits-1));
% And quantize it between -1 and 1
xQuant=(xQuant/(2^(numberBits-1)))-(2^(numberBits)-1)/2^(numberBits);        

% Compute the quantization error
errorQuant=x-xQuant;

% Plot the quantized signal versus the original signal
% and the quantization error
figure

subplot(2,1,1)
plot(x);
hold on
plot(xQuant,'or');

subplot(2,1,2)
plot(errorQuant,'or');


numberBits=3;

% Generate a two period sinusoid signal between -1 and 1
x=sin(2*pi*(1:100)/100);
x=[x x];

% Constrain the signal to have 2^numberBits values (0 to 2^(numberBits-1) 
xQuant=floor((x+1)*2^(numberBits-1));
% And quantize it between -1 and 1
xQuant=(xQuant/(2^(numberBits-1)))-(2^(numberBits)-1)/2^(numberBits);        
  
% Compute the quantization error
errorQuant=x-xQuant;

% Plot the quantized signal versus the original signal
% and the quantization error
figure

subplot(2,1,1)
plot(x);
hold on
plot(xQuant,'or');

subplot(2,1,2)
plot(errorQuant,'or'); 