% Apply Blur, Noise and Bayer on frames images



frames_path = "/media/loic/Storage/work/cpi/data/caltech/test/frames/set06/V000/";

output_path = "/media/loic/Storage/work/cpi/data/caltech/test/isp_frames/set06";
mkdir(strcat(output_path,'/V000'));
output_path = strcat(output_path,'/V000/');

input_frames = dir(frames_path);

F = 2.2;
Gamma=0.4545;
K_Lambda=100;

param = "_p_"+string(F)+"_"+string(Gamma)+ "_" +string(K_Lambda)+"_";

for cnt = (1:5).*320
    % disp(length(input_frames));
    disp(cnt - 3);
    % disp(input_frames(3).name);
    input_frame_path = strcat(frames_path,input_frames(cnt).name);
    % disp(input_frame_path);
    input_image = imread(input_frame_path);
    
    output_image = Run_ImageBlur(input_image, F);
    output_image = Run_Linearise(output_image, Gamma);
    output_image = Run_Noise(output_image, K_Lambda);
    output_image = Run_Delinearise(output_image, Gamma);
    output_image = ImgProc_RGB2Bayer(output_image);
    output_image = ImgProc_Demosaic(output_image, 'Malvar');
    
    
    
    output_image_file = strcat( strcat(strcat(output_path , input_frames(cnt).name(1:end-4)), param), '.png');
    
    imwrite(output_image, output_image_file);
    
end