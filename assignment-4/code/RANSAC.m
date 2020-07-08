function [M, t, f1m, f2m] = RANSAC(matches, f1, f2)
    N = 100;
    P = 10;
    r = 10; %inlier radius
    [~, nr_matches] = size(matches);
    max_inliers = -1;
    
    for i=1:N
        Pmatches = matches(:,randi([1,nr_matches],1,P)); %selection
        
        x1 = f1(1,Pmatches(1,:))';
        y1 = f1(2,Pmatches(1,:))';
        
        x2 = f2(1,Pmatches(2,:))';
        y2 = f2(2,Pmatches(2,:))';

        A = [x1 y1 zeros(P,2) ones(P,1) zeros(P,1);
             zeros(P,2) x1 y1 zeros(P,1) ones(P,1)];
        b = [x2 ; y2];
        x = pinv(A) * b;
        
        x1_all = f1(1,matches(1,:));
        y1_all = f1(2,matches(1,:));
        
        x2_all = f2(1,matches(2,:));
        y2_all = f2(2,matches(2,:));
        
        M_i = reshape(x(1:4),2,2)';
        t_i = x(5:6);
        
        trans = M_i * [x1_all ; y1_all] + t_i;
        
        dist = sqrt((trans(1,:)-x2_all).^2 + (trans(2,:)-y2_all).^2);
        inliers = sum(dist <= r);
        
        if inliers > max_inliers
        	M = M_i;
            t = t_i; 
            max_inliers = inliers;
            f1m = f1(:,Pmatches(1,:));
            f2m = f2(:,Pmatches(2,:));
        end
    end
end