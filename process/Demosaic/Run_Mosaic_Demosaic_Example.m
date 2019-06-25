%%%%%%%%%%%% Mosaicing and Demosaicing Example Code %%%%%%%%%%%%
% This is a stripped-down version of the mosaicing and demosaicing code
% used in my simulations. 
% 
% Input parameters are as below:
% Bayer_Type specifies the type of Bayer array to mosaic the image with 
% when the ImgProc_RGB2Bayer function is called.
% Demosaic_Type specifies the demosaicing algorithm to use to demosaic the
% image when the ImgProc_Demosaic function is called.
% 
% I suggest using  Demosaic_Type='Malvar', and Bayer_Type='grbg';

% Import an input image, type double, with pixel value range of 0 to 1.
img.Input=double(imread('peppers.png'))/255;

% Specify Bayer Array Type, can be 'grbg', 'rggb', 'gbrg' or 'bggr'.
Bayer_Type='grbg';

% Specify demosaic type:
Demosaic_Type='Malvar';

% Accounting for effect of bayer colour filter array (CFA), as specified by 
% the Bayer_Type parameter.  Bayer_Type 
img.Bayer=ImgProc_RGB2Bayer(img.Input, Bayer_Type);

% Demosaicing image, according to Demosaic_Type and Bayer_Type. NB. Keep 
% Bayer_Type as 'Malvar' which uses Matlab's native demosaicing function 
% (which is as good as any other I have tested). Other Bayer_Type settings 
% require further code. 
img.Dmsc=ImgProc_Demosaic(img.Bayer, Demosaic_Type , Bayer_Type);

% Showing input, mosaiced and demosaiced image
figure, 
subplot 221, imshow(img.Input); title('Input Image');
subplot 222, imshow(img.Bayer); title('Mosaiced Image');
subplot 223, imshow(img.Dmsc); title('Demosaiced Image');

% Showing artefacts due to demosaicing, amplified by a factor of 10, on a
% grey background. 
Artefact_Gain=5;
subplot 224, imshow(((img.Dmsc-img.Input)*Artefact_Gain)+0.5); title('Demosaicing Artefacts');
