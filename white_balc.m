%-- This is the function of white balance.
%   Main idea of this function comes from
%   Edmund Lam and George Fung, “Automatic White Balancing in Digital
%   Photography” in “Single-sensor Imaging: Methods and Applications for 
%   Digital Cameras” ed. Rastislav Lukac
%   
%   This function has two steps
%   1. Using WB RB Levels read from metadata
%   2. Using gray world assumption algorithm
%   Inputs:  orgImg:       3-channel image without white balance.
%            WbRbLevels:   WB RB Levels.
%   Outputs: newImg:       Image after white balance.

function newImg=white_balc(orgImg,WbRbLevels)
    l=size(orgImg(:,:,1),1);
    w=size(orgImg(:,:,1),2);
    R(:,:)=WbRbLevels(1,1)*orgImg(:,:,1)/256;
    G(:,:)=WbRbLevels(1,3)*orgImg(:,:,2)/256;
    B(:,:)=WbRbLevels(1,2)*orgImg(:,:,3)/256;
    rAvg=sum(sum(R))/(l*w);
    gAvg=sum(sum(G))/(l*w);
    bAvg=sum(sum(B))/(l*w);
    alpha=gAvg/rAvg;
    beta=gAvg/bAvg;
    newR=alpha*R;
    newG=G;
    newB=beta*B;
    newR=imadjust(newR,stretchlim(newR),[0 1]);  % make values relocated in [0 1]
    newG=imadjust(newG,stretchlim(newG),[0 1]);
    newB=imadjust(newB,stretchlim(newB),[0 1]);
    newImg=cat(3,newR,newG,newB);
end