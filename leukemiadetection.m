% Resim Okuma
image = imread('lösemi2.jpg');

% Gradyan Filtresi-Sobel
grayImage = rgb2gray(image);
sobelX = [-1 0 1; -2 0 2; -1 0 1];
sobelY = sobelX';

Gx = imfilter(double(grayImage), sobelX);
Gy = imfilter(double(grayImage), sobelY);

magnitude = sqrt(Gx.^2 + Gy.^2);

% Resmi Genişletme
seVertical = strel('line', 5, 90);
seHorizontal = strel('line', 5, 0);

dilatedImage = imdilate(magnitude, [seVertical seHorizontal]);

% Boşlukları Doldur
filledImage = imfill(dilatedImage, 'holes');

% Resim Kenarlarını Temizle
clearBorderImage = imclearborder(filledImage);

% Kırmızıya Çevirme?
pinkMask = image(:, :, 1) > 200 & image(:, :, 2) < 100 & image(:, :, 3) > 200;
imageWithRedPink = image;
imageWithRedPink(repmat(pinkMask, [1 1 3])) = 255;

% Final Görüntüsü
imageFinal = image + imageWithRedPink;

% Sonuçları Gösterme
figure;

subplot(2, 3, 1);
imshow(image);
title('Girişte Verilen Resim');

subplot(2, 3, 2);
imshow(magnitude, []);
title('Gradyan Magnitude');

subplot(2, 3, 3);
imshow(dilatedImage, []);
title('Genişletilmiş Görüntü');

subplot(2, 3, 4);
imshow(filledImage, []);
title('Delikleri Doldurulmuş Görüntü');

subplot(2, 3, 5);
imshow(clearBorderImage, []);
title('Kenarları Temizlenmiş Görüntü');

subplot(2, 3, 6);
imshow(imageFinal);
title('Sonuç');