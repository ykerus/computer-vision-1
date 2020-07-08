function [classifiers, Voc] = get_classifiers(X_train, t_train, voc_size, method, desc)
%   Split the training data for creating a vocabulary and for creating a
%   BoW representation 
    X_Voc = X_train(1:600,:,:,:);

    X_Bow = X_train(1251:2500,:,:,:);
    t_Bow = t_train(1251:2500);
    fprintf("Retrieving descriptors for classifiers...\n");
%   Get the descriptors of all images destined for the vocabulary
    descriptors = double(transpose(cell2mat(get_descriptors(X_Voc, desc, method))));
    
%   Perform K-means on all descriptors
    fprintf("Performing K-Means...\n");
    tic;
    [~, Voc] = kmeans(descriptors, voc_size, 'display', 'iter', 'MaxIter', 400);
    fprintf("Vocabulary created in: %f seconds\n", toc);
    
%   Get the Bag Of Words on the other half of the training set.
    BagOfWords = [];
    fprintf("Getting Bag Of Words...\n");
    loader = ['|', '/', '-', '\'];
    tic;
    for i = 1:size(X_Bow(:,1,1,1))
        fprintf('%s', loader(mod(i,4)+1));
        hist = get_hist(Voc, squeeze(X_Bow(i,:,:,:)),voc_size, method, desc);
        BagOfWords = cat(1,BagOfWords, hist);
        fprintf('\b');
    end
    fprintf("Bag Of Words for classifier created in: %f seconds\n", toc);
    
    classifiers = {};
    classes = [1,2,3,7,9];
    for x = 1:5
        binary_targets = t_Bow == classes(x);
        classifiers{x} = fitcsvm(BagOfWords, binary_targets);
    end      
end