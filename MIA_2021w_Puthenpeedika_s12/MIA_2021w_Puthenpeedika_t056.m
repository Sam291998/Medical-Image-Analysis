%% SAMSON DAVID PUTHENPEEDIKA

%% 56: decision tree
%
%#####################################################################
%!!!!!!!!!!!!!THE CODE TAKES AROUND 2-4 MINUTES TO EXECUTE !!!!!!!!!!!
%#####################################################################

%% a: binary decision tree (using fitctree())

I=imread('yellowlily.jpg');
GT_I=imread('yellowlily-segmented.png');

x=im2double(I(:,:,1));
y=im2double(I(:,:,2));
z=im2double(I(:,:,3));

a=[x(:) y(:) z(:)];
b=im2double(GT_I(:));

c_10=fitctree(a,b,"SplitCriterion","gdi","MaxNumSplits",10);
c_30=fitctree(a,b,"SplitCriterion","gdi","MaxNumSplits",30);
c_100=fitctree(a,b,"SplitCriterion","gdi","MaxNumSplits",100);

d_10=fitctree(a,b,"SplitCriterion","deviance","MaxNumSplits",10);
d_30=fitctree(a,b,"SplitCriterion","deviance","MaxNumSplits",30);
d_100=fitctree(a,b,"SplitCriterion","deviance","MaxNumSplits",100);

%% b: prediction

label_c_10=predict(c_10,a);
loss_c_10=loss(c_10,a,b);
im_c_10 = reshape(label_c_10,1632,1224);

label_c_30=predict(c_30,a);
loss_c_30=loss(c_30,a,b);
im_c_30 = reshape(label_c_30,1632,1224);

label_c_100=predict(c_100,a);
loss_c_100=loss(c_100,a,b);
im_c_100 = reshape(label_c_100,1632,1224);


label_d_10=predict(d_10,a);
loss_d_10=loss(d_10,a,b);
im_d_10 = reshape(label_d_10,1632,1224);

label_d_30=predict(d_30,a);
loss_d_30=loss(d_30,a,b);
im_d_30 = reshape(label_d_30,1632,1224);

label_d_100=predict(d_100,a);
loss_d_100=loss(d_100,a,b);
im_d_100 = reshape(label_d_100,1632,1224);

%% c: display

figure()
subplot(2,3,1)
imshowpair(GT_I,im_c_10,'Scaling','joint','ColorChannels','green-magenta')
title(["Composite RGB image (using Node Error fit)", ...
    "- Split maximum 10 nodes", ...
    "- Incorrect classification = "+(loss_c_10*100)+" %"])

subplot(2,3,2)
imshowpair(GT_I,im_c_30,'Scaling','joint','ColorChannels','green-magenta')
title(["Composite RGB image (using Node Error fit)", ...
    "- Split maximum 30 nodes", ...
    "- Incorrect classification = "+(loss_c_30*100)+" %"])

subplot(2,3,3)
imshowpair(GT_I,im_c_100,'Scaling','joint','ColorChannels','green-magenta')
title(["Composite RGB image (using Node Error fit)", ...
    "- Split maximum 100 nodes", ...
    "- Incorrect classification = "+(loss_c_100*100)+" %"])

subplot(2,3,4)
imshowpair(GT_I,im_d_10,'Scaling','joint','ColorChannels','green-magenta')
title(["Composite RGB image (using Cross Entropy fit)", ...
    "- Split maximum 10 nodes", ...
    "- Incorrect classification = "+(loss_d_10*100)+" %"])


subplot(2,3,5)
imshowpair(GT_I,im_d_30,'Scaling','joint','ColorChannels','green-magenta')
title(["Composite RGB image (using Cross Entropy fit)", ...
    "- Split maximum 30 nodes", ...
    "- Incorrect classification = "+(loss_d_30*100)+" %"])

subplot(2,3,6)
imshowpair(GT_I,im_d_100,'Scaling','joint','ColorChannels','green-magenta')
title(["Composite RGB image (using Cross Entropy fit)", ...
    "- Split maximum 100 nodes", ...
    "- Incorrect classification = "+(loss_d_100*100)+" %"])

