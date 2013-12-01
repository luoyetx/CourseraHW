I = double(imread('cameraman.jpg'));

SIGMA = 12;
N = 10;
h = zeros(2*N+1);
for n1 = -N:N
for n2 = -N:N
h((n1 + N + 1), (n2 + N + 1)) = 1/(2*pi*SIGMA^2)*exp(-(n1^2 + n2^2)/(2*SIGMA^2));
end
end

I_blurred = conv2(I, h);
I_blurred = I_blurred((N+1):(size(I, 1) + N), (N + 1):(size(I, 2) + N));
I_sharphened = I - I_blurred;

figure
image(I_sharphened);
colormap(gray);
axis off
axis square
