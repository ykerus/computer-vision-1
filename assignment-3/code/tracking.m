function [] = tracking(files_path, extension, treshold, patch_size, scale)
    files = dir(fullfile(files_path, extension));
    n_files = length(files);
    
    
    outputVideo = VideoWriter(sprintf('%s.avi',files_path )); %creates the video
    outputVideo.FrameRate = 10;
    open(outputVideo)
    
    for i = 1:n_files - 1
        % files(i).folder is hetzelfde als files(i+1).folder
        im1 = imread(strcat(files(i).folder, '/', files(i).name));
        im2 = imread(strcat(files(i).folder, '/', files(i+1).name));
        
        [height,width,~]=size(im1); %  
        
        if i ==1
            [~, r, c] = harris_corner_detector(im1, treshold, false);
            
        else
            % move the r & c for the new image
            r = transpose(r - round(scale*vy_im1));
            c = transpose(c + round(scale*vx_im1));

        end
        
        vx_im1 = zeros(length(r),1);
        vy_im1 = zeros(length(r),1);
 
        for j = 1:length(r)
            %create a patch for every corner
            patch_r = [r(j) - floor(patch_size/2) :r(j) + floor(patch_size/2)];
            patch_c = [c(j) - floor(patch_size/2) :c(j) + floor(patch_size/2)];
            
            % if the patch falls outside of the image
            patch_r=patch_r(patch_r>0); 
            patch_c=patch_c(patch_c>0);  
            
            patch_r=patch_r(patch_r<width+1); 
            patch_c=patch_c(patch_c<height+1);
            
            if (sum(sum(patch_r<1)) + sum(sum(patch_r>height)) + sum(sum(patch_c<1)) + sum(sum(patch_c>width))) == 0
                im1_patch = im1(patch_r, patch_c);
                im2_patch = im2(patch_r, patch_c);
                [vx,vy] = lucas_kanade(im2_patch, im1_patch, patch_size, false);
            else 
                vx = 0;
                vy = 0;
            end
            vx_im1(j,1) = vx(1,1);
            vy_im1(j,1) = vy(1,1);
        end
 
        % plot image with flow vectors
        gcf=figure(1);
        imshow(im1);
        hold on;
        
        %add corners to image
        plot(c,r, ['.','r'], 'MarkerSize',10);
        
        r= transpose(r);
        c = transpose(c);
        %add flow vector
        q = quiver(c,r, vx_im1, vy_im1);
        q.Color = 'yellow';
        drawnow;
        frame = getframe;
        hold off
        writeVideo(outputVideo,frame);
    end
    % close the video; 
    close(outputVideo);

end
 
 


