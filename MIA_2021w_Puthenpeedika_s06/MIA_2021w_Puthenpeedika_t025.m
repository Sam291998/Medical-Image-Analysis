% Samson David Puthenpeedika

i = imread('text.png');

Y = i(175:187,202:218);                  
SE = strel(Y);        
erode = imerode(i,SE) ;                 
dilate = imdilate(erode,SE);           
skeleton = bwmorph(dilate,'skel',Inf);    


figure
subplot(2,2,1)
imshow(i)
axis on
title('Original Image')

subplot(2,2,2)
imshow(Y)
axis on
title('Designed Structuring Element')

subplot(2,2,3)
imshow(dilate)
axis on
title('Filtered Image')

subplot(2,2,4)
imshow(skeleton);
axis on
title('Skeleton Image')