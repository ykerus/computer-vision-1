function RANSAC_demo()
    Ia = imread("boat1.pgm");
    Ib = imread("boat2.pgm");
   
    [f1_a,f2_a, matches_a, ~]= keypoint_matching(Ia, Ib);
    [M_a, t_a] = RANSAC(matches_a, f1_a, f2_a);
    M_a = M_a';
    temp_a = [M_a(1,:) 0; M_a(2,:) 0; t_a' 1];
    Iatrans = imwarp(Ia, affine2d(temp_a), 'nearest');
    
    [f1_b,f2_b, matches_b, ~]= keypoint_matching(Ib, Ia);
    [M_b, t_b] = RANSAC(matches_b, f1_b, f2_b);
    M_b = M_b';
    temp_b = [M_b(1,:) 0; M_b(2,:) 0; t_b' 1];
    Ibtrans = imwarp(Ib, affine2d(temp_b), 'nearest');
    
   
    
    figure;
    subplot(2,2,1);
    imshow(Iatrans);
    title("Transformed image");
    subplot(2,2,2);
    imshow(Ib);
    title("Target Image")
    subplot(2,2,[3,4]);
    imshow(Ia);
    title("Original Image")
    
    figure;
    subplot(2,2,1);
    imshow(Ibtrans);
    title("Transformed image");
    subplot(2,2,2);
    imshow(Ia);
    title("Target Image")
    subplot(2,2,[3,4]);
    imshow(Ib);
    title("Original Image")

end
