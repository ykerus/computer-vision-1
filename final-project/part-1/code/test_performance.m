function [class, score] = test_performance(Ims, targets, classifiers, Voc, voc_size, method, desc)
    BagOfWords = [];
    fprintf("Getting Bag Of Words for testing...\n");
    loader = ['|', '/', '-', '\'];
    tic;
    for i = 1:size(targets(:,1,1,1))
        fprintf('%s', loader(mod(i,4)+1));
        hist = get_hist(Voc, squeeze(Ims(i,:,:,:)),voc_size, method, desc);
        BagOfWords = cat(1,BagOfWords, hist);
        fprintf('\b');
    end
    fprintf("Bag Of Words for testing created in: %f seconds\n", toc);
    
    used_classes = 5;
    class = cell(size(used_classes));
    score = cell(size(used_classes));
    for x = 1:used_classes
        [class{x}, score{x}] = predict(classifiers{x}, BagOfWords);
    end
end