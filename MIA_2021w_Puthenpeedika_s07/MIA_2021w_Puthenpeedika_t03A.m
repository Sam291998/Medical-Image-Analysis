% Samson David Puthenpeedika

a=im2double(imread("rice.png"));
k=3;
L=a(:);
options = statset('MaxIter',1000);
GM=fitgmdist(L,3,"Replicates",10,"Options",options);
M=[GM.mu(1) GM.mu(2) GM.mu(3)]';
S=sqrt([GM.Sigma(1),GM.Sigma(2),GM.Sigma(3)]);
P=[GM.ComponentProportion(1) GM.ComponentProportion(2) GM.ComponentProportion(3)];


yfun = @(mu,var, x)(2*pi*(var))^(-0.5)* exp(-((x-mu).^2)/(2*(var)));
val = fzero(@(x) yfun(mu1, var1, x) - yfun(mu2, var2, x), mean([mu1,mu2]));
x_values = 0:.01:1;
difference= abs(y2)-abs(y3);
T=fminbnd(difference,M(2),M(3));
b=a;
b(b<T)=0;
b(b>=T)=1;





figure()
subplot(2,2,1)
imshow(a,[])
title('Original Image')

subplot(2,2,2)
imshow(b,[])
title('Segmented Image')

subplot(2,2,3)
histogram(a)
title('Image histogram')

subplot(2,2,4)
plot(x_values,y1,"LineWidth",2,"Color","y");
hold on;
plot(x_values,y2,"LineWidth",2,"Color","g");
plot(x_values,y3,"LineWidth",2,"Color","c");
plot(x_values,sum_y,"LineWidth",1.5,"LineStyle","--","Color","k");
xline(T,"LineWidth",2,"Color","r");
legend("Gaussian function component 1","Gaussian function component 2","Gaussian function component 3","Sum all components of Gaussian functions","Threshold")
hold off