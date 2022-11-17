% Samson David Puthenpeedika

% NOISE MODEL
I=imread('cameraman.tif');
a=im2double(I);
noisy_img=imnoise(a,"gaussian",0,0.02);

% WAVELET DECOMPOSITION

[C,S]=wavedec2(noisy_img,2,'haar');

[H1,V1,D1] = detcoef2('all',C,S,1);
A1 = appcoef2(C,S,'haar',1);

[H2,V2,D2] = detcoef2('all',C,S,2);
A2 = appcoef2(C,S,'haar',2);

V1img = wcodemat(V1,255,'mat',1);
H1img = wcodemat(H1,255,'mat',1);
D1img = wcodemat(D1,255,'mat',1);
A1img = wcodemat(A1,255,'mat',1);

V2img = wcodemat(V2,255,'mat',1);
H2img = wcodemat(H2,255,'mat',1);
D2img = wcodemat(D2,255,'mat',1);
A2img = wcodemat(A2,255,'mat',1);

figure(1)
subplot(2,4,1)
imagesc(A1img)
colormap pink(255);
title('Approximation Coef. of Level 1')

subplot(2,4,2)
imagesc(H1img);
title('Horizontal Detail Coef. of Level 1')

subplot(2,4,3)
imagesc(V1img);
title('Vertical Detail Coef. of Level 1')

subplot(2,4,4)
imagesc(D1img);
title('Diagonal Detail Coef. of Level 1')

subplot(2,4,5)
imagesc(A2img);
colormap pink(255);
title('Approximation Coef. of Level 2')

subplot(2,4,6)
imagesc(H2img);
title('Horizontal Detail Coef. of Level 2')

subplot(2,4,7)
imagesc(V2img);
title('Vertical Detail Coef. of Level 2')

subplot(2,4,8)
imagesc(D2img);
title('Diagonal Detail Coef. of Level 2')

% HARD THRESHOLDING

n = [1 2];
t = [0.3 0.3];                          % define one threshold of the detail coefficients
NC = wthcoef2('t',C,S,n,t,'h');


A11 = appcoef2(NC,S,'haar',1);
[H11,V11,D11] = detcoef2('all',NC,S,1);

A22 = appcoef2(NC,S,'haar',2);
[H22,V22,D22] = detcoef2('all',NC,S,2);


% setting the detail coefficients at all levels with the absolute value less than the threshold to 0
H11=abs(H11);
V11=abs(V11);
D11=abs(D11);

H22=abs(H22);
V22=abs(V22);
D22=abs(D22);


V1img1 = wcodemat(V11,255,'mat',1);
H1img1 = wcodemat(H11,255,'mat',1);
D1img1 = wcodemat(D11,255,'mat',1);
A1img1 = wcodemat(A11,255,'mat',1);


V2img1 = wcodemat(V22,255,'mat',1);
H2img1 = wcodemat(H22,255,'mat',1);
D2img1 = wcodemat(D22,255,'mat',1);
A2img1 = wcodemat(A22,255,'mat',1);

figure(2)
subplot(2,4,1)
imagesc(A1img1);
colormap pink(255);
title('Approximation Coef. of Level 1','with hard thresholding 0.3')

subplot(2,4,2)
imagesc(H1img1);
title('Horizontal Detail Coef. of Level 1','with hard thresholding 0.3')

subplot(2,4,3)
imagesc(V1img1);
title('Vertical Detail Coef. of Level 1','with hard thresholding 0.3')

subplot(2,4,4)
imagesc(D1img1);
title('Diagonal Detail Coef. of Level 1','with hard thresholding 0.3')

subplot(2,4,5)
imagesc(A2img1)
colormap pink(255);
title('Approximation Coef. of Level 2','with hard thresholding 0.3')

subplot(2,4,6)
imagesc(H2img1);
title('Horizontal Detail Coef. of Level 2','with hard thresholding 0.3')

subplot(2,4,7)
imagesc(V2img1);
title('Vertical Detail Coef. of Level 2','with hard thresholding 0.3')

subplot(2,4,8)
imagesc(D2img1);
title('Diagonal Detail Coef. of Level 2','with hard thresholding 0.3')



% WAVELET RECONSTRUCTION
x1= waverec2(NC,S,'haar');
diff= imabsdiff(a,x1);

figure(3)
subplot(2,2,1)
imshow(a);
title("Orginal")
subplot(2,2,2)
imshow(noisy_img);
title("Noisy image")
subplot(2,2,3)
imshow(x1);
title("Denoised image")
subplot(2,2,4)
imshow(diff,[]);
title("The Difference of The Original Image and The Denoised Image")