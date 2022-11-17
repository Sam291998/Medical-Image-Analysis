% Samson David Puthenpeedika
I=im2double(imread('toyobjects.png'));

theta_1 =180;
theta_2 = 180;

ot = [ cosd(theta_1) -sind(theta_1) 0; ...
           sind(theta_1) cosd(theta_1) 0; ...
           0 0 1];

    % • create the corresponding 2-D affine geometric transformation (using affine2d())
    tform = affine2d(ot);

    % • set the output limits to be the same as the input limits (using affineOutputView())
    Rout = affineOutputView(size(I), tform,"BoundsStyle","sameAsInput");
    %Rout = affineOutputView(size(img), tform,'BoundsStyle','SameAsInput');
    Rout.XWorldLimits=Rout.XWorldLimits-mean(I,"all");
    Rout.YWorldLimits=Rout.YWorldLimits-mean(I,"all");

    % • use NaN to fill the output pixels outside the input image
    Rotated_image =  imwarp(I, tform, 'OutputView', Rout, 'FillValues', NaN);

imshow(Rotated_image)


function meaN_squaredError=ms(I,J_theta)

[r,c]=size(I);
meaN_squaredError = sum(sum((I-J_theta).^2,"omitnan"))/(r*c);
end
