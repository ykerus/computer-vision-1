function [descriptors] = get_descriptors(ims, imtype, sift_method)
%   Arguments:
%       ims:            4 dimensional array containing n images of height h
%                       width w and channels c. n * h * w * c
%       imtype:         'opponent' | 'rgb' | 'gray'
%       sift_method:    'normal' | 'dense'    

%   Returns a Cell array with all descriptors per image.
    
    descriptors = {};
    loader = ['|', '/', '-', '\'];
    tic;
    for x = 1:(size(ims,1))
        fprintf('%s', loader(mod(x,4)+1));
        [~, temp_desc] = perform_sift(squeeze(ims(x,:,:,:)), imtype, sift_method);
        descriptors{end+1} = temp_desc;
        fprintf('\b');
    end
    fprintf("Descriptors retrieved in: %f seconds\n", toc);
    
end
