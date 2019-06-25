%Linearises and de-linearises images according to capture system gamma of
%0.4545 (i.e. 1/2.2, where 2.2 is sRGB standard gamma).
Gamma=0.4545;

%Reads RGB image
im=double(imread('peppers.png'))/255;
figure, subplot 221, imshow(im); title('Original Image');

% BLUR IMAGE HERE

% Linearises image
im_linearised=im.^(1/Gamma);
subplot 222, imshow(im_linearised); title('Linearised Image');

% INCLUDE NOISE MODEL HERE

% De-linearises image
im_delinearised=im_linearised.^(Gamma);
subplot 223, imshow(im_delinearised); title('De-linearised Image');

% DEMOSAIC IMAGE NOW, AFTER DELINEARISATION
