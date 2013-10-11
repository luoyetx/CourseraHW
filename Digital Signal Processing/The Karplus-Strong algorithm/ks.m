function [y] = ks(x, alpha, D)

    % y[n] = alpha*y[n-M] + x[n]
    % Length of the output signal must be larger than the length of the input signal,
    % that is, D must be larger than 1
    % x is a vector
    if D < 1
        error('Duration D must be greater than 1');
    end
    % the length of input samples
    M = length(x);
    alphaVector = (alpha*ones(D, 1)) .^ ((0:(D-1))');
    alphaMatrix = alphaVector * ones(1, M);
    xMatrix = ones(D, 1) * x';
    result = (alphaMatrix .* xMatrix)';
    y = result(:);
end