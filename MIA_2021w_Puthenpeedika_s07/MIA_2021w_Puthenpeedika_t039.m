% Samson David Puthenpeedika

I=imread("hands1.jpg");
GT=imread("hands1-mask.png");
g_img=rgb2gray(I);
figure()
imshow(GT);
seg=~imbinarize(g_img,"global");
figure()
imshow(seg);


TP=0;FP=0;TN=0;FN=0;
for i=1:240
    for j=1:320
        if(seg(i,j)==1 && GT(i,j)==1)
            TP=TP+1;
        elseif(seg(i,j)==1 && GT(i,j)==0)
            FP=FP+1;
        elseif(seg(i,j)==0 && GT(i,j)==1)
            FN=FN+1;
        elseif(seg(i,j)==0 && GT(i,j)==0)
            TN=TN+1;
        end
    end
end

jacard = TP/(TP + FP + FN);
disp("jacard by def=  "+jacard)
jacc_matlab= jaccard(seg,GT);
disp("jacard by matlab=  "+jacc_matlab)

figure()
subplot(1,2,1)
imshow(I)
title("Orginal IMAGE")
subplot(1,2,2)
imshowpair(seg,GT)
title({"Jaccard Index by definition = "+jacard; ...
    "Jaccard Index by Matlab function = "+jacc_matlab})

