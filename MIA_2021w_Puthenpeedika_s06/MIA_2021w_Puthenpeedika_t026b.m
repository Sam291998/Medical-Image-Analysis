% Samson David Puthenpeedika

I=imread('circlesBrightDark.png');
se=strel('disk',40);
E=imtophat(I,se);
se1=strel('disk',15);
F=imopen(E,se1);


figure()
subplot(2,3,1)
imshow(I);
title("ORGINAL IMAGE")
axis on

subplot(2,3,2)
imshow(se.Neighborhood);
title(["STRUCTURING ELEMENT";"(for top-hat transform)"])
axis on
subplot(2,3,3)
imshow(E);
title(["IMAGE after Enchancing";"(the smallest bright circle)"]);
axis on

subplot(2,3,4.5)
imshow(se1.Neighborhood);
title(["STRUCTURING ELEMENT";"(for opening)"])
axis on
subplot(2,3,5.5)
imshow(F);
title(["FILTERED IMAGE";"(eliminating the objects not related to the circle)"]);
axis on


