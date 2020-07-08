function G = gauss1D( sigma , kernel_size )
    G = zeros(1, kernel_size);
    if mod(kernel_size, 2) == 0
        error('kernel_size must be odd, otherwise the filter will not have a center to convolve on')
    end
    %% solution
    start = kernel_size./2 - 0.5;
    x = -start:1:start;
    for i=1:kernel_size
        G(i) = (1./sigma*sqrt(2*pi))*exp(-power(x(i),2)./(2*power(sigma,2)));
    end
    G = G ./ sum(G);
end
