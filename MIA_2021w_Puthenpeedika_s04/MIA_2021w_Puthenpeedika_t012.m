%Samson David Puthenpeedika


o=imread('rice.png');
fx=fspecial("sobel");
fy=transpose(fx);
d=im2double(o);
Gx=imfilter(d,fx);
Gy=imfilter(d,fy);
[Gmag,Gdir]=imgradient(Gx,Gy);

figure(1)
subplot(1,3,1)
imshow(o);
title("Orginal Image");
subplot(1,3,2)
imshow(Gx);
title("Filtered Image X-gradient component");
subplot(1,3,3)
imshow(Gy);
title("Filtered Image Y-gradient component");

figure(2)
subplot(2,2,1)
imshow(Gmag);
title("Approximated Gradient Magnitude");

subplot(2,2,2)
imshow(Gdir);
title("Approximated Gradient Orientation(degrees)");

subplot(2,2,3)
histogram(Gmag);
title("Histogram of Approximated Gradient Magnitude");
subplot(2,2,4)
histogram(Gdir);
title("Histogram of Approximated Gradient Orientation(degrees)");



