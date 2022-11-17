%Samson David Puthenpeedika

img = im2double(imread('pout.tif'));

%a. gradient approximation
ker_y = fspecial('sobel');      %write the Sobel filter kernels
ker_x = -ker_y';

Gx = imfilter(img,ker_x);       %use the kernels to filter the image
Gy = imfilter(img,ker_y);               

Gmag = sqrt(Gx.*Gx+Gy.*Gy);     %approximate the gradient magnitude

StartPoint = [100,50];
EndPoint   = [200,200]; 

% calculate the local edge weight between neighbor pixels (p; q) 
[maxG,minG,d,local_weight] = localedgewidth(Gmag,StartPoint,EndPoint );
graph_1 = im2graph(Gmag);



[M, N] = size(Gmag);
StartNode = sub2ind([M N], StartPoint(2), StartPoint(1));
EndNode   = sub2ind([M N], EndPoint(2),   EndPoint(1));
[dist, path, pred] = graphshortestpath(graph_1, StartNode, EndNode);  % Matlab syntax  which uses Dijkstra Algorithm by default
[y, x] = ind2sub([M N], path);


figure(1)
subplot(1,4,1)
imshow(img);
title('Orginal Image');

subplot(1,4,2)
imshow(Gmag);
title('Gradient Image');

subplot(1,4,3)
imshow(Gmag);
title('Image with start and end point');
hold on;
plot(StartPoint(1), StartPoint(2), 'r.', 'Linewidth', 2);
plot(EndPoint(1), EndPoint(2), 'b.', 'Linewidth', 2);
legend('Start point', 'End Point','Location','southwest');


subplot(1,4,4)
imshow(Gmag);
title('Image with result path');
hold on; 
plot(x, y, '-r', 'Linewidth', 2)
hold off



function [maxG,minG,d,local_weight] = localedgewidth(Gmag,p,q)
% aclculate the local edge width between neighborhood pixels
    maxG=max(Gmag(:)); 
    minG=min(Gmag(:));
    d=sqrt(sum((p-q).^2));
    local_weight=(maxG-Gmag(q(1),q(2)))/(maxG-minG)*d/sqrt(2);
end



function graph = im2graph(im, varargin)
%PURPOSE: 
% To represent an image as a graph. Each pixel is a node connected to 4
% neighbors N,E,W,S
%
%INPUT: 
% im-Image of dimensions MxN
% conn - neighborhood connection. Must be either 4 or 8. 
%        Optional. Default is 4 if not given
%
%OUTPUT: 
% graph - A sparse matrix of dimensions [M*N]x[M*N]. The i indexs
% are the sources nodes and j indexes represent the target nodes. The value s
% s=graph(i,j) represents the cost of moving from node i->j
if ( nargin == 2 )
    conn = varargin{1};
elseif ( nargin == 1 )
    conn = 4;
end
if ( conn ~= 4 && conn ~= 8 )
    error('2nd argument is the type of neighborhood connection. Must be either 4 or 8');
end
%% image dimensions
[M, N] = size(im);
MxN = M*N;
%% Calculate distance matrix
%In the distance matrix, (weighted adjancy matrix), the i indexes are the source the j indexs are the target
CostVec = reshape(im, MxN, 1);%stack columns
%Create sparse matrix to represent the graph
if ( conn == 4 )
    graph = spdiags(repmat(CostVec,1,4), [-M -1 1 M], MxN, MxN);
elseif( conn == 8 )
    graph = spdiags(repmat(CostVec,1,8), [-M-1, -M, -M+1, -1, 1, M-1, M, M+1], MxN, MxN);
    %set to inf to disconect top from bottom rows
    graph(sub2ind([MxN, MxN], (2:N-1)*M+1,(2:N-1)*M - M))   = inf;%top->bottom westwards(-M-1)
    graph(sub2ind([MxN, MxN], (1:N)*M,    (1:N)*M - M + 1)) = inf;%bottom->top westwards(-M+1)
    
    graph(sub2ind([MxN, MxN], (0:N-1)*M+1,(0:N-1)*M + M))     = inf;%top->bottom eastwards(M-1)
    graph(sub2ind([MxN, MxN], (1:N-2)*M,  (1:N-2)*M + M + 1)) = inf;%bottom->top eastwards(M+1)
end
%set to inf to disconect top from bottom rows
graph(sub2ind([MxN, MxN], (1:N-1)*M+1, (1:N-1)*M))     = inf;%top->bottom
graph(sub2ind([MxN, MxN], (1:N-1)*M,   (1:N-1)*M + 1)) = inf;%bottom->top
end



