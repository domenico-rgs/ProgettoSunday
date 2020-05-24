function [theta, std_theta, q, y_hat, epsilon, SSR] = identificazione(phi, y)

[theta, std_theta] = lscov(phi, y);
q = length(theta);
y_hat = phi * theta;
epsilon = y - y_hat; %residuo
SSR = epsilon'*epsilon;

end
