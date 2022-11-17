%Samson David Puthenpeedika
I=im2double(imread("eight.tif"));
G_img=imnoise(I,"gaussian",0,0.02);
bin_img=imbinarize(G_img,"global");
BW_0=activecontour(G_img,bin_img,500,"Chan-vese","SmoothFactor",0);
BW_1=activecontour(G_img,bin_img,500,"Chan-vese","SmoothFactor",1.5);


figure()
subplot(2,2,1)
imshow(G_img);
title("Noisy Image")

subplot(2,2,2)
imshow(bin_img);
title("Binarized Image")

subplot(2,2,3)
imshow(BW_0);
title(["Segmented Image using Active contour (Chan-Vese method)","Smoothness Value = 0"]);

subplot(2,2,4)
imshow(BW_1);
title(["Segmented Image using Active contour (Chan-Vese method)","Smoothness Value = 1.5"]);