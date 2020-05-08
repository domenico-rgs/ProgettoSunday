close all
clear all
clc

%% Import Dati
%giorno_anno|ora_giorno|giorno_settimana|dati
data = xlsread('../dati/caricoITAhour.xlsx',1, 'A:D');

identificazione = data(1:365*24,1:4); %anno 1
validazione = data(365*24+1:end,1:4); %anno 2

%% Visualizzazione dati
%Plot 3D
figure
plot3(identificazione(:,1), identificazione(:,2), identificazione(:,4), 'o');
grid on
title('Profilo orario durante l''anno');
xlabel('giorno dell''anno')
ylabel('ora del giorno')
zlabel('carico (GW)')

%Serie Temporale
% X=linspace(1,365*2,365*2);
% figure
% plot(X,data(:,4),'-o');
% grid on
% title('Serie Temporale');
% xlabel('giorno dell''anno')
% ylabel('carico (GW)')
