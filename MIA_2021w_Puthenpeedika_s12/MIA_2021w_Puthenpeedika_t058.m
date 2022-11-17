%% SAMSON DAVID PUTHENPEEDIKA

%% 58: boosting
%
%#####################################################################
%!!!!!!!!!!!!!THE CODE TAKES AROUND 5-7 MINUTES TO EXECUTE !!!!!!!!!!!
%#####################################################################


%% a: boosting (using fitcensemble())

I=imread('yellowlily.jpg');
GT_I=imread('yellowlily-segmented.png');

x=im2double(I(:,:,1));
y=im2double(I(:,:,2));
z=im2double(I(:,:,3));

a=[x(:) y(:) z(:)];
b=im2double(GT_I(:));

e_1 = fitcensemble(a,b,"Method","AdaBoostM2","Learners","discriminant","NumLearningCycles",1);
e_10= fitcensemble(a,b,"Method","AdaBoostM2","Learners","discriminant","NumLearningCycles",10);
e_40= fitcensemble(a,b,"Method","AdaBoostM2","Learners","discriminant","NumLearningCycles",40);

f_1 = fitcensemble(a,b,"Method","AdaBoostM2","Learners","tree","NumLearningCycles",1);
f_10= fitcensemble(a,b,"Method","AdaBoostM2","Learners","tree","NumLearningCycles",10);
f_40= fitcensemble(a,b,"Method","AdaBoostM2","Learners","tree","NumLearningCycles",40);

%% b: prediction

label_e_1=predict(e_1,a);
loss_e_1=loss(e_1,a,b);
im_e_1 = reshape(label_e_1,1632,1224);

label_e_10=predict(e_10,a);
loss_e_10=loss(e_10,a,b);
im_e_10 = reshape(label_e_10,1632,1224);

label_e_40=predict(e_40,a);
loss_e_40=loss(e_40,a,b);
im_e_40 = reshape(label_e_40,1632,1224);


label_f_1=predict(f_1,a);
loss_f_1=loss(f_1,a,b);
im_f_1 = reshape(label_f_1,1632,1224);

label_f_10=predict(f_10,a);
loss_f_10=loss(f_10,a,b);
im_f_10 = reshape(label_f_10,1632,1224);

label_f_40=predict(f_40,a);
loss_f_40=loss(f_40,a,b);
im_f_40 = reshape(label_f_40,1632,1224);

%% c: display

figure()
subplot(2,3,1)
imshowpair(GT_I,im_e_1,'Scaling','joint','ColorChannels',[1 2 1])
title(["Composite RGB image (Discriminant classifier)", ...
    "- Adaptive boosting ensemble of 1 classifier", ...
    "- Incorrect classification = "+(loss_e_1*100)+" %"])

subplot(2,3,2)
imshowpair(GT_I,im_e_10,'Scaling','joint','ColorChannels',[1 2 1])
title(["Composite RGB image (Discriminant classifier)", ...
    "- Adaptive boosting ensemble of 10 classifier", ...
    "- Incorrect classification = "+(loss_e_10*100)+" %"])

subplot(2,3,3)
imshowpair(GT_I,im_e_40,'Scaling','joint','ColorChannels',[1 2 1])
title(["Composite RGB image (Discriminant classifier)", ...
    "- Adaptive boosting ensemble of 40 classifier", ...
    "- Incorrect classification = "+(loss_e_40*100)+" %"])

subplot(2,3,4)
imshowpair(GT_I,im_f_1,'Scaling','joint','ColorChannels',[1 2 1])
title(["Composite RGB image (Decision Tree classifier)", ...
    "- Adaptive boosting ensemble of 1 classifier", ...
    "- Incorrect classification = "+(loss_f_1*100)+" %"])

subplot(2,3,5)
imshowpair(GT_I,im_f_10,'Scaling','joint','ColorChannels',[1 2 1])
title(["Composite RGB image (Decision Tree classifier)", ...
    "- Adaptive boosting ensemble of 10 classifier", ...
    "- Incorrect classification = "+(loss_f_10*100)+" %"])

subplot(2,3,6)
imshowpair(GT_I,im_f_40,'Scaling','joint','ColorChannels',[1 2 1])
title(["Composite RGB image (Decision Tree classifier)", ...
    "- Adaptive boosting ensemble of 40 classifier", ...
    "- Incorrect classification = "+(loss_f_40*100)+" %"])


