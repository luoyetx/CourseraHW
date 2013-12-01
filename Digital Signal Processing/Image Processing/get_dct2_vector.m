function basis = get_dct2_vector(N, M)
% Compute normalized DCT2 vectors
    
    % Initialization
    basis = zeros(N*M);
    [Y, X] = meshgrid(0:(N-1), 0:(M-1));
    
    for k1 = 1:N
        for k2 = 1:M
        
            vector = cos(pi/N*(X + 0.5)*(k1 - 1))*cos(pi/M*(Y + 0.5)*(k2 - 1));
            vector = vector(:);
            basis((k1 - 1)*N + k2, :) = vector/sqrt(sum(vector.^2));
        
        end
    end
    
end
    