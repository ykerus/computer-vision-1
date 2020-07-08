function visualize(input_image)
    [y,x,z] = size(input_image);
    figure;
    subplot(2,2,1)
    if z < 4
        for i = 1:3
           subplot(2,2,i);
           imshow(input_image(:,:,i));
        end
        subplot(2,2,4);
        imshow(input_image)
    else
        for i = 1:4
           subplot(2,2,i);
           imshow(input_image(:,:,i));
        end
    end
end

