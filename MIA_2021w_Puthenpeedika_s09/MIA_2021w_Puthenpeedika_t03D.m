%Samson David Puthenpeedika

% Imput Image and get Edges
I=imread('eight.tif');
I = im2double(I);
F_I = false(size(I));
F_I(51, 115) = true;
SE = ones(3);
edge = imdilate(F_I, SE) & ~F_I;

% Setting Lambda Values
l1 = 0;
MumS1 = MumfordShah(I, F_I, l1, edge);
[FG_l1, MS_l1] = mumfordShahFunctional(F_I, SE, I, l1, MumS1);

l2 = 5000;
MumS2 = MumfordShah(I, F_I, l2, edge);
[FG_l2, MS_l2] = mumfordShahFunctional(F_I, SE, I, l2, MumS2);

%% Plotting Lambdas

figure(1)

subplot(1,4,1)
imshow(I)
title('Original Image');

subplot(1,4,2) 
imshow(F_I)
title('Initial foreground mask');

subplot(1,4,3)
imshow(imoverlay(I, FG_l1, 'g'))
title({['Output Image when λ =' num2str(l1)] ['E(f) = ' num2str(MS_l1)]});

subplot(1,4,4)
imshow(imoverlay(I, FG_l2, 'g'))
title({['Output Image when λ =' num2str(l2)] ['E(f) = ' num2str(MS_l2)]});

sgtitle('Mumford-Shah functional Varying λ')


%% Call  out subfunctions 


function Ms = MumfordShah(g, FG, lambda, e)
   
    edge = sum(e, 'all');
    cf = mean(g(FG), 'all');
    bf = mean(g(~FG), 'all');
    
    FG_region = sum((cf - g(FG)).^2, 'all');
    BG_region = sum((bf - g(~FG)).^2, 'all');
    
    Ms = FG_region + BG_region + lambda * edge;

end

function [fg, MS] = mumfordShahFunctional(fg, se, I_, lambda, MS)

    growing = true;

    while growing

        edge = imdilate(fg, se) & ~fg;
        [edge_rows, edge_cols] = find(edge);

          growing = false;

        for pixel = 1 : numel(edge_rows)

           if numel(edge_rows) == 1
               fg(edge_rows, edge_cols) = true;
               MS_new = MumfordShah(I_, fg, lambda, edge);
               if MS <= MS_new
                    fg(edge_rows, edge_cols) = false;
               else
                   MS = MS_new;
                   growing = true;
               end
           else
               fg(edge_rows(pixel), edge_cols(pixel)) = true;
               MS_new = MumfordShah(I_, fg, lambda, edge);
               if MS <= MS_new
                    fg(edge_rows(pixel), edge_cols(pixel)) = false;
               else
                    MS = MS_new;
                    growing = true;
               end
           end
        end

    end

end