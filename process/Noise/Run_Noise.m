% General source on Shot/Poisson noise https://en.wikipedia.org/wiki/Shot_noise
% Reference on Imnoise.m function: https://www.mathworks.com/help/images/ref/imnoise.html
% Note from above reference: If I is double precision, then input pixel values are interpreted as means of Poisson distributions scaled up by 1e12. For example, if an input pixel has the value 5.5e-12, then the corresponding output pixel will be generated from a Poisson distribution with mean of 5.5 and then scaled down by 1e12.

function output_image = Run_Noise(input_image, K_Lambda)

    im = input_image;
    output_image = im;
    
    for ch = 1:3
        
        i = im(:,:,ch);
        
        %i = double(channel)/255;

        %K_Lambda=100; % No. of quanta. (change this to change the SNR).
        scale = 1e12; % Scaling factor (as required by matlab, see above note from Imnoise.m function reference)

        noisy_im = scale/K_Lambda*imnoise(i/scale*K_Lambda, 'poisson');
        % figure, imtool([i,iP]);
        
        output_image(:,:,ch) = noisy_im;
    
    end
end