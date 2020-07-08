function kp_matching_demo()
    Ia = imread("boat1.pgm");
    Ib = imread("boat2.pgm");
    [f1,f2, matches, scores]= keypoint_matching(Ia, Ib);
    [~, nr_matches] = size(matches);
    
    figure;
    imshow([Ia, Ib]);
    perm = randperm(nr_matches, 10);
    
    h1 = vl_plotframe(f1(:,matches(1,perm)));
    h2 = vl_plotframe(f1(:,matches(1,perm))); 
    set(h1,'color','k','linewidth',5);
    set(h2,'color','y','linewidth',4);
    
    f2(1,matches(2,perm)) = f2(1,matches(2,perm)) + size(Ib,2);
    h3 = vl_plotframe(f2(:,matches(2,perm)));
    h4 = vl_plotframe(f2(:,matches(2,perm))); 
    set(h3,'color','k','linewidth',5);
    set(h4,'color','g','linewidth',4);
    
    hold on;
    lines1 = f1(1:2,matches(1,perm));
    lines2 = f2(1:2,matches(2,perm));
    for x = 1:size(lines2,2)
        plot1 = plot([lines1(1,x) lines2(1,x)], [lines1(2,x) lines2(2,x)]);
        set(plot1, 'LineWidth', 2);
    end
    title("Keypoints matching boats")
end