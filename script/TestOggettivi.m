function [FPE,AIC,MDL] = TestOggettivi(n, q, SSR)
FPE = ((n+q)/(n-q))*SSR;
AIC = 2*q/n + log(SSR);
MDL = log(n)*q/n + log(SSR);
end

