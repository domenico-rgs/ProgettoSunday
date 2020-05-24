function [d_hat] = prediz(h,d)

if(h>24 | h<1)
    error('ora inserita non valida')
elseif(d>365 | d<1)
       error('giorno inserito non valido')
else
    if exist('skynet','var')==0
     load('skynet.mat','net')
    end
    
    p=26.2354; %costante di trend
    d_hat=net([d h]')+p;
end
end

