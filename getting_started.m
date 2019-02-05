clear;

datapath='C:\Users\Zheng Qin\OneDrive\Tufts\EE-193\homework\hw3\hw3_data\data\';
% imgname=["yosemite";"newyear";"keyboard";"cookies";"colorado"];
imgname=["newyear"];
K=size(imgname,1);
for p=1:K
    %% Load raw data
    % Load the image
    img=imread([datapath char(imgname(p,1)) '.tif']);
    w=size(img, 2);
    h=size(img, 1);
    bits=12;
    bitrange=2^bits;
    % "Demosaic" by downsampling the image
    red=double(img(1:2:h, 1:2:w)) / bitrange;
    green=double(img(1:2:h, 2:2:w)) / bitrange;
    % We'll just throw away the other half of the green
    blue=double(img(2:2:h, 2:2:w)) / bitrange;
    rgb=cat(3, red, green, blue);
    %% Example to load metadata provided by the camera
    metafile=[datapath char(imgname(p,1)) '.csv'];
    metadata=load_metadata(metafile);
    %iso=str2double(metadata_value(metadata, 'ISO'));
    ColorMatrix=str2double(regexp(metadata_value(metadata, 'Color Matrix'),'\S+','match'));
    WbRbLevels=str2double(regexp(metadata_value(metadata, 'WB RB Levels'),'\S+','match'));
    gamma=2.2;
    neighborhood=[3 3];                                % neighborhood for wiener filter
    %% ISP
    blImg=black_level_corr(rgb);                       % black level correction
    dmImg=Demosaicking(blImg);                         % demosaicking
    wbImg=white_balc(dmImg,WbRbLevels);                % white balance
    ccImg=color_corr(wbImg,ColorMatrix);               % color correction
    gammaImg=gamma_mapping(ccImg,gamma);               % brightness correction and gamma mapping
    dnImg=denoising(gammaImg,neighborhood);
    figure(2)
    IM=imshow(dnImg);
    saveas(IM,[char(imgname(p,1)) '.png']);            % save .png
end