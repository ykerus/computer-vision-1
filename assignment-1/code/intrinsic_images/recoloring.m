% loading original image and the intrinsic images
im_original = imread('ball.png');
im_albedo = imread('ball_albedo.png');
im_shading = imread('ball_shading.png');

% recoloring image with pure green
im_recolored_alb = zeros(size(im_albedo));
im_recolored_alb(:,:,1) = im_albedo(:,:,1) .* 0;
im_recolored_alb(:,:,2) = im_albedo(:,:,2) .* 255;
im_recolored_alb(:,:,3) = im_albedo(:,:,1) .* 0;

im_recolored = double(im_recolored_alb) .* double(im_shading); 
im_recolored = uint16(im_recolored);

% show original image and recolored image
figure;
subplot(1,2,1);
imshow(im_original);
title('Original Image');
subplot(1,2,2);
imshow(im_recolored);
title('Recolored Image');