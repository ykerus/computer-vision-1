function demo_q1_1()
    pt = imread("person_toy/00000001.jpg");
    pp = imread("pingpong/0000.jpeg");
    % Corner detection of person toy and pingpong
    harris_corner_detector(pt,10000, true);
    harris_corner_detector(pp,10000, true);
    
    % Rotated images
    pt45 = imrotate(pt,45);
    pt90 = imrotate(pt,90);
    harris_corner_detector(pt45,10000, true);
    harris_corner_detector(pt90,10000, true); 
end