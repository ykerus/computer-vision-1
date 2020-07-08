function [f1,f2, matches, scores]= keypoint_matching(image1, image2)
    if ndims(image1) == 3
        image1 = single(rgb2gray(image1));
    end
    
    if ndims(image2) == 3
        image2 = single(rgb2gray(image2));
    end
   
    image1 = single(image1);
    image2 = single(image2);

    [f1,d1] = vl_sift(image1) ;
    [f2,d2] = vl_sift(image2) ;
    
    [matches, scores] = vl_ubcmatch(d1, d2);
    
   


