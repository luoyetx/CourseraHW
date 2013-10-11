function [y] = ks_loop(x, alpha, D)

    % y[n] = alpha*y[n-M] + x[n]
    % Length of the output signal must be larger than the length of the input signal,
    % that is, D must be larger than 1
    if D < 1
        error('Duration D must be greater than 1');
    end
    % Make sure the input is a row-vector
    x = x';
    % Number of input samples
    M = length(x);
    % Number of output samples
    sizeofy = M*D;
    y = zeros(1, sizeofy);
    y(1:M) = x;
    for index = (M+1):sizeofy
        y(index) = alpha * y(index-M);
    end
end