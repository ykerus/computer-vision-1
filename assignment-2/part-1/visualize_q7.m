function visualize_q7
    figure;
    imSP = imread("images/image1_saltpepper.jpg");
    imGa = imread("images/image1_gaussian.jpg");
    
%     imSPB3x3 = denoise(imSP, 'box', 3);
%     imSPB5x5 = denoise(imSP, 'box', 5);
%     imSPB7x7 = denoise(imSP, 'box', 7);
%     imGausB3x3 = denoise(imGa, 'box', 3);
%     imGausB5x5 = denoise(imGa, 'box', 5);
%     imGausB7x7 = denoise(imGa, 'box', 7);
%     
%     imSPM3x3 = denoise(imSP, 'median', 3);
%     imSPM5x5 = denoise(imSP, 'median', 5);
%     imSPM7x7 = denoise(imSP, 'median', 7);
%     imGausM3x3 = denoise(imGa, 'median', 3);
%     imGausM5x5 = denoise(imGa, 'median', 5);
%     imGausM7x7 = denoise(imGa, 'median', 7);
    
    imGausG3x31 = denoise(imGa, 'gaussian', 3, 1.5);
    imGausG5x51 = denoise(imGa, 'gaussian', 5, 1.5);
    imGausG7x71 = denoise(imGa, 'gaussian', 7, 1.5);
    imGausG3x32 = denoise(imGa, 'gaussian', 3, 2.5);
    imGausG5x52 = denoise(imGa, 'gaussian', 5, 2.5);
    imGausG7x72 = denoise(imGa, 'gaussian', 7, 2.5);
%     Gaussian filtering
      subplot(2,3,1);
      imshow(imGausG3x31);
      title("Gaus - sigma 1.5 - 3x3");
    
      subplot(2,3,2);
      imshow(imGausG5x51);
      title("Gaus - sigma 1.5 - 5x5");
      
      subplot(2,3,3);
      imshow(imGausG7x71);
      title("Gaus - sigma 1.5 - 7x7");
      
      subplot(2,3,4);
      imshow(imGausG3x32);
      title("Gaus - sigma 2.5 - 3x3");
      
      subplot(2,3,5);
      imshow(imGausG5x52);
      title("Gaus - sigma 2.5 - 5x5");
      
      subplot(2,3,6);
      imshow(imGausG7x72);
      title("Gaus - sigma 2.5 - 7x7");
      
% %     Box filtering
%     subplot(2,3,1);
%     imshow(imSPB3x3);
%     title("Box - SP - 3x3");
%     
%     subplot(2,3,2);
%     imshow(imSPB5x5);
%     title("Box - SP - 5x5");
%     
%     subplot(2,3,3);
%     imshow(imSPB5x5);
%     title("Box - SP - 7x7");
%     
%     subplot(2,3,4);
%     imshow(imGausB3x3);
%     title("Box - Gaus - 3x3");
%     
%     subplot(2,3,5);
%     imshow(imGausB5x5);
%     title("Box - Gaus - 5x5");
%     
%     subplot(2,3,6);
%     imshow(imGausB5x5);
%     title("Box - Gaus - 7x7");
%     
% %     Median filtering
%     figure;
%     subplot(2,3,1);
%     imshow(imSPM3x3);
%     title("Median - SP - 3x3");
%     
%     subplot(2,3,2);
%     imshow(imSPM5x5);
%     title("Median - SP - 5x5");
%     
%     subplot(2,3,3);
%     imshow(imSPM5x5);
%     title("Median - SP - 7x7");
%     
%     subplot(2,3,4);
%     imshow(imGausM3x3);
%     title("Median - Gaus - 3x3");
%     
%     subplot(2,3,5);
%     imshow(imGausM5x5);
%     title("Median - Gaus - 5x5");
%     
%     subplot(2,3,6);
%     imshow(imGausM5x5);
%     title("Median - Gaus - 7x7");
    
end
    