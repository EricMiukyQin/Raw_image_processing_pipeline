%-- This is the function of color correction.
%   Main idea of this function is to use color matrix read from metadata.
%   Inputs:  orgImg:       3-channel image without color correction.
%            colorMtx:     Color Matrix.
%   Outputs: newImg:       Image after color correction.

function newImg=color_corr(orgImg,colorMtx)
    l=size(orgImg(:,:,1),1);
    w=size(orgImg(:,:,1),2);
    for i=1:l
        for j=1:w
            T=[colorMtx(1,1:3);colorMtx(1,4:6);colorMtx(1,7:9)]*[orgImg(i,j,1);orgImg(i,j,2);orgImg(i,j,3)];
            R(i,j)=T(1,1)/256;
            G(i,j)=T(2,1)/256;
            B(i,j)=T(3,1)/256;
        end
    end
    R=imadjust(R,stretchlim(R),[0 1]);  % make values relocated in [0 1]
    G=imadjust(G,stretchlim(G),[0 1]);
    B=imadjust(B,stretchlim(B),[0 1]);
    newImg=cat(3,R,G,B);
end