function h =  my_remez(numtaps, numbands, bands, des, weight, type, griddensity)
    % Calculates the optimal (in the Chebyshev/minimax sense)
    % FIR filter impulse response given a set of band edges,
    % the desired reponse on those bands, and the weight given to
    % the error in those bands.
    %
    % INPUT:
    % ------
    % numtaps     - Number of filter coefficients
    % numband     - Number of bands in filter specification
    % bands     - User-specified band edges [2 % numband]
    % des      - User-specified band responses [numband]
    % weight    - User-specified error weights [numband]
    % type        - Type of filter
    %
    % OUTPUT:
    % -------
    % h     - Impulse response of final filter [numtaps]
    
    % Based on Janavetz C++ implementation
    
    % Parameters
    POSITIVE = 1;
    NEGATIVE = 0;
    MAXITERATION = 40;
    
    if strcmp(upper(type), 'BANDPASS')
        symmetry = POSITIVE;
    else
        symmetry = NEGATIVE;
    end
    
    % Compute the number of extrema
    r = floor(numtaps/2);                  
    if (logical(mod(numtaps, 2)) && (symmetry == POSITIVE))
        r = r + 1;
    end
    
    % Predict dense grid size in advance for memory allocation
    gridsize = 0;
    for i = 1:numbands
        gridsize = gridsize + round(2*r*griddensity*(bands(2*i) - bands(2*i - 1)) + 0.5);
    end
    if symmetry == NEGATIVE
        gridsize = gridsize - 1;
    end
    
    % Create dense frequency grid
    [Grid, D, W] = create_dense_grid(r, numtaps, numbands, bands, des, weight, symmetry, griddensity);
    
    % Compute initial guess
    Ext = compute_initial_guess(r, gridsize);
    
    % For Differentiator: (fix grid)
    if (strcmp(upper(type), 'DIFFERENTIATOR')) 
        idx = logical(D > 0.0001);
        W(idx) = W(idx)./Grid(idx);
    end
    
    % For odd or Negative symmetry filters, alter the
    % D and W according to Parks McClellan
    if (symmetry == POSITIVE)
        if (~logical(mod(numtaps, 2)))  
            c = cos(pi*Grid);
            D = D./c;
            W = W.*c;
        end
    else
        if (logical(mod(numtaps, 2)))  
            c = sin(2*pi*Grid);
            
        else
            c = sin(pi*Grid);
            
        end
        D = D./c;
        W = W.*c;
    end
    
    % Perform the Remez Exchange algorithm
    for iter = 0:MAXITERATION
               
        [ad, x, y] =  compute_parameters(r, Ext, Grid, D, W);
        E = compute_error(r, ad, x, y, gridsize, Grid, D, W);
        Ext = search(r, Ext, gridsize, E);
        
        if(is_done(r, Ext, E))
            break;
        end
        
    end
    
    [ad, x, y] =  compute_parameters(r, Ext, Grid, D, W);
    
    % Find the 'taps' of the filter for use with Frequency
    % Sampling.  If odd or Negative symmetry, fix the taps
    % according to Parks McClellan
    for i= 0:numtaps/2
        
        if (symmetry == POSITIVE)
            if (logical(mod(numtaps,2)))
                c = 1;
            else
                c = cos(pi*i/numtaps);
            end
        else
            if (logical(mod(numtaps, 2)))
                c = sin(2*pi*i/numtaps);
            else
                c = sin(pi*i/numtaps);
            end
        end
        taps(i+1) = compute_a(i/numtaps, r, ad, x, y)*c;
    end
    
    % Frequency sampling design with calculated taps
    h = freq_sample(numtaps, taps, symmetry);
end


