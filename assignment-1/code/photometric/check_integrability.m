function [ p, q, SE ] = check_integrability( normals )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   normals: normal image
%   p : df / dx
%   q : df / dy
%   SE : Squared Errors of the 2 second derivatives
[h, w, ~] = size(normals);
% initalization
p = zeros(h,w);
q = zeros(h,w);
SE = zeros(h,w);

% ========================================================================
% YOUR CODE GOES HERE
% Compute p and q, where
% p measures value of df / dx
% q measures value of df / dy

% Book p. 84:
p = normals(:,:,1)./normals(:,:,3);
q = normals(:,:,2)./normals(:,:,3);

% ========================================================================


p(isnan(p)) = 0;
q(isnan(q)) = 0;


% ========================================================================
% YOUR CODE GOES HERE
% approximate second derivate by neighbor difference
% and compute the Squared Errors SE of the 2 second derivatives SE

dpdy = zeros(h,w);
dqdx = zeros(h,w);

dpdy(1:h-1,:) = diff(p,1,1); %diff between rows     DIM = (h-1) x  w
dqdx(:,1:w-1) = diff(q,1,2); %diff between columns  DIM =    h  x (w-1)

SE = (dpdy - dqdx).^2;


% ========================================================================




end