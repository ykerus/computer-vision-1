function imOut = compute_LoG(image, LOG_type)

switch LOG_type
    case 1 %method 1
        im_smooth = imfilter(image,gauss2D(0.5, 5));
        imOut = imfilter(im_smooth,fspecial('laplacian'));
        imOut = uint8(imOut ./ max(max(imOut)) .* 255);
    case 2 %method 2
        imOut = imfilter(image,fspecial('log',5,0.5));
        imOut = uint8(imOut ./ max(max(imOut)) .* 255);
    case 3 %method 3
        im1 = imfilter(image,fspecial('gaussian',5,1));
        im2 = imfilter(image,fspecial('gaussian',5,0.91));
        imOut = im1 - im2;     
        imOut = uint8(imOut ./ max(max(imOut)) .* 255);
end
end

