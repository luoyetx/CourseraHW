function [ad, x, y] = compute_parameters(r, Ext, Grid, D, W)
    % INPUT:
    % ------
    % r      - 1/2 the number of filter coefficients
    % Ext  - Extremal indexes to dense frequency grid [r+1]
    % Grid - Frequencies (0 to 0.5) on the dense grid [gridsize]
    % D    - Desired response on the dense grid [gridsize]
    % W    - Weight function on the dense grid [gridsize]
    %
    % OUTPUT:
    % -------
    % ad   - 'b' in Oppenheim & Schafer [r+1]
    % x    - [r+1]
    % y    - 'C' in Oppenheim & Schafer [r+1]
    
    % Based on Janavetz C++ implementation
    
    % Find x
    x = cos(2*pi*Grid(Ext(1:(r+1))));
    
    
    % Calculate ad[]  - Oppenheim & Schafer eq 7.132
    ld = floor((r - 1)/15) + 1;
    for i = 1:(r + 1)
        denom = 1;
        xi = x(i);
        for j = 1:ld
            for k = j:ld:(r + 1)
                if (k ~= i)
                    denom = denom*2*(xi - x(k));
                end
            end
        end
        if abs(denom) < 10^-5
            denom = 10^-5;
        end
        ad(i) = 1/denom;
    end
    
    % Calculate delta  - Oppenheim & Schafer eq 7.131
    numer = 0;
    denom = 0;
    sign = 1;
    for i = 1:(r + 1)
        numer = numer + ad(i)*D(Ext(i));
        denom = denom + sign*ad(i)/W(Ext(i));
        sign = -sign;
    end
    delta = numer/denom;
    sign = 1;
    
    % Calculate y[]  - Oppenheim & Schafer eq 7.133b
    for i = 1:(r + 1)
        y(i) = D(Ext(i)) - sign*delta/W(Ext(i));
        sign = -sign;
    end
end