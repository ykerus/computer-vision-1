function [output_image] = rgb2normedrgb(input_image)
    [R, G, B] = getColorChannels(input_image);
    
    r = R./(R+G+B);
    g = G./(R+G+B);
    b = B./(R+G+B);

    output_image = cat(3,r,g,b);
    
    figure;
    subplot(2,2,1);
    imshow(output_image(:,:,1));
    title('R');
    subplot(2,2,2);
    imshow(output_image(:,:,2));
    title('G');
    subplot(2,2,3);
    imshow(output_image(:,:,3));
    title('B');
    subplot(2,2,4);
    imshow(output_image);
    title('Normalized RGB');
end

