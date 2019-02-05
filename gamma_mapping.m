%-- This is the function of brightness correction and gamma mapping.
%   This function has two steps
%   1. Brightness correction (Assumption): When the average brightness of an 
%      image is one quarter of the maximum pixel value, we think it is suitable.
%   2. Gamma mapping.
%   Inputs:  orgImg:       3-channel image without brightness correction and gamma mapping.
%            gamma:        Gamma value.
%   Outputs: newImg:       Image after brightness correction and gamma mapping.

function newImg=gamma_mapping(orgImg,gamma)
    grayim=rgb2gray(orgImg);                % Consider only gray channel
    grayscale=0.25/mean(grayim(:));
    bright_srgb=min(1,orgImg*grayscale);    % Always keep image value less than 1
    newImg=bright_srgb.^(1/gamma);
end