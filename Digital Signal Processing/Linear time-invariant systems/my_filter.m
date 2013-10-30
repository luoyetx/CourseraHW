function y = my_filter(x, b, a)
% Implementation of the filter in direct form
% y[n] - a(2)y[n-1] - ... - a(na)y[n - na + 1] = b(1)x[n] + b(2)x[n-1] + ... b(nb)x[n - nb + 1]

% Make sure a and b are columns
a = a(:);
b = b(:);
x = x(:);

% Make sure first element of a is equal to 1
if a(1) ~= 1
    a = a/a(1);
    b = b/b(1);
end

% Extract parameters
na = length(a);
nb = length(b);
nx = length(x);

% Zero padding
y = zeros(nx, 1);
y = [zeros(na - 1, 1); y];
x = [zeros(nb - 1, 1); x];

% Filter
for n = 1:nx
    if na > 1
        y(n + na -1) = -a(2:na)'*y(n + na -2:-1:n) + b'*x(n + nb - 1:-1:n);
    else
        y(n + na -1) = b(1:nb)'*x(n + nb - 1:-1:n);
    end
end

% Return output
y = y(na:nx + na - 1);

