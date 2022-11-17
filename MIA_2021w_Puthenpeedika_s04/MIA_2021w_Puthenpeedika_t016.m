%Samson David Puthenpeedika
a=imread('eight.tif');
G_01=imnoise(a,"gaussian",0,0.02);
G_02=imnoise(a,"gaussian",0,0.07);
SP_01=imnoise(a,"salt & pepper",0.05);
SP_02=imnoise(a,"salt & pepper",0.09);
PSNR_1=psnr(G_01,a);
PSNR_2=psnr(G_02,a);
PSNR_3=psnr(SP_01,a);
PSNR_4=psnr(SP_02,a);
disp("PSNR (Gaussian noise of variance 0.02)= "+PSNR_1);
disp("PSNR (Gaussian noise of variance 0.07)= "+PSNR_2);
disp("PSNR (Salt and Pepper noise density 0.05)= "+PSNR_3);
disp("PSNR (Salt and Pepper noise density 0.09)= "+PSNR_4);
disp("  ");
disp("  ");

%for G_01
WG_11=wiener2(G_01,[3 2],0.02);
W_11=wiener2(G_01,[3 2]);
PSNR_WG11=psnr(WG_11,a);
PSNR_W11=psnr(W_11,a);
disp("FOR IMAGE WITH GAUSSIAN NOISE OF VARIANCE 0.02");
disp("PSNR of Wiener filtered image [3 2] (providing the real noise variances)= "+PSNR_WG11);
disp("PSNR of Wiener filtered image [3 2] (WITHOUT the real noise variances)= "+PSNR_W11);

WG_12=wiener2(G_01,[5 7],0.02);
W_12=wiener2(G_01,[5 7]);
PSNR_WG12=psnr(WG_12,a);
PSNR_W12=psnr(W_12,a);
disp("PSNR of Wiener filtered image [5 7] (providing the real noise variances)= "+PSNR_WG12);
disp("PSNR of Wiener filtered image [5 7] (WITHOUT the real noise variances)= "+PSNR_W12);
disp("  ");
disp("  ");


%for G_02
WG_21=wiener2(G_02,[3 2],0.07);
W_21=wiener2(G_02,[3 2]);
PSNR_WG21=psnr(WG_21,a);
PSNR_W21=psnr(W_21,a);
disp("FOR IMAGE WITH GAUSSIAN NOISE OF VARIANCE 0.07");
disp("PSNR of Wiener filtered image [3 2] (providing the real noise variances)= "+PSNR_WG21);
disp("PSNR of Wiener filtered image [3 2] (WITHOUT the real noise variances)= "+PSNR_W21);

WG_22=wiener2(G_02,[5 7],0.07);
W_22=wiener2(G_02,[5 7]);
PSNR_WG22=psnr(WG_22,a);
PSNR_W22=psnr(W_22,a);
disp("PSNR of Wiener filtered image [5 7] (providing the real noise variances)= "+PSNR_WG22);
disp("PSNR of Wiener filtered image [5 7] (WITHOUT the real noise variances)= "+PSNR_W22);
disp("  ");
disp("  ");


%for SP_01
W_31=wiener2(SP_01,[3 2]);
W_32=wiener2(SP_01,[5 7]);
PSNR_W31=psnr(W_31,a);
PSNR_W32=psnr(W_32,a);
disp("FOR IMAGE WITH SALT AND PEPPER NOISE OF DENSITY 0.05");
disp("PSNR of Wiener filtered image [3 2] (WITHOUT the real noise variances)= "+PSNR_W31);
disp("PSNR of Wiener filtered image [5 7] (WITHOUT the real noise variances)= "+PSNR_W32);
disp("  ");
disp("  ");


%for SP_04
W_41=wiener2(SP_02,[3 2]);
W_42=wiener2(SP_02,[5 7]);
PSNR_W41=psnr(W_41,a);
PSNR_W42=psnr(W_42,a);
disp("FOR IMAGE WITH SALT AND PEPPER NOISE OF DENSITY 0.09");
disp("PSNR of Wiener filtered image [3 2] (WITHOUT the real noise variances)= "+PSNR_W41);
disp("PSNR of Wiener filtered image [5 7] (WITHOUT the real noise variances)= "+PSNR_W42);
disp("  ");
disp("  ");


figure(1)
subplot(3,2,1)
imshow(a);
title("Orginal Image");
subplot(3,2,2)
imshow(G_01);
title({"Image with Gaussian noise of variance 0.02";"PSNR= "+PSNR_1});
subplot(3,2,3)
imshow(WG_11);
title({"Wiener filtered image with neighborhood sizes [3 2] ,with the real noise variance 0.02";"PSNR= "+PSNR_WG11});
subplot(3,2,4)
imshow(W_11);
title({"Wiener filtered image with neighborhood sizes [3 2] ,without the real noise variance";"PSNR= "+PSNR_W11})
subplot(3,2,5)
imshow(WG_12);
title({"Wiener filtered image with neighborhood sizes [5 7] ,with the real noise variance 0.02";"PSNR= "+PSNR_WG12})
subplot(3,2,6)
imshow(W_12);
title({"Wiener filtered image with neighborhood sizes [5 7] ,without the real noise variance";"PSNR= "+PSNR_W12})


figure(2)
subplot(3,2,1)
imshow(a);
title("Orginal Image");
subplot(3,2,2)
imshow(G_02);
title({"Image with Gaussian noise of variance 0.07";"PSNR= "+PSNR_2});
subplot(3,2,3)
imshow(WG_21);
title({"Wiener filtered image with neighborhood sizes [3 2] ,with the real noise variance 0.07";"PSNR= "+PSNR_WG21})
subplot(3,2,4)
imshow(W_21);
title({"Wiener filtered image with neighborhood sizes [3 2] ,without the real noise variance";"PSNR= "+PSNR_W21})
subplot(3,2,5)
imshow(WG_22);
title({"Wiener filtered image with neighborhood sizes [5 7] ,with the real noise variance 0.07";"PSNR= "+PSNR_WG22})
subplot(3,2,6)
imshow(W_22);
title({"Wiener filtered image with neighborhood sizes [5 7] ,without the real noise variance";"PSNR= "+PSNR_W22})

figure(3)
subplot(2,2,1)
imshow(a);
title("Orginal Image");
subplot(2,2,2)
imshow(SP_01);
title({"Image with Salt-and-Pepper noise of density 0.05";"PSNR= "+PSNR_3});
subplot(2,2,3)
imshow(W_31);
title({"Wiener filtered image with neighborhood sizes [3 2]";"PSNR= "+PSNR_W31})
subplot(2,2,4)
imshow(W_32);
title({"Wiener filtered image with neighborhood sizes [5 7] ";"PSNR= "+PSNR_W32})

figure(4)
subplot(2,2,1)
imshow(a);
title("Orginal Image");
subplot(2,2,2)
imshow(SP_01);
title({"Image with Salt-and-Pepper noise of density 0.09";"PSNR= "+PSNR_4});
subplot(2,2,3)
imshow(W_41);
title({"Wiener filtered image with neighborhood sizes [3 2] ";"PSNR= "+PSNR_W41})
subplot(2,2,4)
imshow(W_42);
title({"Wiener filtered image with neighborhood sizes [5 7] ";"PSNR= "+PSNR_W42})






