%-- This is the function of demosaicking.
%   Main idea of this function comes from Adams-Hamilton's algorithm.
%   https://www.researchgate.net/figure/Hamilton-Adams-scheme-for-the-interpolation-of-a-green-value-at-a-red-position_fig1_24378221
%   Because we've throw away half of green pixels, so the pattern we use
%   isn't a traditional bayer pattern. In order to solve this, I combine
%   Hamilton-Adams's algorithm with 2-point and 4-point bilinear interpolation.
%   Inputs:  orgImg:       Non-bayer pattern image with 3 channel's information.
%   Outputs: newImg:       Image with 3 channels after demosaicking.

function newImg = Demosaicking(orgImg)
    r=orgImg(:,:,1);
    g=orgImg(:,:,2);
    b=orgImg(:,:,3);
    numR=size(r,1)*2;  % Number of rows
    numC=size(r,2)*2;  % Number of columns
    
    % Here are 4 cases that we should consider, which based on whether it
    % is even/odd row or columns.
    % In every situations below, the longest expressions are normal ones while
    % others are belonging to boundary points.
    for m=1:numR
        M1=(m+1)/2;
        m1=(m-1)/2;
        for n=1:numC
            N1=(n+1)/2;
            n1=(n-1)/2;
            if m/2 ~= floor(m/2)
                if n/2 ~= floor(n/2)
                    % First case: m is odd, n is odd
                    R(m,n)=r(M1,N1);
                    if(n==1)
                        G(m,n)=g(M1,N1);
                    elseif(n==numC-1)
                        G(m,n)=[g(M1,n1)+g(M1,N1)]/2;
                    else
                        G(m,n)=[g(M1,n1)+g(M1,N1)]/2+[r(M1,N1)-r(M1,n1)+r(M1,N1)-r(M1,N1+1)]/4;
                    end
                    if(m==1 && n~=1)
                        B(m,n)=[b(M1,n1)+b(M1,N1)]/2;
                    elseif(m~=1 && n==1)
                        B(m,n)=[b(m1,N1)+b(M1,N1)]/2;
                    elseif(m==1 && n==1)
                        B(m,n)=b(M1,N1);
                    else
                        B(m,n)=[b(m1,n1)+b(m1,N1)+b(M1,n1)+b(M1,N1)]/4;
                    end
                else
                    % Second case: m is odd, n is even
                    if(n==numC)
                        R(m,n)=r(M1,n/2);
                    elseif(n==2)
                        R(m,n)=[r(M1,n/2)+r(M1,n/2+1)]/2;
                    else
                        R(m,n)=[r(M1,n/2)+r(M1,n/2+1)]/2+[g(M1,n/2)-g(M1,n/2-1)+g(M1,n/2)-g(M1,n/2+1)]/4;
                    end
                    G(m,n)=g(M1,n/2);
                    if(m==1)
                        B(m,n)=b(M1,n/2);
                    elseif(m==numR-1)
                        B(m,n)=[b(m1,n/2)+b(M1,n/2)]/2;
                    else
                        B(m,n)=[b(m1,n/2)+b(M1,n/2)]/2+[g(M1,n/2)-g(m1,n/2)+g(M1,n/2)-g(M1+1,n/2)]/4;
                    end
                end
            else                       
                if n/2 ~= floor(n/2)
                    % Third case: m is even, n is odd
                    if(m==numR)
                        R(m,n)=r(m/2,N1);
                    else
                        R(m,n)=[r(m/2,N1)+r(m/2+1,N1)]/2;
                    end
                    if(m==numR && n~=1)
                        G(m,n)=[g(m/2,n1)+g(m/2,N1)]/2;
                    elseif(m~=numR && n==1)
                        G(m,n)=[g(m/2,N1)+g(m/2+1,N1)]/2;
                    elseif(m==numR && n==1)
                        G(m,n)=g(m/2,N1);
                    else
                        G(m,n)=[g(m/2,n1)+g(m/2,N1)+g(m/2+1,n1)+g(m/2+1,N1)]/4;
                    end
                    if(n==1)
                        B(m,n)=b(m/2,N1);
                    else
                        B(m,n)=[b(m/2,n1)+b(m/2,N1)]/2;
                    end
                else
                    % Fourth case: m is even, n is even
                    if(m==numR && n~=numC)
                        R(m,n)=[r(m/2,n/2)+r(m/2,n/2+1)]/2;
                    elseif(m~=numR && n==numC)
                        R(m,n)=[r(m/2,n/2)+r(m/2+1,n/2)]/2;
                    elseif(m==numR && n==numC)
                        R(m,n)=r(m/2,n/2);
                    else
                        R(m,n)=[r(m/2,n/2)+r(m/2,n/2+1)+r(m/2+1,n/2)+r(m/2+1,n/2+1)]/4;
                    end
                    if(m==numR)
                        G(m,n)=g(m/2,n/2);
                    else
                        G(m,n)=[g(m/2,n/2)+g(m/2+1,n/2)]/2;
                    end
                    B(m,n)=b(m/2,n/2);
                end
            end
        end
    end
   newImg=cat(3,R,G,B);
end