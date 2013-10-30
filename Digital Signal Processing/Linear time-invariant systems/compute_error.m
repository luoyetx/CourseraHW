function E = compute_error(r, ad, x, y, gridsize, Grid, D, W)
    % Calculates the Error function from the desired frequency response
    % on the dense grid (D), the weight function on the dense grid (W),
    % and the present response calculation (A)
    %
    % INPUT:
    % ------
    % r      - 1/2 the number of filter coefficients
    % ad   - [r+1]
    % x    - [r+1]
    % y    - [r+1]
    % gridsize  - Number of elements in the dense frequency grid
    % Grid - Frequencies on the dense grid [gridsize]
    % D    - Desired response on the dense grid [gridsize]
    % W    - Weight function on the desnse grid [gridsize]
    %
    % OUTPUT:
    % -------
    % E    - Error function on dense grid [gridsize]
    
    % Based on Janavetz C++ implementation
    
    for i = 1:gridsize
        A = compute_a(Grid(i), r, ad, x, y);
        E(i) = W(i)*(D(i) - A);
    end
end
