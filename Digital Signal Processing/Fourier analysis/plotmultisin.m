function[] = plotmultisin()
    N = 128;
    K =10;
    WN = dftmtx(N);
    n = 0:N-1;
    x = [ones(64,1);-ones(64,1)];
    X = zeros(K,1);
    xx = zeros(N,1);
    figure;
    hold on;
    for k = 1:K
        X = WN(1:k,:) * x;
        xx = real(1/N * WN(1:k,:)' * X);
        plot(n, xx);
    end
end