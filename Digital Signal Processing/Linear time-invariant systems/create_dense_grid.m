function [Grid, D, W] = create_dense_grid(r, numtaps, numbands, bands, des, weight, symmetry, griddensity)
    % Creates the dense grid of frequencies from the specified bands.
    % Also creates the Desired Frequency Response function (D) and
    % the Weight function (W) on that dense grid
    % 
    %
    % INPUT:
    % ------
    % r        - 1/2 the number of filter coefficients
    % numtaps  - Number of taps in the resulting filter
    % numband  - Number of bands in user specification
    % bands  - User-specified band edges [2%numband]
    % des    - Desired response per band [2%numband]
    % weight - Weight per band [numband]
    % symmetry - Symmetry of filter - used for grid check
    % griddensity
    %
    % OUTPUT:
    % -------
    % Grid     - Frequencies (0 to 0.5) on the dense grid [gridsize]
    % D        - Desired response on the dense grid [gridsize]
    % W        - Weight function on the dense grid [gridsize]

    % Based on Janavetz C++ implementation
    
    delf = 0.5/(griddensity*r);
    
    % For differentiator, hilbert, symmetry is odd and Grid(0) = max(delf, bands(0))
    if symmetry == 0
        grid0 = max(delf, bands(1));
    else
        grid0 = bands(1);
    end
    
    j = 1;
    for band = 1:numbands
        if band == 1
            lowf = grid0;
        else
            lowf = bands(2*band - 1);
        end
        
        highf = bands(2*band);
        
        k = round((highf - lowf)/delf + 0.5);
        
        for i = 1:k
            D(j) = des(2*band - 1) + (i - 1)*(des(2*band) - des(2*band - 1))/(k-1);
            W(j) = weight(band);
            Grid(j) = lowf;
            lowf = lowf + delf;
            j = j + 1;
        end
        
        Grid(j - 1) = highf;
        
    end
    
    % Similar to above, if odd symmetry, last grid point can't be .5
    %  - but, if there are even taps, leave the last grid point at .5
    if ((symmetry == 0) && (Grid(j - 1) > (0.5 - delf)) && logical(mod(numtaps,2)))
        Grid(j - 1) = 0.5 - delf;
    end
    
end