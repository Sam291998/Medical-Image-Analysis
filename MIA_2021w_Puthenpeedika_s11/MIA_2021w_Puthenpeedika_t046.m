% Samson David Puthenpeedika

%%  46: deformable image registration

%% a: crop images

moving_img= imread("AT3_1m4_02.tif");
fixed_img=  imread("AT3_1m4_03.tif");

crp_mv_img=imcrop(moving_img, [235, 210, 100, 100]);
crp_fx_img=imcrop(fixed_img, [235, 210, 100, 100]);
mse_1=immse(crp_fx_img,crp_mv_img);


%% b: deformable registration (using imregdemons())

[D,reg_img]=imregdemons(crp_mv_img,crp_fx_img,[500 250],'AccumulatedFieldSmoothing',1.5,'PyramidLevels',2);

mask=reg_img~=0;
mse_2=immse(reg_img(mask),crp_fx_img(mask));

[Dmag,Ddir] = imgradient(D(:,:,1),D(:,:,2));


%% c: display

figure()
subplot(2,2,1)
imshowpair(crp_mv_img,crp_fx_img,'Scaling','joint')
title(["Cropped Fixed-Moving Image pair","MSE- "+mse_1])

subplot(2,2,2)
imshowpair(reg_img,crp_fx_img,'Scaling','joint')
title(["Fixed-Registered Image Pair","MSE- "+mse_2])

subplot(2,2,3)
imshow(Dmag,[])
title("Image of Approximated Displacement MAGNITUDE")
cmap1=colormap("jet");
colorbar

subplot(2,2,4)
imshow(Ddir,[])
title("Image of Approximated Displacement ORIENTATION")
cmap2=colormap("hsv");
colorbar



