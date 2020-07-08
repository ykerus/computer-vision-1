function [classifiers, classes, scores] = run(X_train, t_train, X_test, t_test, class_names, voc_size, method, desc)
%   Get the SVM classifiers for each class.
    [classifiers, Voc] = get_classifiers(X_train, t_train, voc_size, method, desc);
    fprintf("Done!\n");
   
    [classes, scores] = test_performance(X_test, t_test,  classifiers, Voc, voc_size, method, desc);
    fprintf("Done!\n");
    
end