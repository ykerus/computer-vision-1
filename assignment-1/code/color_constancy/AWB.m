% im = imread('color_constancy/awb.jpg');
im = imread('color_constancy/awb.jpg');
% channel R, G and B of image awb.jpg
R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);

% mean of each chanel of the image
mean_R = mean(R(:));
mean_G = mean(G(:));
mean_B = mean(B(:));

% scale value for a pixel in the 3 channels
scale_R = 128/mean_R;
scale_G = 128/mean_G;
scale_B = 128/mean_B;

% new image awb
new_image = zeros(size(im)); 
new_image(:,:,1) = scale_R * R;
new_image(:,:,2) = scale_G * G;
new_image(:,:,3) = scale_R * B;
new_image = uint8(new_image);

% show original image & new image 
figure;
subplot(1,2,1);
imshow(im);
title('Original Image');
subplot(1,2,2);
imshow(new_image);
title('Color Constant Image');

