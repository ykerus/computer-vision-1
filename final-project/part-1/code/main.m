function main()
    fprintf("Main started!\n");    
%   Get all the images.
    [X_train, t_train, X_test, t_test, class_names] = load_images();
    
%   The different settings as provided in the assignment.
    voc_sizes = [400, 1000, 4000];
    methods = ["dense", "key points"];
    descs = ["rgb", "opponent", "gray"];
    
    
    for x = 1 : length(voc_sizes)
        voc_size = voc_sizes(x);
        for y = 1 : length(methods)
            method = methods(y);
            for z = 1 : length(descs)
                desc = descs(z);
                fprintf("----------Training specs----------\n");
                fprintf("-- Vocabulary size: %d\n", voc_size);
                fprintf("-- Sift method: %s\n", method);
                fprintf("-- Descriptors of: %s\n", desc);
                tic;
                folder = strcat(num2str(voc_size), "_", method, "_", desc);
                mkdir(folder);
                [classifiers, classes, scores] = run(X_train, t_train, X_test, t_test, class_names, voc_size, method, desc);
                svm1 = strcat("./", folder, "/SVM1");
                svm2 = strcat("./", folder, "/SVM2");
                svm3 = strcat("./", folder, "/SVM3");
                svm7 = strcat("./", folder, "/SVM7");
                svm9 = strcat("./", folder, "/SVM9");
                saveCompactModel(classifiers{1},svm1);
                saveCompactModel(classifiers{2},svm2);
                saveCompactModel(classifiers{3},svm3);
                saveCompactModel(classifiers{4},svm7);
                saveCompactModel(classifiers{5},svm9);
                
                save(strcat("./", folder, "/classes.mat"), 'classes')
                save(strcat("./", folder, "/scores.mat"), 'scores')
                fprintf("%s made in %f seconds.\n\n", folder, toc);
            end
        end
    end
end