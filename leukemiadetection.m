% Read Image
image = imread('leukemia2.jpg');

% Gradient-Sobel
grayImage = rgb2gray(image);
sobelX = [-1 0 1; -2 0 2; -1 0 1];
sobelY = sobelX';

Gx = imfilter(double(grayImage), sobelX);
Gy = imfilter(double(grayImage), sobelY);

magnitude = sqrt(Gx.^2 + Gy.^2);

% Dilate Image
seVertical = strel('line', 5, 90);
seHorizontal = strel('line', 5, 0);

dilatedImage = imdilate(magnitude, [seVertical seHorizontal]);

% Fill Holes
filledImage = imfill(dilatedImage, 'holes');

% Clear Borders
clearBorderImage = imclearborder(filledImage);

% Turn Red
pinkMask = image(:, :, 1) > 200 & image(:, :, 2) < 100 & image(:, :, 3) > 200;
imageWithRedPink = image;
imageWithRedPink(repmat(pinkMask, [1 1 3])) = 255;

% Final Image
imageFinal = image + imageWithRedPink;

% Show Results
figure;

subplot(2, 3, 1);
imshow(image);
title('Input Image');

subplot(2, 3, 2);
imshow(magnitude, []);
title('Gradient Magnitude');

subplot(2, 3, 3);
imshow(dilatedImage, []);
title('Dilated Image');

subplot(2, 3, 4);
imshow(filledImage, []);
title('Image with Filled Holes');

subplot(2, 3, 5);
imshow(clearBorderImage, []);
title('Image with Cleared Borders');

subplot(2, 3, 6);
imshow(imageFinal);
title('Output Image');
