function [Vx, Vy] = lucas_kanade(Img1, Img2, r_size, plotting)
    [h,w,d] = size(Img1);
    [h2,w2,d2] = size(Img2);
    Im1 = Img1;
    Im2 = Img2;
    if d > 1 
        Im1 = rgb2gray(Img1);
    end
    if d2 > 1
        Im2 = rgb2gray(Img2);
    end
    Im1 = double(Im1);
    Im2 = double(Im2);
    
    if all(size(Im1) ~= size(Im2))
        error("Images must have the same size!");
    end
    
    cell_rows = [r_size*ones(1,floor(h / r_size)), rem(h,r_size)];
    cell_columns = [r_size*ones(1,floor(w / r_size)), rem(w,r_size)];
    
    RegIm1 = mat2cell(Im1, cell_rows, cell_columns);
    RegIm2 = mat2cell(Im2, cell_rows, cell_columns);
    
    Vx = zeros(size(RegIm1));
    Vy = zeros(size(RegIm1));
    
    for y = 1:size(cell_rows,2)
        for x = 1:size(cell_columns,2)
            reg1 = cell2mat(RegIm1(y, x));
            reg2 = cell2mat(RegIm2(y, x));

            [Ix, Iy] = gradient(reg1);
            
            It = reg1-reg2;
            A = [Ix(:) Iy(:)]; 
            b = -It(:); 
            v = pinv(A) * b;
            
            Vx(y, x) = v(1);
            Vy(y, x) = v(2);
        end
    end
    
    if plotting == true
        [X, Y] = meshgrid(1 : w+floor(r_size/2),  1 : h+floor(r_size/2));
        X = X(floor(r_size/2) : r_size : end,  floor(r_size/2) : r_size : end);
        Y = Y(floor(r_size/2) : r_size : end,  floor(r_size/2) : r_size : end);

        figure();
        imshow(Img1);
        hold on;
        quiver(X, Y, Vx, Vy, 'y')
        hold off;
    end
    
end