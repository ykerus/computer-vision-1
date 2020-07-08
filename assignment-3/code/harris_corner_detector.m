function [H, r, c] = harris_corner_detector(I, threshold, plotting)
    [h, w, ch] = size(I);
    if ch == 3  %make sure image is grayscale
        I = rgb2gray(I);
    end
    
    %calculate H
    I = double(I);
    G  = fspecial("gaussian",5,1);
    [Gx, Gy] = gradient(G); %first order derivative of G
    Ix = imfilter(I, Gx); %smoothed derivative image wrt x
    Iy = imfilter(I, Gy); %smoothed derivative image wrt y
    A  = imfilter(Ix.^2, G);
    B  = imfilter(Ix.*Iy, G);
    C  = imfilter(Iy.^2, G);
    H  = (A.*C - B.^2) - 0.04 * (A+C).^2;
    
    %find corners
    n  = 5; %choose odd
    r = [];
    c = [];
    Ic = cat(3,cat(3,I,I),I); %for corner visualization
    n2 = floor(n/2); 
    for i = 1+n2:h-n2 %leave edges of image
        for j = 1+n2:w-n2 %so kernel stays within image.
            %check if pixel (i,j) is the largest of its neighbours
            if H(i,j) > threshold && H(i,j) == max(max(H(i-n2:i+n2,j-n2:j+n2)))
            	r(end+1) = i;
            	c(end+1) = j;
                %draw a red cross in the gray image
                Ic(i,j,:) = [255,0,0];
                Ic(i+1,j,:) = [255,0,0];
                Ic(i-1,j,:) = [255,0,0];
                Ic(i,j+1,:) = [255,0,0];
                Ic(i,j-1,:) = [255,0,0];
            end
        end
    end
    
    %visualize results
    if plotting == true
        Ix = Ix./max(max(Ix)).*255; %normalize
        Iy = Iy./max(max(Iy)).*255; %normalize
        figure()
        set(gcf, 'Position',  [250, 250, 1000, 500])
        subplot(1,2,1)
        imshow(uint8(Ix))
        title("Ix")
        subplot(1,2,2)
        imshow(uint8(Iy))
        title("Iy")
        figure()
        set(gcf, 'Position',  [250, 250, 1000, 500])
        subplot(1,2,1)
        imshow(uint8(I))
        title("Original (grayscale) image")
        subplot(1,2,2)
        imshow(uint8(Ic))
        title("Corners highlighted")
    end
    
end