clearAllMemoizedCaches;
clear;
close all;

% Load images.
buildingDir = fullfile('graffiti15','*.jpeg');
buildingScene = imageDatastore(buildingDir);


%Read the first image from image set
I = readimage(buildingScene,1);

% Initialize features for I(1)
grayImage = im2gray(I);
[pointx, pointy, pointm]=harris(grayImage,300000);
point=cornerPoints([pointx, pointy]);
% point1=detectHarrisFeatures(grayImage1);
[features, points] = extractFeatures(grayImage,point);

numImages = numel(buildingScene.Files);
tforms(numImages) = affinetform2d;

imageSize=zeros(numImages,2);
 figure(1);
 imshow(grayImage);
 hold on;

for n =2:numImages
    pointsprev=points;
    featuresprev=features;

    I=readimage(buildingScene, n);
   
    grayImage=im2gray(I);
    imageSize(n,:)=size(grayImage);

    n
    [pointx, pointy, pointm]=harris(grayImage,300000);
    point=cornerPoints([pointx, pointy]);
    % point1=detectHarrisFeatures(grayImage1);
    [features, points] = extractFeatures(grayImage,point);
    
    index_pairs = matchFeatures(features, featuresprev, 'Unique',true);
    matchpts=points(index_pairs(:,1), :);
    matchptsprev=pointsprev(index_pairs(:,2), :);
    
    % figure(n);
    % imshow(grayImage)
    % hold on;
     plot(matchptsprev);
    % plot(matchpts);

    tforms(n) = estgeotform2d(matchpts, matchptsprev,...
            'affine', 'Confidence', 99.9, 'MaxNumTrials', 5000);

    tforms(n).A = tforms(n-1).A * tforms(n).A;
    
end

% Compute the output limits for each transformation.
xlim=zeros(1,2);
ylim=zeros(1,2);
for i = 1:numel(tforms)           
    [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);    
end

avgXLim = mean(xlim, 2);
[~,idx] = sort(avgXLim);
centerIdx = floor((numel(tforms)+1)/2);
centerImageIdx = idx(centerIdx);
Tinv = invert(tforms(centerImageIdx));
for i = 1:numel(tforms)    
    tforms(i).A = Tinv.A * tforms(i).A;
end

for i = 1:numel(tforms)           
    [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);
end

maxImageSize = max(imageSize);

% Find the minimum and maximum output limits. 
xMin = min([1; xlim(:)]);
xMax = max([maxImageSize(2); xlim(:)]);

yMin = min([1; ylim(:)]);
yMax = max([maxImageSize(1); ylim(:)]);

% Width and height of panorama.
width  = round(xMax - xMin);
height = round(yMax - yMin);

% Initialize the "empty" panorama.
panorama = zeros([height width 3], 'like', I);

blender = vision.AlphaBlender('Operation', 'Binary mask', ...
    'MaskSource', 'Input port');  

% Create a 2-D spatial reference object defining the size of the panorama.
xLimits = [xMin xMax];
yLimits = [yMin yMax];
panoramaView = imref2d([height width], xLimits, yLimits);

% Create the panorama.
for i = 1:numImages
    I = readimage(buildingScene, i);  
    
    % Transform I into the panorama.
    warpedImage = imwarp(I, tforms(i), 'OutputView', panoramaView);
    % Generate a binary mask.    
    mask = imwarp(true(size(I,1),size(I,2)), tforms(i), 'OutputView', panoramaView);
    % Overlay the warpedImage onto the panorama.
    panorama = step(blender, panorama, warpedImage, mask);
    
end

figure
imshow(panorama)