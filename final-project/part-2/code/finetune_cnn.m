function [net, info, expdir] = finetune_cnn(varargin)

%% Define options
matconvnetFolder = 'MatConvNet';
run(fullfile(fileparts(mfilename('fullpath')), ...
  matconvnetFolder, 'matlab', 'vl_setupnn.m')) ;

opts.modelType = 'lenet' ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.expDir = fullfile('data', ...
  sprintf('cnn_assignment-%s', opts.modelType)) ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.dataDir = './data' ;
opts.imdbPath = fullfile(opts.expDir, 'imdb-stl.mat');
opts.whitenData = true ;
opts.contrastNormalization = true ;
opts.networkType = 'simplenn' ;
opts.train = struct() ;
opts = vl_argparse(opts, varargin) ;
if ~isfield(opts.train, 'gpus'), opts.train.gpus = []; end;

opts.train.gpus = [];



%% update model

net = update_model();

%% TODO: Implement getIMDB function below

if exist(opts.imdbPath, 'file')
  imdb = load(opts.imdbPath) ;
else
  imdb = getIMDB() ;
  mkdir(opts.expDir) ;
  save(opts.imdbPath, '-struct', 'imdb') ;
end

%%
net.meta.classes.name = imdb.meta.classes(:)' ;

% -------------------------------------------------------------------------
%                                                                     Train
% -------------------------------------------------------------------------

trainfn = @cnn_train ;
[net, info] = trainfn(net, imdb, getBatch(opts), ...
  'expDir', opts.expDir, ...
  net.meta.trainOpts, ...
  opts.train, ...
  'val', find(imdb.images.set == 2)) ;

expdir = opts.expDir;
end
% -------------------------------------------------------------------------
function fn = getBatch(opts)
% -------------------------------------------------------------------------
switch lower(opts.networkType)
  case 'simplenn'
    fn = @(x,y) getSimpleNNBatch(x,y) ;
  case 'dagnn'
    bopts = struct('numGpus', numel(opts.train.gpus)) ;
    fn = @(x,y) getDagNNBatch(bopts,x,y) ;
end

end

function [images, labels] = getSimpleNNBatch(imdb, batch)
% -------------------------------------------------------------------------
images = imdb.images.data(:,:,:,batch) ;
labels = imdb.images.labels(1,batch) ;
if rand > 0.5, images=fliplr(images) ; end

end

% -------------------------------------------------------------------------
function imdb = getIMDB()
% -------------------------------------------------------------------------
% Preapre the imdb structure, returns image data with mean image subtracted
% Note: These classes are not exactly the same as in the given data... -Yke
% classes = {'airplanes', 'birds', 'ships', 'horses', 'cars'}; %given
% These are the same as in the given data:
classes = {'airplane', 'bird', 'ship', 'horse', 'car'}; %edit
splits = {'train', 'test'};

%% TODO: Implement your loop here, to create the data structure described in the assignment
%% Use train.mat and test.mat we provided from STL-10 to fill in necessary data members for training below
%% You will need to, in a loop function,  1) read the image, 2) resize the image to (32,32,3), 3) read the label of that image

train_data = load("./stl10_matlab/train.mat");
test_data = load("./stl10_matlab/test.mat");
data_all = [train_data.X ; test_data.X];
labels_all = [train_data.y ; test_data.y];
class_names = train_data.class_names;
data = single(zeros(32,32,3,6500));
labels = single(zeros(1,6500));
sets = single(zeros(1,6500));
for n = 1:size(data_all,1) %loop over images
    %check if the image is one of our predefined classes
    label_n = class_names{labels_all(n)};
    if sum(ismember(classes,label_n))==1 
        num = size(labels,2)+1;
        %make sure everything is single
        data(:,:,:,num) = im2single(imresize(im2single(reshape(data_all(n,:),96,96,3)),1/3));
        labels(num) = find(classes==string(label_n));
        sets(num) = (n > size(train_data.X,1)) + 1;
    end      
end

%%
% subtract mean
dataMean = mean(data(:, :, :, sets == 1), 4);
data = bsxfun(@minus, data, dataMean);

imdb.images.data = data ;
imdb.images.labels = single(labels) ;
imdb.images.set = sets;
imdb.meta.sets = splits ;
imdb.meta.classes = classes;

perm = randperm(numel(imdb.images.labels));
imdb.images.data = imdb.images.data(:,:,:, perm);
imdb.images.labels = imdb.images.labels(perm);
imdb.images.set = imdb.images.set(perm);

end
