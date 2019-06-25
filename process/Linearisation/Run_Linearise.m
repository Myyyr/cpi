
function output_image = Run_Linearise(input_image, Gamma)


    %Gamma=0.4545;

    %Reads RGB image
    im= double(input_image)/255.;
    

    % BLUR IMAGE HERE

    % Linearises image
    output_image=im.^(1/Gamma);


end