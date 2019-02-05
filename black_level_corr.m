%-- This is the function of black level correction.
%   Using imadjust fuction to correct black level.
%   Inputs:  orgImg:       3-channel image without black level correction.
%   Outputs: newImg:       Image after black level correction.

function newImg = black_level_corr(orgImg)
    newImg(:,:,1)=imadjust(orgImg(:,:,1),[min(min(orgImg(:,:,1))) max(max(orgImg(:,:,1)))],[0 1]);
    newImg(:,:,2)=imadjust(orgImg(:,:,2),[min(min(orgImg(:,:,2))) max(max(orgImg(:,:,2)))],[0 1]);
    newImg(:,:,3)=imadjust(orgImg(:,:,3),[min(min(orgImg(:,:,3))) max(max(orgImg(:,:,3)))],[0 1]);
end