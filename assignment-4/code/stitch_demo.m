function stitch_demo()
    im1 = imread("left.jpg");
    im2 = imread("right.jpg");
    [stitched, ~] = stitch(im1, im2);
    figure;
    subplot(2,2,1);
    imshow(im1);
    title("Image 1.");
    subplot(2,2,2);
    imshow(im2);
    title("Image 2.");
    subplot(2,2,[3 4]);
    imshow(stitched);
    title("Stitched image");
    
end