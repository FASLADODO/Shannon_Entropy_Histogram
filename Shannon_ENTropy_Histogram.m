% CODED BY: PUNEET DHEER another method for calculation
% UPDATED ON: 13-JAN-2018
% 
% INPUT:
% data = Multichannel data (row wise channel data)
% Ws= window size (in sample point)
% Lp= Leave Point (shift the window by some sample points)
% bins = specify the number of bins for the distribution of sample points
%
% OUTPUT:
% r_ENt= raw shannon entropy
% n_ENt= nomalized shannon entropy
%%
function [r_ENt, n_ENt]= Shannon_ENTropy_Histogram(data,Ws,Lp,bins)

    Lw=1;
    Z=Ws;

    %tic
    
    windows=ceil((length(data)-Ws+1)/Lp);
        
    for j=1:size(data,1)
       Lw=1;
       Z=Ws; 
        for i=1:windows
            fprintf('T_Windows: %d_%d \n',i,j);
            x=data(j,Lw:Z);
            
            Lw=Lw+Lp;
            Z=Z+Lp;
            
            BINNED = hist(x,bins);
            Probx = BINNED./sum(BINNED);
            ind = find(Probx); %to prevent from inf
            raw_ENx = -sum(Probx(ind) .* log(Probx(ind)));
            norm_ENx = raw_ENx/log(bins);
            r_ENt(i,j)= raw_ENx;
            n_ENt(i,j)= norm_ENx;
            clear BINNED
            
        end
    end
