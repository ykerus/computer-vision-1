function [ imOut ] = denoise( image, kernel_type, varargin)
% For varagin, use the first argument for kernel_size and second 
% argument for sigma.
varargin = cell2mat(varargin)
switch kernel_type
    case 'box'
        if ~isempty(varargin)
            imOut = imboxfilt(image, varargin(1));
        else
            imOut = imboxfilt(image);
        end
    case 'median'
         if ~isempty(varargin)
            imOut = medfilt2(image, [varargin(1) varargin(1)]);
         else
            imOut = medfilt2(image);
         end
    case 'gaussian'
         if length(varargin) < 2
            error("We need a kernel size and sigma for the Gaussian filter.")
         else
            h = gauss2D(varargin(2), varargin(1));
            imOut = imfilter(image, h);
         end
end
end
