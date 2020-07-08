function G = gauss2D( sigma , kernel_size )
    %% solution
    if mod(kernel_size, 2) == 0
        error('kernel_size must be odd, otherwise the filter will not have a center to convolve on')
    end
    g1D = gauss1D(sigma, kernel_size);
    G = g1D' * g1D;
end
