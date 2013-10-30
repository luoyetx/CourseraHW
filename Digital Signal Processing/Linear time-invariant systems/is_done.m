function status = is_done(r, Ext, E)
    % Checks to see if the error function is small enough to consider
    % the result to have converged.
    %
    % INPUT:
    % ------
    % int    r     - 1/2 the number of filter coeffiecients
    % int    Ext[] - Indexes to extremal frequencies [r+1]
    % double E[]   - Error function on the dense grid [gridsize]
    %
    % OUTPUT:
    % -------
    % Returns 1 if the result converged
    % Returns 0 if the result has not converged
    
    minimum = min(abs(E(Ext)));
    maximum = max(abs(E(Ext)));
    status = logical(((maximum - minimum)/maximum) < 0.0001);
end