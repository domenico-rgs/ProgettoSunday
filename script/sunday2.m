clear
clc
close all

%% Import dati
opts=detectImportOptions('../dati/caricoITAhour.xlsx');
opts.VariableNamesRange = 'A2';
opts.DataRange='A3';
dati=readtable('../dati/caricoITAhour.xlsx', opts);

%% Dataset
dati_domenica = dati(dati.giorno_settimana==1&not(isnan(dati.dati)),:);
x1=dati_domenica.giorno_anno;
x2 = dati_domenica.ora_giorno;
y=dati_domenica.dati;

n=length(y);

%% Visualizzazione dati
figure
scatter3(x1,x2,y)
grid on
title('Profilo orario della domenica durante l''anno')
xlabel('Giorno dell''anno')
ylabel('Ora del giorno')

%% Modello bidimensionale (polinomio terzo grado)
phi_B=[ones(n,1) x1 x2 x1.^2 x2.^2 x1.*x2 x1.^3 x2.^3 (x1.^2).*x2 x1.*(x2.^2)];
theta_B = lscov(phi_B, y);
y_hat_B = phi_B*theta_B;

x1_ext = [1:1:365]';
x2_ext = [1:24]';
[X1,X2] = meshgrid(x1_ext, x2_ext);
phi_B_ext = [ones(length(X1(:)),1) X1(:) X2(:) X1(:).^2 X2(:).^2 X1(:).*X2(:) X1(:).^3 X2(:).^3 (X1(:).^2).*X2(:)...
    X1(:).*(X2(:).^2)];
y_hat_B_ext=phi_B_ext*theta_B;
y_hat_B_ext_mat = reshape(y_hat_B_ext, size(X1));

%% Dati + stima
figure
scatter3(x1,x2,y,'b')
hold on
scatter3(x1,x2,y_hat_B,'r')
grid on
title('Profilo orario della domenica durante l''anno')
xlabel('Giorno dell''anno')
ylabel('Ora del giorno')
