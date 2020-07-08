%% main function 
% If anything goes wrong, consider reading 'readme.txt'


%% fine-tune cnn

[net, info, expdir] = finetune_cnn();

%% extract features and train svm

% TODO: Replace the name with the name of your fine-tuned model
nets.fine_tuned = load(fullfile(expdir, 'net-epoch-80.mat')); nets.fine_tuned = nets.fine_tuned.net;
nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat')); nets.pre_trained = nets.pre_trained.net; 
data = load(fullfile(expdir, 'imdb-stl.mat'));

%delete empty data points (i.e. non-relevant classes)
data.images.data(:, :, :, data.images.set == 0) = [];
data.images.labels(data.images.set == 0) = [];
data.images.set(data.images.set == 0) = [];
data.images.data = single(data.images.data);     %to make sure everything
data.images.labels = single(data.images.labels); %is really
data.images.set = single(data.images.set);       %single

%%
fprintf("\nTraining SVM...\n\n")
train_svm(nets, data);

%visualise the features
fprintf("\nVisualising features...\n\n")
%in order to print each iteration, un-comment lines 92-96 in tsne_p.m, and
%lines 36-38 in d2p.m, lines 78-81 in d2p.m and line 50 in tsne.m 
nets.pre_trained.layers{end}.type = 'softmax';
nets.fine_tuned.layers{end}.type = 'softmax';

visualiseFeatures(data, nets.pre_trained);
visualiseFeatures(data, nets.fine_tuned);

fprintf("Images 1-5: pre-trained model features.\n")
disp("Images 6-10: fine-tuned model features.")
fprintf("Labels: (1) airplanes / (2) birds / (3) ships / (4) horses / (5) cars\n\n")
