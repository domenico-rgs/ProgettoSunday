function [yhatVal, epsilonVal, SSRVal] = crossvalidazioneModello(phiVal, theta, yValidazione)
yhatVal = phiVal*theta;
epsilonVal = yValidazione - yhatVal;
SSRVal = epsilonVal'*epsilonVal;
end

