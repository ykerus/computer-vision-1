function [f, d] = perform_sift(im, imtype, sift_method)
%     Arguments:
%       im:             3 channel image.
%       imtype:         'opponent' | 'rgb' | 'gray'
%       sift_method:    'normal' | 'dense'

    if strcmp(imtype,'gray')
        im = single(rgb2gray(im));
        [f, d] = nd_sift(im, sift_method);
    elseif strcmp(imtype,'opponent')
        im = rgb2opponent(im);
        [f, d] = three_channel_sift(im, imtype, sift_method);
    else
        [f, d] = three_channel_sift(im, imtype, sift_method);
    end
end


function [f, d] = three_channel_sift(im, imtype, sift_method)
    f = [];
    d = [];
    for x = 1:3
        [f_temp, d_temp] = nd_sift(single(im(:,:,x)), sift_method);
        f = cat(2,f,f_temp);
        d = cat(2,d,d_temp);
    end
end


function [f, d] = nd_sift(im, sift_method)
%       Arguments:
%       im:             1 channel image.
    if strcmp(sift_method,'key points')
        [f, d] = vl_sift(im);
    else
%         More arguments possible, need to look into this.
        [f, d] = vl_dsift(im, 'size', 8, 'step', 4);
    end
    
end