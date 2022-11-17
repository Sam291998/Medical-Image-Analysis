%% Samson David Puthenpeedika

%% 54: support vector machine

%% a: sample generation

rng default
grp1_1=mvnrnd([0 0],[2 2],100);
grp1_2=mvnrnd([20 0],[2 2],100);
grp1=[grp1_1;grp1_2];

grp2_1=mvnrnd([10 5],[2 2],100);
grp2_2=mvnrnd([30 5],[2 2],100);
grp2=[grp2_1;grp2_2];

%% b: support vector machine (using fitcsvm())

train_1=zeros(1,2);
train_2=zeros(1,2);

for i=1:2:200
    for j=1:2
        train_1(i,j)=grp1(i,j);
    end
end

for i=1:2:200
    for j=1:2
        train_2(i,j)=grp2(i,j);
    end
end

train_1=train_1(1:2:199,:);
train_2=train_2(1:2:199,:);
train_sample=[train_1;train_2];
train_labels = ones(200,1);
train_labels(1:100) = -1;

mdl_poly_1=fitcsvm(train_sample,train_labels,"Standardize",true,"KernelScale","auto","KernelFunction","polynomial","PolynomialOrder",1);
mdl_poly_2=fitcsvm(train_sample,train_labels,"Standardize",true,"KernelScale","auto","KernelFunction","polynomial","PolynomialOrder",2);
mdl_poly_3=fitcsvm(train_sample,train_labels,"Standardize",true,"KernelScale","auto","KernelFunction","polynomial","PolynomialOrder",3);
mdl_rbf=fitcsvm(train_sample,train_labels,"Standardize",true,"KernelScale","auto","KernelFunction","rbf");

[trainlabel_1,trainscore1]=predict(mdl_poly_1,train_sample);
[trainlabel_2,trainscore2]=predict(mdl_poly_2,train_sample);
[trainlabel_3,trainscore3]=predict(mdl_poly_3,train_sample);
[trainlabel_rbf,trainscore_rbf]=predict(mdl_rbf,train_sample);


test_1=zeros(1,2);
test_2=zeros(1,2);

for i=2:2:200
    for j=1:2
        test_1(i,j)=grp1(i,j);
    end
end

for i=2:2:200
    for j=1:2
        test_2(i,j)=grp2(i,j);
    end
end

test_1=test_1(2:2:200,:);
test_2=test_2(2:2:200,:);
test_sample=[test_1;test_2];
test_labels = ones(200,1);
test_labels(1:100) = -1;


[label_1,score1]=predict(mdl_poly_1,test_sample);
[label_2,score2]=predict(mdl_poly_2,test_sample);
[label_3,score3]=predict(mdl_poly_3,test_sample);
[label_rbf,score_rbf]=predict(mdl_rbf,test_sample);


[grp1_train1,grp2_train1]=correct_classification_percentage(train_labels,trainlabel_1);
[grp1_train2,grp2_train2]=correct_classification_percentage(train_labels,trainlabel_2);
[grp1_train3,grp2_train3]=correct_classification_percentage(train_labels,trainlabel_3);
[grp1_train4,grp2_train4]=correct_classification_percentage(train_labels,trainlabel_rbf);

[grp1_test1,grp2_test1]=correct_classification_percentage(test_labels,label_1);
[grp1_test2,grp2_test2]=correct_classification_percentage(test_labels,label_2);
[grp1_test3,grp2_test3]=correct_classification_percentage(test_labels,label_3);
[grp1_test4,grp2_test4]=correct_classification_percentage(test_labels,label_rbf);



%% c: display

figure()

d = 0.02;
[x1Grid,x2Grid] = meshgrid(min(train_sample(:,1)):d:max(train_sample(:,1)), ...
    min(train_sample(:,2)):d:max(train_sample(:,2)));
xGrid = [x1Grid(:),x2Grid(:)];


[l1,s1] = predict(mdl_poly_1,xGrid);
[l2,s2] = predict(mdl_poly_2,xGrid);
[l3,s3] = predict(mdl_poly_3,xGrid);
[l4,s4] = predict(mdl_rbf,xGrid);


subplot(2,2,1)
h(1:2) = gscatter(train_sample(:,1),train_sample(:,2),train_labels,'rb','.');
hold on
h(3) = plot(train_sample(mdl_poly_1.IsSupportVector,1),...
    train_sample(mdl_poly_1.IsSupportVector,2),'ko','MarkerSize',10);
h(4:5) = gscatter(test_sample(:,1),test_sample(:,2),label_1,'rb','*');
h(6) = plot(test_sample(mdl_poly_1.IsSupportVector,1),...
    test_sample(mdl_poly_1.IsSupportVector,2),'go','MarkerSize',10);
contour(x1Grid,x2Grid,reshape(s1(:,2),size(x1Grid)),[0 0],'k');
title(["Classification using SVM (Polynomial kernel: Order 1)", ...
    "Correctly classified train samples- Group 1 : "+grp1_train1+" %"+"  Group 2 : "+grp2_train1+" %", ...
    "Correctly classified test samples- Group 1 : "+grp1_test1+" %"+"  Group 2 : "+grp2_test1+" %"])
legend off
hold off

subplot(2,2,2)
k(1:2) = gscatter(train_sample(:,1),train_sample(:,2),train_labels,'rb','.');
hold on
k(3) = plot(train_sample(mdl_poly_2.IsSupportVector,1),...
    train_sample(mdl_poly_2.IsSupportVector,2),'ko','MarkerSize',10);
k(4:5) = gscatter(test_sample(:,1),test_sample(:,2),label_2,'rb','*');
k(6) = plot(test_sample(mdl_poly_2.IsSupportVector,1),...
    test_sample(mdl_poly_2.IsSupportVector,2),'go','MarkerSize',10);
contour(x1Grid,x2Grid,reshape(s2(:,2),size(x1Grid)),[0 0],'k');
title(["Classification using SVM (Polynomial kernel: Order 2)", ...
    "Correctly classified train samples- Group 1 : "+grp1_train2+" %"+"  Group 2 : "+grp2_train2+" %", ...
    "Correctly classified test samples- Group 1 : "+grp1_test2+" %"+"  Group 2 : "+grp2_test2+" %"])
legend off
hold off

subplot(2,2,3)
m(1:2) = gscatter(train_sample(:,1),train_sample(:,2),train_labels,'rb','.');
hold on
m(3) = plot(train_sample(mdl_poly_3.IsSupportVector,1),...
    train_sample(mdl_poly_3.IsSupportVector,2),'ko','MarkerSize',10);
m(4:5) = gscatter(test_sample(:,1),test_sample(:,2),label_3,'rb','*');
m(6) = plot(test_sample(mdl_poly_3.IsSupportVector,1),...
    test_sample(mdl_poly_3.IsSupportVector,2),'go','MarkerSize',10);
contour(x1Grid,x2Grid,reshape(s3(:,2),size(x1Grid)),[0 0],'k');
title(["Classification using SVM (Polynomial kernel: Order 3)", ...
    "Correctly classified train samples- Group 1 : "+grp1_train3+" %"+"  Group 2 : "+grp2_train3+" %", ...
    "Correctly classified test samples- Group 1 : "+grp1_test3+" %"+"  Group 2 : "+grp2_test3+" %"])
legend off
hold off

subplot(2,2,4)
n(1:2) = gscatter(train_sample(:,1),train_sample(:,2),train_labels,'rb','.');
hold on
n(3) = plot(train_sample(mdl_rbf.IsSupportVector,1),...
    train_sample(mdl_rbf.IsSupportVector,2),'ko','MarkerSize',10);
n(4:5) = gscatter(test_sample(:,1),test_sample(:,2),label_rbf,'rb','*');
n(6) = plot(test_sample(mdl_rbf.IsSupportVector,1),...
    test_sample(mdl_rbf.IsSupportVector,2),'go','MarkerSize',10);
contour(x1Grid,x2Grid,reshape(s4(:,2),size(x1Grid)),[0 0],'k');
title(["Classification using SVM (Radial basis function)", ...
    "Correctly classified train samples- Group 1 : "+grp1_train4+" %"+"  Group 2 : "+grp2_train4+" %", ...
    "Correctly classified test samples- Group 1 : "+grp1_test4+" %"+"  Group 2 : "+grp2_test4+" %"])
Lgnd = legend("GRP 1-train","GRP 2-train","Supp vec-Train","GRP 1-test","GRP 2-test","Supp vec-Test","Decision boundary");
Lgnd.Position=[0.007654861602116,0.449109580468099,0.105989583333333,0.14778578784758];
Lgnd.FontSize=8;
Lgnd.FontWeight='bold';
hold off



%% confusion matrix

function [grp1,grp2]=correct_classification_percentage(true_label,predicted_label)
c=confusionmat(true_label,predicted_label);
grp1=c(1);
grp2=c(4);
end


