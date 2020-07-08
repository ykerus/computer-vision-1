function [X_train, t_train, X_test, t_test, class_names] = load_images(Ntrain)
    %squeeze images before using imshow
    %e.g. "imshow(squeeze(X_train(1,:,:,:)))"
    %shows first image of training set

    %targets are integers
    %"target = i" corresponds to class "class_names(i)"
    
    used = ["airplane","bird","ship","horse","car"];
    
    if nargin == 1 && mod(Ntrain,size(used,2)) ~= 0
        error("Subset must a be multiple of %i", size(used,2));
    end

    train_data = load("./stl10_matlab/train.mat");
    test_data = load("./stl10_matlab/test.mat");
    
    class_names = train_data.class_names;
    X_train = train_data.X;
    t_train = train_data.y;
    X_test = test_data.X;
    t_test = test_data.y;
    
    %delete unused classes
    for class = class_names(~ismember(class_names,used))
        X_train(t_train==find(class_names==string(class{1})),:) = [];
        t_train(t_train==find(class_names==string(class{1}))) = [];
        
        X_test(t_test==find(class_names==string(class{1})),:) = [];
        t_test(t_test==find(class_names==string(class{1}))) = [];
    end

    [N_train, ~] = size(X_train);
    [N_test, ~] = size(X_test);
     
    %take subset from train data (not random)
    if nargin == 1
        N = Ntrain/size(used,2);
        mask = zeros(N_train/size(used,2),1); %assuming equal amount of data
        mask(1:N) = 1;                      %points per class
        for class = used
            t_train(t_train==find(class_names==string(class{1}))) = ...
            t_train(t_train==find(class_names==string(class{1}))) .* mask;
            X_train(t_train==0,:) = [];
            t_train(t_train==0) = [];
        end
        N_train = Ntrain;
    end
    
    X_train = reshape(X_train, N_train, 96, 96, 3);
    X_test = reshape(X_test, N_test, 96, 96, 3);
end