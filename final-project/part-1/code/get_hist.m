function [hist] = get_hist(Voc ,Im ,voc_size, method, desc)
%   Get the descriptors of the image.
    [~, im_desc] = perform_sift(Im, desc, method);
    im_desc = transpose(double(im_desc));
    hist = zeros(1, voc_size);
%   Fill the BoW array with the closest id of the vocabulary per image
%   descriptor.
    for x = 1:size(im_desc,1)
        descriptor = double(im_desc(x,:));
        closest_id = 0;
        closest_dist = Inf;
        for y = 1:size(Voc,1)
            distance = norm(descriptor - Voc(y,:));
            if distance < closest_dist
                closest_id = y;
                closest_dist = distance;
            end
        end
        hist(closest_id) =  hist(closest_id)+1;
    end
end