function visualiseFeatures(data, net)
    N = 500; %number of points for visualisation
    layers = [1,4,7,10,12]; %conv layers
    for l = layers
        temp1 = vl_simplenn(net, data.images.data(:,:,:,1));
        s = size(temp1(l).x);
        features = zeros(N,s(1)*s(2)*s(3));
        labels = zeros(N,1);
        for i = 1:N
            feats = vl_simplenn(net, data.images.data(:,:,:,i));
            featsReshaped = reshape(feats(l).x, 1, s(1)*s(2)*s(3));
            features(i,:) = featsReshaped;
            labels(i,1) = data.images.labels(i);
        end
        y = tsne(features);
        figure;
        gscatter(y(:,1),y(:,2),labels);
        title("Layer "+num2str(l));
    end
end