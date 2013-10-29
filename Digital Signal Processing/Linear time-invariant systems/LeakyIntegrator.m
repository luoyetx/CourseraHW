M = 10;
lambda = (M-1)/M;
h = (1-lambda)*lambda.^(0:99);
% Gaussian Noise
sigma2 = 0.1;
noise = sigma2 * rand(1, 2000);
% signals
x1 = sin(2*pi*40*(1:1000)/1000);
x2 = sin(2*pi*80*(1:1000)/1000);
x = [x1 x2];
xNoisy = noise + x;
% plot x, xNoisy
subn = 750:1250;
subplot(3, 1, 1);
ylabel('x'); plot(subn, x(subn));
subplot(3, 1, 2);
ylabel('xNoisy'); plot(subn, xNoisy(subn));
% apply the leaky integrator to the noisy signal
y = conv(xNoisy, h, 'vaild');
subplot(3, 1, 3);
ylabel('y'); plot(subn, y(subn));