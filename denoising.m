%-- This is the function of denoising.
%   We use wiener filter to denoising.
%   Inputs:  orgImg:            3-channel image with noise.
%            neighborhood: Neighborhood size.
%   Outputs: newImg:            Image after wavelet denoising.

function newImg=denoising(orgImg,neighborhood)
   r=wiener2(orgImg(:,:,1),neighborhood);
   g=wiener2(orgImg(:,:,2),neighborhood);
   b=wiener2(orgImg(:,:,3),neighborhood);
   newImg=cat(3,r,g,b);
end