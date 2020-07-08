
% loading original image and the intrinsic images
im_original = imread('ball.png');
im_albedo = imread('ball_albedo.png');
im_shading = imread('ball_shading.png');

% reconstructing image with albedo image & shading image 
im_reconstructed = double(im_albedo) .* double(im_shading); 
im_reconstructed = uint16(im_reconstructed);

% show original image, the intrinsic images and the reconstructed image 
figure;
subplot(2,2,1);
imshow(im_original);
title('Original Image');
subplot(2,2,2);
imshow(im_reconstructed);
title('Reconstructed Image');
subplot(2,2,3);
imshow(im_albedo);
title('Albedo Image');
subplot(2,2,4);
imshow(im_shading);
title('Shading Image');
 

