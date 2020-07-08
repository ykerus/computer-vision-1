function [stitched, imgfused] = stitch(im1, im2)
    stitching = 1;
    failed = false;
    while stitching
        try
            [f1,f2, matches, ~]= keypoint_matching(im2, im1);
            [M, t, ~, ~] = RANSAC(matches, f1, f2);    

        %   Transform the right image such that the angles are the same.
            M = M';
            temp_tform = [M(1,:) 0; M(2,:) 0; t' 1];
            im2_trans = imwarp(im2, affine2d(temp_tform), 'nearest');

        %   Perform keypoints matching and RANSAC to get the new exact
        %   coordinates of the twisted image.
            [f1,f2, matches, ~]= keypoint_matching(im2_trans, im1);
            [~, ~, f1m, f2m] = RANSAC(matches, f1, f2);  

        %   f2m of left image
        %   f1m of right image
            if ~all(f2m(2,:) > f1m(2,:))
                error("Sift matches not optimal")
            end

        %   Add padding at transformed image such that the y coordinates
        %   of the matching points are equal.
            if f2m(2,1) > f1m(2,1)
                mean_y_diff = mean(f2m(2,:) - f1m(2,:));      
                im2_trans = padarray(im2_trans,round(mean_y_diff),0,'pre'); 
            else
                mean_y_diff = mean(f1m(2,:) - f2m(2,:));
                im2_trans = padarray(im2_trans,round(mean_y_diff),0,'post'); 
            end

        %   Make the images of equal height.
            if size(im1,1) ~= size(im2_trans,1)
                diff = size(im1,1) - size(im2_trans,1);
                split = floor(diff / 2);
                if size(im1,1) > size(im2_trans,1)
                    im2_trans = padarray(im2_trans,split+rem(diff,2)+2,0,'post'); 
                    im2_trans = padarray(im2_trans,split-2,0,'pre'); 
                else
                    im1 = padarray(im1,split+rem(diff,2)+2,0,'post'); 
                    im1 = padarray(im1,split-2,0,'pre'); 
                end            
            end

        %   Pad the left image with zeros, such that when blending the images, the
        %   matched points have the exact same coordinates in the stitched image.
            mean_x_diff = round(mean(f1m(1,:)) + size(im1,2) - mean(f2m(1,:)));
            left = zeros(size(im1,1), size(im1,2)-mean_x_diff,3);
            im2_trans = [left im2_trans];

            imgfused = imfuse(im1,im2_trans, 'blend');

        %   Go through all pixels of the transformed image and set, for the same
        %   coordinates the value of the left image
            [h,w, ~] = size(im1);
            for y = 1:h
                for x = 1:w
                    if sum(im2_trans(y,x,:)) > 2
                        im2_trans(y,x,:) = im1(y,x,:);
                    else
                        im2_trans(y,x,:) = im1(y,x,:);
                    end
                end
            end
            stitched = im2_trans;
            stitching = 0;
        catch
            if stitching < 2
                temp1 = im1;
                im1 = im2;
                im2 = temp1;
                stitching = stitching + 1;
            else 
                stitching = 0;
                failed = true;
            end
        end
    end
    if failed
            error("Stitching failed. Please only use images that contain a yellow tram or bus. Don't try to stitch pictures of boats.")     
    end
end