function h = freq_sample(N, A, symm)
    % Simple frequency sampling algorithm to determine the impulse
    % response h from A's found in ComputeA
    %
    %
    % INPUT:
    % ------
    % N        - Number of filter coefficients
    % A      - Sample points of desired response [N/2]
    % symmetry - Symmetry of desired filter
    %
    % OUTPUT:
    % -------
    % h - Impulse Response of final filter [N]
    
    M = (N-1)/2;
    
    if (symm == 1)
        
        if (logical(mod(N, 2)))
            for n = 0:(N - 1)
                val = A(1);
                x = 2*pi*(n - M)/N;
                for k = 1:M
                    val = val + 2*A(k+1)*cos(x*(k));
                end
                h(n + 1) = val/N;
            end 
        else
            for n=0:(N - 1)
                val = A(1);
                x = 2*pi*(n - M)/N;
                for k = 1:(N/2 - 1)
                    val = val + 2*A(k + 1)*cos(x*k);
                end
                h(n + 1) = val/N;
            end
        end
        
    else
        
        if (logical(mod(N, 2)))
            for n = 0:(N - 1)
                val = 0;
                x = 2*pi*(n - M)/N;
                for k = 1:M
                    val = 2*A(k + 1)*sin(x*k);
                end
                h(n + 1) = val/N;
            end
            
        else
            
            for n=0:(N - 1)
                val = A(N/2)*sin(pi*(n - M));
                x = 2*pi*(n - M)/N;
                for k=1:(N/2 - 1)
                    val = val + 2*A(k+1)*sin(x*k);
                end
                h(n + 1) = val/N;
            end
        end
    end
end