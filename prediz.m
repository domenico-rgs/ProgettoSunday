function [d_hat] = prediz(h,d)
p=26.2354; %costante di trend

if exist('skynet','var')==0
    load('skynet.mat','net')
end

d_hat=net([d h]')+p; %come aggiungo la rete ?
end

