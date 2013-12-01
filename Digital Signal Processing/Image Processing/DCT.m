I = double(imread('camera.jpg'));
nb_row = size(I, 1);
nb_col = size(I, 2);
I = I(:);

basis_matrix = get_dct2_vector(nb_row, nb_col);

I_projected = double(basis_matrix)*I;
I_projected(2049:end) = 0;

I_approx = basis_matrix\I_projected;
I_approx = reshape(I_approx, nb_row, nb_col);
figure
imagesc(I_approx)
colormap(gray)
axis off
axis square
