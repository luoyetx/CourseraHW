function[] = recover()

    % Load image
    I = imread('camera.jpg');

    % Arrange image in column vector
    I = I(:);

    % Generate Haar basis vector (rows of H)
    H = haar(4096);
    % fix MTIMES error
    I = double(I);
    % Project image on the new basis
    I_haar = H * I;

    % Remove the second half of the coefficient
    I_haar(2049:4096) = 0;

    % Recover the image by inverting change of basis
    I_haar = H'*I_haar;

    % Rearrange pixels of the image
    I_haar = reshape(I_haar, 64, 64);

    % Display image
    figure
    image(I_haar)
    colormap(gray)
end