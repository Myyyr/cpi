
% Blurs by convolving with Gaussian approximation of Airy Disc 
% i.e. PSF for diffraction limited lens at specified wavelength, 
% F number, and pixel dimensions. Code from Jenkin (2009).

% Reads image


% im=imread('peppers.png');


function output_image = Run_ImageBlur(input_image, F)

    im = input_image;

    % ------------  Lens and Sensor Specifications -----------------
    % Number of vertical sensor pixels
    System.Pix_h=2448;
    % Number of horizontal sensor pixels
    System.Pix_w=3264;
    % sensor height
    System.SensorHeight=3.67e-3;
    % sensor width
    System.SensorWidth=4.89e-3;
    % Pixel pitch (size) calculations.
    System.PixPitch_h=System.SensorHeight/System.Pix_h;
    System.PixPitch_w=System.SensorWidth/System.Pix_w;
    System.PixPitch=(System.PixPitch_h+System.PixPitch_w)/2;
    % Specifies system aperture (System.FNumber): https://en.wikipedia.org/wiki/F-number
    System.FNumber=F;%2.2;
    % Specifies peak wavelengths of R, G and B channel Colour Filter Array (CFA).
    System.PeakRGBWvlngth=[450e-9,550e-9,570e-9];
    % System.PSF_Knl_NoOfPixels is the number of pixels for output (x by x)
    System.PSF_Knl_NoOfPixels=9;
    % System.PSF_Knl_Dims is the distance in meters to output, i.e. distance across PSF in m. 
    System.PSF_Knl_Dims=System.PixPitch*System.PSF_Knl_NoOfPixels/2; 


    % --------------- PSF Generation -----------------------

    PSF=zeros(System.PSF_Knl_NoOfPixels,System.PSF_Knl_NoOfPixels,3);
    for RGB=1:3
    PSF(:,:,RGB)=airy_disc(System.PeakRGBWvlngth(RGB),System.FNumber,...
        System.PSF_Knl_NoOfPixels, System.PSF_Knl_Dims);
    end

    % --------------- Applying Lens Blur Filter  -----------------------

    % Convolves image with PSF in 3 dimensions independently.
    disp('Convolving with airy-disc approximation from diffraction limited lens')
    % Defines img.Blur.Gauss cell
    im_blur=im;

    for RGB=1:3
        im_blur(:,:,RGB)=imfilter(im(:,:,RGB),PSF(:,:,RGB),'circular');
    end

    output_image = im_blur;
    % figure, 
    % subplot 221, imshow(im); title('Input Image');
    % subplot 222, imshow(im_blur); title('Blurred Image');

end
