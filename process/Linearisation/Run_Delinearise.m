function output_image = Run_Delinearise(input_image, Gamma)


    %Gamma=0.4545;

    %Reads RGB image
    im=input_image; %/255
    

    % INCLUDE NOISE MODEL HERE

    % De-linearises image
    output_image=im.^(Gamma);


end