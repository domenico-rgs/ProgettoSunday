function [d_hat] = prediz(h,d)

phi=[1 sin(2*pi*d/365) cos(2*pi*d/365) sin(2*pi*2*d/365) cos(2*pi*2*d/365) sin(2*pi*3*d/365) cos(2*pi*3*d/365)...
    sin(2*pi*h/24) cos(2*pi*h/24) sin(2*pi*2*h/24) cos(2*pi*2*h/24) sin(2*pi*3*h/24) cos(2*pi*3*h/24)];
theta=load('./script/theta.mat').theta_D;
m=load('./script/m.mat').m;

d_hat = phi * theta + m;
end

