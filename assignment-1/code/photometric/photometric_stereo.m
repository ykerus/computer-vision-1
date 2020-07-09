close all
clear all
clc
 
disp('Part 1: Photometric Stereo')

% obtain many images in a fixed view under different illumination
disp('Loading images...')

shadow_trick = true;
n_images = 250; % use first n images in the directory, n large = all images
RGB = false;     % make sure to change this if you change rgb - gray
image_dir = 'photometrics_images/SphereGray25/';  
% for yale faces: see code all the way below and consider commenting out
% the first part

if RGB
    image_stack_rgb = zeros(1,1,3,1);
    albedo = zeros(1,1,3);
    for c = 1:3 % channels R, G, B
        [image_stack_c, scriptV_c] = load_syn_images(image_dir, c);
        image_stack_c(isnan(image_stack_c)) = 0;
        scriptV_c(isnan(scriptV_c)) = 0;
        [h, w, n] = size(image_stack_c);
        if n_images <  n
            image_stack_c = image_stack_c(:,:,1:n_images);
            scriptV_c = scriptV_c(1:n_images,:);
            n = n_images;
        end
        image_stack_rgb(1:h,1:w,c,1:n) = image_stack_c;
        % try to get rid of nan values in scriptV
        if c == 1
            scriptV = scriptV_c;
        else
            for i = 1:n
                if sum(isnan(scriptV(i,:))) > 0 
                    scriptV(i,:) = scriptV_c(i,:);
                end
            end
        end
        [albedo_c, ~] = estimate_alb_nrm(image_stack_c, scriptV_c, shadow_trick);
        albedo(1:h,1:w,c) = albedo_c;
    end
    fprintf('Image size (HxW): %dx%d\n', h, w);
    fprintf('Finish loading %d images.\n\n', n);
    disp('Computing surface albedo and normal map...')
    image_stack_gray = zeros(h, w, n);
    for i = 1:n
        image_stack_gray(:,:,i) = rgb2gray(image_stack_rgb(:,:,:,i));
    end
    [~,  normals] = estimate_alb_nrm(image_stack_gray, scriptV, shadow_trick);
    
else % grayscale image
    [image_stack, scriptV] = load_syn_images(image_dir);
    [h, w, n] = size(image_stack);
    if n_images <  n
        image_stack = image_stack(:,:,1:n_images);
        scriptV = scriptV(1:n_images,:);
        n = n_images;
    end
    fprintf('Finish loading %d images.\n\n', n);

% compute the surface gradient from the stack of imgs and light source mat
    disp('Computing surface albedo and normal map...')
    [albedo, normals] = estimate_alb_nrm(image_stack, scriptV, shadow_trick);
end

%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

% threshold = 0.005;

threshold = 0.005;  

SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
height_map = construct_surface( p, q, "average" );

%% Display
show_results(albedo, normals, SE);
show_model(flip(albedo,2), height_map);


%% Face
[image_stack, scriptV] = load_face_images('photometrics_images/yaleB02/');
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);
disp('Computing surface albedo and normal map...')
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV, false);

%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
height_map = construct_surface( p, q );

show_results(albedo, normals, SE);
show_model(flip(albedo,2), height_map);

