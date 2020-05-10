function [theta, std_theta, q, y_hat, epsilon, SSR, curva, curva_matrix] = identificazioneModello(phi, phi_grid, X1, y)

[theta, std_theta] = lscov(phi, y);
q = length(theta);
y_hat = phi * theta;
epsilon = y - y_hat; %residuo
SSR = epsilon'*epsilon;
curva = phi_grid*theta;

curva_matrix = reshape(curva, size(X1));

end

