function Ext = compute_initial_guess(r, gridsize)
    % Places Extremal Frequencies evenly throughout the dense grid.
    %
    %
    % INPUT: 
    % ------
    % r        - 1/2 the number of filter coefficients
    % gridsize - Number of elements in the dense frequency grid
    %
    % OUTPUT:
    % -------
    % Ext    - Extremal indexes to dense frequency grid [r+1]
    
    % Based on Janavetz C++ implementation

    Ext = [floor((gridsize - 1)/r)*(0:r - 1)' + 1; gridsize];
   
end
