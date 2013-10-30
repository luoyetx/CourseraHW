function Ext = search(r, Ext, gridsize, E)
    % Searches for the maxima/minima of the error curve.  If more than
    % r+1 extrema are found, it uses the following heuristic (thanks
    % Chris Hanson):
    % 1) Adjacent non-alternating extrema deleted first.
    % 2) If there are more than one excess extrema, delete the
    %    one with the smallest error.  This will create a non-alternation
    %    condition that is fixed by 1).
    % 3) If there is exactly one excess extremum, delete the smaller
    %    of the first/last extremum
    %
    % INPUT:
    % ------
    % r        - 1/2 the number of filter coefficients
    % Ext    - Indexes to Grid of extremal frequencies [r+1]
    % gridsize - Number of elements in the dense frequency grid
    % E      - Array of error values.  [gridsize]
    
    % OUTPUT:
    % -------
    % Ext    - New indexes to extremal frequencies [r+1]
    
    % Based on Janavetz C++ implementation
    
    k = 0;
    
    % Check for extremum at 0.
    if (((E(1)>0.0) && (E(1)>E(2))) || ((E(1)<0.0) && (E(1)<E(2))))
        k = k+1;
        foundExt(k) = 1;
    end
    
    % Check for extrema inside dense grid
    for i = 2:(gridsize - 1)
        if (((E(i)>=E(i-1)) && (E(i)>=E(i+1)) && (E(i)>0.0)) || ((E(i)<=E(i-1)) && (E(i)<=E(i+1)) && (E(i)<0.0)))
            % if (k >= 2*r) 
            %    error('Too many extrema found.');
            % end
            k = k+1;
            foundExt(k) = i;
        end
    end
    
    % Check for extremum at 0.5
    j = gridsize;
    if (((E(j)>0.0) && (E(j)>E(j-1))) || ((E(j)<0.0) && (E(j)<E(j-1))))
        % if (k >= 2*r)
        %     error('Too many extrema found.');
        % end
        k = k+1;
        foundExt(k) = j;
    end
    
    if (k < r+1) 
        error('Not enough extrema');
    end
    
    
    % Remove extra extremals
    extra = k - (r+1);
    
    while (extra > 0)
        if (E(foundExt(1)) > 0.0)
            up = 1;   
        else
            up = 0;
        end         
        
        l = 1;
        alt = 1;
        for j = 2:k
            if (abs(E(foundExt(j))) < abs(E(foundExt(l))))
                l = j;
            end 
            if ((up) && (E(foundExt(j)) < 0.0))
                up = 0;
            elseif ((~up) && (E(foundExt(j)) > 0.0))
                up = 1; 
            else
                alt = 0;
                if (abs(E(foundExt(j))) < abs(E(foundExt(j-1))))
                    l=j;
                else 
                    l=j-1;
                end
                break;             
            end 
        end % if the loop finishes, all extrema are alternating */
        
        % If there's only one extremal and all are alternating,
        % delete the smallest of the first/last extremals.
        if ((alt == 1) && (extra == 1))
            if (abs(E(foundExt(k))) < abs(E(foundExt(1))))
                l = k;
            else
                l = 1;
            end
        end
        
        foundExt = [foundExt(1:l-1) foundExt(l+1:end)];
        k = k-1;
        extra = extra- 1;
        
    end % end while
    
    % Replace Ext by new value
    Ext = foundExt;
    
end
