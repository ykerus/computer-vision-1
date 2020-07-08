function demo_q2_1()
    sp1 = imread("sphere1.ppm");
    sp2 = imread("sphere2.ppm");
    
    sy1 = imread("synth1.pgm");
    sy2 = imread("synth2.pgm");
    
    lucas_kanade(sp1,sp2,15, true);
    title("Sphere");
    lucas_kanade(sy1,sy2,15, true);
    title("Synthetic");
end