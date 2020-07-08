function [ PSNR ] = myPSNR( orig_image, approx_image )
    [row, column] = size(orig_image);
    origD = im2double(orig_image);
    approxD = im2double(approx_image);
    Imax = max(max(origD));
    
    MSE = 0.0;
    for r=1:row
        for c=1:column
            MSE = MSE + (origD(r,c) - approxD(r,c)).^2;
        end
    end
    MSE = MSE ./ (row.*column);
    PSNR = 10 .* log10(Imax.^2./MSE);
end

