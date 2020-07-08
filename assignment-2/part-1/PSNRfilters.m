function [ BoxMed, Gauss] = PSNRfilters
    imSP = imread("images/image1_saltpepper.jpg");
    imGa = imread("images/image1_gaussian.jpg");

    imSPB3x3 = denoise(imSP, 'box', 3);
    imSPB5x5 = denoise(imSP, 'box', 5);
    imSPB7x7 = denoise(imSP, 'box', 7);
    imGausB3x3 = denoise(imGa, 'box', 3);
    imGausB5x5 = denoise(imGa, 'box', 5);
    imGausB7x7 = denoise(imGa, 'box', 7);
    
    imSPM3x3 = denoise(imSP, 'median', 3);
    imSPM5x5 = denoise(imSP, 'median', 5);
    imSPM7x7 = denoise(imSP, 'median', 7);
    imGausM3x3 = denoise(imGa, 'median', 3);
    imGausM5x5 = denoise(imGa, 'median', 5);
    imGausM7x7 = denoise(imGa, 'median', 7);
    
    imGausG5x51 = denoise(imGa, 'gaussian', 7, 1);
    imGausG5x52 = denoise(imGa, 'gaussian', 7, 2);
    imGausG5x53 = denoise(imGa, 'gaussian', 7, 3);
    imGausG5x54 = denoise(imGa, 'gaussian', 7, 4);
    imGausG5x55 = denoise(imGa, 'gaussian', 7, 5);
    imshow(imGausG5x52)
    BoxMed = [myPSNR(imSP, imSPB3x3), myPSNR(imSP, imSPB5x5), myPSNR(imSP, imSPB7x7), myPSNR(imSP, imSPM3x3),myPSNR(imSP, imSPM5x5),myPSNR(imSP, imSPM7x7)
        myPSNR(imGa, imGausB3x3),myPSNR(imGa, imGausB5x5),myPSNR(imGa, imGausB7x7),myPSNR(imGa, imGausM3x3),myPSNR(imGa, imGausM5x5),myPSNR(imGa, imGausM7x7)];
    
    Gauss = [myPSNR(imGa, imGausG5x51), myPSNR(imGa, imGausG5x52), myPSNR(imGa, imGausG5x53), myPSNR(imGa, imGausG5x54), myPSNR(imGa, imGausG5x55)];

end