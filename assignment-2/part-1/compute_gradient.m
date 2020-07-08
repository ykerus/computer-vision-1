function [Gx, Gy, im_magnitude,im_direction] = compute_gradient(image)

Gx = imfilter(image,[1,0,-1;2,0,-2;1,0,-1]);
Gy = imfilter(image,[1,2,1;0,0,0;-1,-2,-1]);

im_magnitude = sqrt(double(Gx).^2 + double(Gy).^2);
im_direction = atan(double(Gy) ./ double(Gx)); 

% im_direction contains lots of NaNs, since Gx is for a great part zero.
% If Gx=0 and Gy>0, atan(Gy/Gx)=90deg. If Gx=Gy=0 we set atan(Gy/Gx)=45deg

im_direction(isnan(im_direction)) = atan(1e9); % = 90deg
im_direction((double(Gx)+double(Gy))==0) = atan(1/1); % = 45deg

% We need to normalise these, because im_magnitude can be >255 and 
% im_direction is too small to visualise. After normalising we convert 
% them back to uint8

im_magnitude = uint8(im_magnitude ./ max(max(im_magnitude)) .* 255);
im_direction = uint8(im_direction ./ max(max(im_direction)) .* 255);

end

