%Samson David Puthenpeedika


global I;
global label_new;

%% a: WaterShed
I=imread("rice.png");

[gmag,gdir] = imgradient(I);                                               %approximate the gradient magnitude of the image

smooth_img=imgaussfilt(gmag,2);                                            %smooth the gradient magnitude image with a 2-D Gaussian smoothing kernel with standard deviation of 2

w=watershed(smooth_img);                                                   %apply the watershed transform to get a mosaic image

rgb = label2rgb(w,'jet','k');                                              %add different random colors to the labels in the mosaic image for display

% Display
figure(1)
subplot(1,4,1)
imshow(I)
title('Orginal Image')

subplot(1,4,2)
imshow(gmag,[])
title('Gradient Magnitude Image')

subplot(1,4,3)
imshow(smooth_img,[])
title('Smoothed Gradient Image')

subplot(1,4,4)
imshow(rgb)
title({'Colorful Mosaic Image','(Watershed Transform)'})

%% b: Merge Labels

label_new = w;
flag = 1;
while flag
    flag = 0;
    for i=0:max(label_new, [], 'all')
       
       
        neighbors_label = get_neighbors(i);                                              % detect the neighbor labels of each label by dilating the labeled area
        
        
        T = 40;
        neighbor_pair = neighbors_label(abs(get_mean(neighbors_label) - get_mean(i))<T); % discover neighbor label pairs with the difference of their mean intensities less than 40

                                                                                         %  merge the discovered neighbor label pairs by assigning the larger label value to the smaller one
        if ~isempty(neighbor_pair)
            label_new(label_new == min(neighbor_pair(1),i)) = max(neighbor_pair(1),i);
            flag = 1;
        end
    end
end

                                                                           % set the merged labels with the labeled area greater than 200 pixels to background(label value = 0)
for i=0:max(label_new, [], 'all')
    if numel(nonzeros(label_new == i)) > 200
        label_new(label_new == i) = 0;
    end
end


rgb2 = label2rgb(label_new,'jet','k');                                     % add different random colors to the labels in the merged output for display

% display
figure(2)
subplot(1,3,1)
imshow(I)
title('Original Image')

subplot(1,3,2)
imshow(rgb)
title('Colorful Mosaic Image before merge')

subplot(1,3,3)
imshow(rgb2)
title('Colorful Mosaic Image after merge')

%% Functions

function neighbor_labels = get_neighbors(label)
    global label_new
    object = label_new == label;
    se = ones(3);
    neighbors = imdilate(object, se) & ~object;
    neighbor_labels = unique(label_new(neighbors));
end

function mean_int = get_mean(label)
    global label_new
    global I
    if ~isscalar(label)
        mean_int = ones(1,length(label));
        for i=1:length(label)
            mean_int(i) = mean(I(label_new==i));
        end
    else
        mean_int = mean(I(label_new==label));
    end
end



