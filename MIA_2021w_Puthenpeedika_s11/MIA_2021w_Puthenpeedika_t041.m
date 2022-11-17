% Samson David Puthenpeedika


%% 41: monomodal image registration

%% a: crop images

moving_img= imread("AT3_1m4_02.tif");
fixed_img=  imread("AT3_1m4_03.tif");

crp_mv_img=imcrop(moving_img, [235, 210, 100, 100]);
crp_fx_img=imcrop(fixed_img, [235, 210, 100, 100]);
mse_1=immse(crp_fx_img,crp_mv_img);

figure(1)
subplot(2,3,1)
imshowpair(crp_mv_img,crp_fx_img,'Scaling','joint')
title(["Cropped Fixed-Moving Image pair","MSE- "+mse_1])

%% b: registration with different transform types

[optimizer,metric] = imregconfig('monomodal');
reg_img_trans= imregister(crp_mv_img,crp_fx_img,'translation',optimizer,metric);
reg_img_rigi=  imregister(crp_mv_img,crp_fx_img,'rigid',optimizer,metric);
reg_img_simi=  imregister(crp_mv_img,crp_fx_img,'similarity',optimizer,metric);
reg_img_affi=  imregister(crp_mv_img,crp_fx_img,'affine',optimizer,metric);

mask_trans=reg_img_trans~=0;
mse_2=immse(reg_img_trans(mask_trans),crp_fx_img(mask_trans));

mask_rigi=reg_img_rigi~=0;
mse_3=immse(reg_img_rigi(mask_rigi),crp_fx_img(mask_rigi));

mask_simi=reg_img_simi~=0;
mse_4=immse(reg_img_simi(mask_simi),crp_fx_img(mask_simi));

mask_affi=reg_img_affi~=0;
mse_5=immse(reg_img_affi(mask_affi),crp_fx_img(mask_affi));

subplot(2,3,2)
imshowpair(reg_img_trans,crp_fx_img,'Scaling','joint')
title(["Registered Image- Transform Type : Translation","MSE- "+mse_2])

subplot(2,3,3)
imshowpair(reg_img_rigi,crp_fx_img,'Scaling','joint')
title(["Registered Image-Transform Type: Rigid","MSE- "+mse_3])

subplot(2,3,5)
imshowpair(reg_img_simi,crp_fx_img,'Scaling','joint')
title(["Registered Image-Transform Type: Similarity","MSE- "+mse_4])

subplot(2,3,6)
imshowpair(reg_img_affi,crp_fx_img,'Scaling','joint')
title(["Registered Image-Transform Type: Affine","MSE- "+mse_5])


figure(2)
subplot(2,3,1)
imshowpair(crp_mv_img,crp_fx_img,'Scaling','joint')
title(["Cropped Fixed-Moving Image pair","MSE- "+mse_1])

%% Registration with different pyramid levels

%% Pyramid Level 1
tstart1=tic;
reg_img_affi_1=  imregister(crp_mv_img,crp_fx_img,'affine',optimizer,metric,'PyramidLevels',1);
tend1=toc(tstart1);
mask_affi_1=reg_img_affi_1~=0;
mse_6=immse(reg_img_affi_1(mask_affi_1),crp_fx_img(mask_affi_1));
subplot(2,3,2)
imshowpair(reg_img_affi_1,crp_fx_img,'Scaling','joint')
title(["Affine Transform- Pyramid Level 1","MSE- "+mse_6,"Elapsed time: "+tend1+" secs"])

%% Pyramid Level 2
tstart2=tic;
reg_img_affi_2=  imregister(crp_mv_img,crp_fx_img,'affine',optimizer,metric,'PyramidLevels',2);
tend2=toc(tstart2);
mask_affi_2=reg_img_affi_2~=0;
mse_7=immse(reg_img_affi_2(mask_affi_2),crp_fx_img(mask_affi_2));
subplot(2,3,3)
imshowpair(reg_img_affi_2,crp_fx_img,'Scaling','joint')
title(["Affine Transform- Pyramid Level 2","MSE- "+mse_7,"Elapsed time: "+tend2+" secs"])

%% Pyramid Level 3
tstart3=tic;
reg_img_affi_3=  imregister(crp_mv_img,crp_fx_img,'affine',optimizer,metric,'PyramidLevels',3);
tend3=toc(tstart3);
mask_affi_3=reg_img_affi_3~=0;
mse_8=immse(reg_img_affi_3(mask_affi_3),crp_fx_img(mask_affi_3));
subplot(2,3,5)
imshowpair(reg_img_affi_3,crp_fx_img,'Scaling','joint')
title(["Affine Transform- Pyramid Level 3","MSE- "+mse_8,"Elapsed time: "+tend3+" secs"])

%% Pyramid Level 4
tstart4=tic;
reg_img_affi_4=  imregister(crp_mv_img,crp_fx_img,'affine',optimizer,metric,'PyramidLevels',4);
tend4=toc(tstart4);
mask_affi_4=reg_img_affi_4~=0;
mse_9=immse(reg_img_affi_4(mask_affi_4),crp_fx_img(mask_affi_4));
subplot(2,3,6)
imshowpair(reg_img_affi_4,crp_fx_img,'Scaling','joint')
title(["Affine Transform- Pyramid Level 4","MSE- "+mse_9,"Elapsed time: "+tend4+" secs"])


