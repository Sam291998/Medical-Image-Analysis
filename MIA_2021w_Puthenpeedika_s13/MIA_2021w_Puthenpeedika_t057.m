%% SAMSON DAVID PUTHENPEEDIKA

%% Input

dataDir=fullfile(toolboxdir('vision'),'visiondata','triangleImages');
imageDir=fullfile(dataDir,'trainingImages');
labelDir=fullfile(dataDir,'trainingLabels');

%% a: U-Net network (using unetLayers())

[lgraph,outputSize] = unetLayers([32 32],2,"EncoderDepth",1);


%% b: datastores

imds=imageDatastore(imageDir);
classNames = ["triangle","background"];
labelIDs   = [255 0];
pxds = pixelLabelDatastore(labelDir,classNames,labelIDs);
pximds = pixelLabelImageDatastore(imds,pxds);


%% c: training

options=trainingOptions("sgdm","InitialLearnRate",0.001,"MaxEpochs",20,"VerboseFrequency",10);
net=trainNetwork(pximds,lgraph,options);

%% d: evaluation

pxdsResults = semanticseg(imds,net);
metrics = evaluateSemanticSegmentation(pxdsResults,pxds);


%% e: display

figure()
subplot(1,3,1)
plot(net)
title(["GLOBAL ACCURACY : "+metrics.DataSetMetrics.GlobalAccuracy,"Graph of the Network "])

subplot(1,3,2)
img1=imread(imds.Files{1});
lbl1=imread(pxds.Files{1});
lo_1=labeloverlay(img1,lbl1);
imshow(lo_1)
title("Image Overlaid by Ground Truth label")


subplot(1,3,3)
lbl2=imread(pxdsResults.Files{1});
lo_2=labeloverlay(img1,lbl2);
imshow(lo_2)
title("Image Overlaid by Result label")


