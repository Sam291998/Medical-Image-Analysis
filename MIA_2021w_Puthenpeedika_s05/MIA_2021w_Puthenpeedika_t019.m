% Samson David Puthenpeedika

b=imread('lighthouse.png');
bdouble=im2double(b);
seed=0;
var=0.04;
[gaussian, PSD1, kernel1] = getExperimentNoise('gw',var, seed, size(bdouble));
[circular, PSD2, kernel2] = getExperimentNoise('g2',var, seed, size(bdouble));
[diagonal, PSD3, kernel3] = getExperimentNoise('g3',var, seed, size(bdouble));

gaussian_noisy_img= bdouble + gaussian;
circular_noisy_img= bdouble + circular;
diagonal_noisy_img= bdouble + diagonal;

psnr1 = getPSNR(bdouble, gaussian_noisy_img);
psnr2 = getPSNR(bdouble, circular_noisy_img);
psnr3 = getPSNR(bdouble, diagonal_noisy_img);

thr = 0.04; k = [5 5];
% GAUSSIAN NOISE
g_hard_1 = BM3D(gaussian_noisy_img, PSD1);                %Hard thresholding without refiltering
g_hr_1 = BM3D(gaussian_noisy_img, PSD1, 'refilter');                      %Hard thresholding with refiltering
g_wie = wiener2(rgb2gray(gaussian_noisy_img),k);                %Wiener filtering without refiltering
g_wie_r = BM3D(g_wie, PSD1, 'refilter');                        %Wiener filtering with refiltering

psnr4 = getPSNR(bdouble, g_hard_1);
psnr5 = getPSNR(bdouble, g_hr_1);
psnr6 = getPSNR(bdouble, g_wie);
psnr7 = getPSNR(bdouble, g_wie_r);

% CIRCULAR NOISE
c_hard_1 = wthresh(circular_noisy_img,'h',thr);                 %Hard thresholding without refiltering
c_hr_1 = BM3D(c_hard_1, PSD1, 'refilter');                      %Hard thresholding with refiltering
c_wie = wiener2(rgb2gray(circular_noisy_img),k);                %Wiener filtering without refiltering
c_wie_r = BM3D(c_wie, PSD2, 'refilter');                        %Wiener filtering with refiltering

psnr8 = getPSNR(bdouble, c_hard_1);
psnr9 = getPSNR(bdouble, c_hr_1);
psnr10 = getPSNR(bdouble, c_wie);
psnr11= getPSNR(bdouble, c_wie_r);

% DIAGNOL NOISE

d_hard_1 = wthresh(diagonal_noisy_img,'h',thr);                 %Hard thresholding without refiltering
d_hr_1 = CBM3D(d_hard_1, PSD3, 'refilter');                     %Hard thresholding with refiltering
d_wie = wiener2(rgb2gray(diagonal_noisy_img),k);                %Wiener filtering without refiltering
d_wie_r = BM3D(c_wie, PSD3, 'refilter');                       %Wiener filtering with refiltering

psnr12 = getPSNR(bdouble, c_hard_1);
psnr13 = getPSNR(bdouble, c_hr_1);
psnr14 = getPSNR(bdouble, c_wie);
psnr15= getPSNR(bdouble, c_wie_r);



% display
figure(1)
subplot(3,3,1),imshow(gaussian),title('Noise field of noise gw with variance 0:04')
subplot(3,3,2),imshow(PSD1),title('Power spectral density of noise gw with variance 0:04')
subplot(3,3,3),imshow(kernel1),title('Correlation kernel of noise gw with variance 0:04')
subplot(3,3,4),imshow(bdouble),title('Original image')
subplot(3,3,5),imshow(gaussian_noisy_img),title(['Noise image with variance 0:04; PSNR ', num2str(psnr1)])
subplot(3,3,6),imshow(g_hard_1),title(['Hard thresholding without refiltering; PSNR ', num2str(psnr4)])
subplot(3,3,7),imshow(g_hr_1),title(['Hard thresholding with refiltering; PSNR ', num2str(psnr5)])
subplot(3,3,8),imshow(g_wie),title(['Wiener filtering without refiltering', num2str(psnr6)])
subplot(3,3,9),imshow(g_wie_r),title(['Wiener filtering with refiltering', num2str(psnr7)])
sgtitle('Gaussian white noise') 

figure(2)
subplot(3,3,1),imshow(circular),title('Noise field of noise g2 with variance 0:04')
subplot(3,3,2),imshow(PSD2),title('Power spectral density of noise g2 with variance 0:04')
subplot(3,3,3),imshow(kernel2),title('Correlation kernel of noise g2 with variance 0:04')
subplot(3,3,4),imshow(bdouble),title('Original image')
subplot(3,3,5),imshow(circular_noisy_img),title(['Noise image with variance 0:04; PSNR ', num2str(psnr2)])
subplot(3,3,6),imshow(c_hard_1),title(['Hard thresholding without refiltering; PSNR ', num2str(psnr8)])
subplot(3,3,7),imshow(c_hr_1),title(['Hard thresholding with refiltering; PSNR ', num2str(psnr9)])
subplot(3,3,8),imshow(c_wie),title(['Wiener filtering without refiltering', num2str(psnr10)])
subplot(3,3,9),imshow(c_wie_r),title(['Wiener filtering with refiltering', num2str(psnr11)])
sgtitle('Circular repeating pattern noise') 


figure(3)
subplot(3,3,1),imshow(diagonal),title('Noise field of noise g3 with variance 0:04')
subplot(3,3,2),imshow(PSD3),title('Power spectral density of noise g3 with variance 0:04')
subplot(3,3,3),imshow(kernel3),title('Correlation kernel of noise g3 with variance 0:04')
subplot(3,3,4),imshow(bdouble),title('Original image')
subplot(3,3,5),imshow(diagonal_noisy_img),title(['Noise image with variance 0:04; PSNR ', num2str(psnr3)])
subplot(3,3,6),imshow(d_hard_1),title(['Hard thresholding without refiltering; PSNR ', num2str(psnr12)])
subplot(3,3,7),imshow(d_hr_1),title(['Hard thresholding with refiltering; PSNR ', num2str(psnr13)])
subplot(3,3,8),imshow(d_wie),title(['Wiener filtering without refiltering', num2str(psnr14)])
subplot(3,3,9),imshow(d_wie_r),title(['Wiener filtering with refiltering', num2str(psnr15)])
sgtitle('Diagonal line pattern noise') 



