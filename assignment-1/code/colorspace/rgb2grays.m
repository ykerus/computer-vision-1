function [output_image] = rgb2grays(input_image)
% converts an RGB into grayscale by using 4 different methods
    R = input_image(:,:,1);
    G = input_image(:,:,2);
    B = input_image(:,:,3);
    
% ligtness method
    o1 = (max(B,max(G,R)) + min(B,min(G,R)))./2;
% average method
    o2 = (R+G+B)./3;
% luminosity method
    o3 = 0.21*R + 0.72*G + 0.07*B;
% built-in MATLAB function 
    o4 = rgb2gray(input_image);
    
    output_image = cat(3, o1,o2,o3,o4);
    
end

