% Samson David Puthenpeedika
c=imread("cameraman.tif");

T=[1 1 1 1 1;
   0 0 1 0 0;
   0 0 1 0 0;
   0 0 1 0 0;
   0 0 1 0 0];

mini = ordfilt2(c,1,T);
median = ordfilt2(c,5,T);
max= ordfilt2(c,9,T);

figure()
subplot(2,3,1.5)
imshow(c);
title("ORGINAL IMAGE")
axis on

subplot(2,3,2.5)
imshow(T);
title(["T-shaped NEIGHBOURHOOD";"(filter)"])
axis on
subplot(2,3,4)
imshow(mini);
title(["FILTERED IMAGE";"(MINIMUM FILTER )"]);
axis on

subplot(2,3,5)
imshow(median);
title(["FILTERED IMAGE";"(MEDIAN FILTER)"])
axis on
subplot(2,3,6)
imshow(max);
title(["FILTERED IMAGE";"(MAXIMUM FILTER)"]);
axis on
