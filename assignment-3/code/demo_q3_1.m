function demo_q3_1()
    path_directory1 = 'person_toy';
    path_directory2 = 'pingpong';
    treshold = 100000;
    patch_size = 15;
    scale = 1.5;
    tracking(path_directory1, '*.jpg', treshold, patch_size, scale)
    implay(sprintf('%s.avi',path_directory1 ));
    treshold = 40000;
    tracking(path_directory2, '*.jpeg', treshold, patch_size, scale)
    implay(sprintf('%s.avi',path_directory2 ));
end