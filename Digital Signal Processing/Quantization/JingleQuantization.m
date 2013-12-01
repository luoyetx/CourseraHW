load jingle.mat

numberBits=10;

% Constrain the signal to be between -1 and 1
maxValue=max(jingle);
minValue=min(jingle);

rangeJingle=maxValue-minValue;
scalingFactor=2/rangeJingle;
shiftFactor=-1-(scalingFactor*minValue);

jingleResized=jingle.*scalingFactor+shiftFactor;


% Constrain the signal to have 2^numberBits values (0 to 2^(numberBits-1) 
jingleQuant=floor((jingle+1)*2^(numberBits-1));
% And quantize it between -1 and 1
jingleQuant=(jingleQuant/(2^(numberBits-1)))-(2^(numberBits)-1)/2^(numberBits);        
 
% Play the original signal
soundsc(jingleResized,Fs) % in FreeMat use wavplay(x)

% Play the quantized signal
soundsc(jingleQuant,Fs) % in FreeMat use wavplay(x)