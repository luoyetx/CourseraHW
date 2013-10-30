function A = compute_a(freq, r, ad, x, y)
    
    denom = 0;
    numer = 0;
    xc = cos(2*pi*freq);
    for i = 1:(r + 1)
        c = xc - x(i);
        if (abs(c) < 1.0^-7)
            numer = y(i);
            denom = 1;
            break;
        end
        c = ad(i)/c;
        denom = denom + c;
        numer = numer + c*y(i);
    end
    
    A = numer/denom;
    
end