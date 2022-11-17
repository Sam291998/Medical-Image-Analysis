% Samson David Puthenpeedika

fixed_Img=  imread("viprectification_deskLeft.png");
moving_Img= imread("viprectification_deskRight.png");


%% a: feature points

gray_fixed_Img=  im2gray(fixed_Img);
gray_moving_Img= im2gray(moving_Img);

BriskPoints_fixed_Img=  detectBRISKFeatures(gray_fixed_Img);
BriskPoints_moving_Img= detectBRISKFeatures(gray_moving_Img);

[features_fixed_Img,validpoints_fixed]=  extractFeatures(gray_fixed_Img,BriskPoints_fixed_Img);
[features_moving_Img,validpoints_moved]= extractFeatures(gray_moving_Img,BriskPoints_moving_Img);

indexPairs = matchFeatures(features_fixed_Img,features_moving_Img);

%% b: geometric transformation

fixedPoints = validpoints_fixed(indexPairs(:,1),:);
movingPoints = validpoints_moved(indexPairs(:,2),:);

tform= fitgeotrans(movingPoints.Location,fixedPoints.Location,"projective");
r=imref2d(size(gray_fixed_Img));
[Registered_image, RB]=imwarp(gray_moving_Img,tform,"OutputView",r);

figure()
subplot(1,2,1)
x=showMatchedFeatures(gray_fixed_Img,gray_moving_Img,fixedPoints,movingPoints);

subplot(1,2,2)
y=imshowpair(gray_fixed_Img,Registered_image,"falsecolor");
title(mat2cell(tform.T))








