clear
clc
close all

%% Import dati
opts=detectImportOptions('./caricoITAhour.xlsx');
opts.VariableNamesRange = 'A2';
opts.DataRange='A3';
dati=readtable('./caricoITAhour.xlsx', opts);

%% Dataset
dati_domenica = dati(dati.giorno_settimana==1&not(isnan(dati.dati)),:);
x1=dati_domenica.giorno_anno;
x2 = dati_domenica.ora_giorno;
y=dati_domenica.dati;

n=length(y);

%% Visualizzazione dati
figure
plot3(x1,x2,y, 'bo')
grid on
title('Profilo orario della domenica durante l''anno')
xlabel('Giorno dell''anno')
ylabel('Ora del giorno')

%% Modello bidimensionale (polinomio terzo grado)
phi_B=[ones(n,1) x1 x2 x1.^2 x2.^2 x1.*x2 x1.^3 x2.^3 (x1.^2).*x2 x1.*(x2.^2)];
theta_B = lscov(phi_B, y);
y_hat_B = phi_B*theta_B;
q_B = length(theta_B);
epsilon_B = y - y_hat_B;
SSR_B = epsilon_B'*epsilon_B;

x1_ext = [1:1:365]';
x2_ext = [1:24]';
[X1,X2] = meshgrid(x1_ext, x2_ext);
phi_B_ext = [ones(length(X1(:)),1) X1(:) X2(:) X1(:).^2 X2(:).^2 X1(:).*X2(:) X1(:).^3 X2(:).^3 (X1(:).^2).*X2(:)...
    X1(:).*(X2(:).^2)];
y_hat_B_ext=phi_B_ext*theta_B;
y_hat_B_ext_mat = reshape(y_hat_B_ext, size(X1));


%% Dati + stima [TERZO GRADO]
figure(2)
mesh(X1, X2, y_hat_B_ext_mat)
hold on
plot3(x1,x2,y,'bo')
grid on
title('Profilo orario della domenica durante l''anno')
xlabel('Giorno dell''anno')
ylabel('Ora del giorno')

%% Modello bidimensionale (polinomio di quarto grado)
phi_C=[ones(n,1) x1 x2 x1.^2 x2.^2 x1.*x2 x1.^3 x2.^3 (x1.^2).*x2 x1.*(x2.^2) x1.^4 x2.^4 (x1.^2).*(x2.^2) (x1.^3).*x2 x1.*(x2.^3)];
theta_C = lscov(phi_C, y);
y_hat_C = phi_C*theta_C;
q_C = length(theta_C);
epsilon_C = y - y_hat_C;
SSR_C = epsilon_C'*epsilon_C;

x1_ext = [1:1:365]';
x2_ext = [1:24]';
[X1,X2] = meshgrid(x1_ext, x2_ext);
phi_C_ext = [ones(length(X1(:)),1) X1(:) X2(:) X1(:).^2 X2(:).^2 X1(:).*X2(:) X1(:).^3 X2(:).^3 (X1(:).^2).*X2(:)...
    X1(:).*(X2(:).^2) X1(:).^4 X2(:).^4 (X1(:).^2).*(X2(:).^2) (X1(:).^3).*X2(:) X1(:).*(X2(:).^3)];
y_hat_C_ext=phi_C_ext*theta_C;
y_hat_C_ext_mat = reshape(y_hat_C_ext, size(X1));

%% Dati + stima [QUARTO GRADO]
figure(3)
mesh(X1, X2, y_hat_C_ext_mat)
hold on
plot3(x1,x2,y,'bo')
grid on
title('Profilo orario della domenica durante l''anno')
xlabel('Giorno dell''anno')
ylabel('Ora del giorno')

%% Modello bidimensionale (polinomio di quinto grado)
phi_D=[ones(n,1) x1 x2 x1.^2 x2.^2 x1.*x2 x1.^3 x2.^3 (x1.^2).*x2 x1.*(x2.^2) x1.^4 x2.^4 (x1.^2).*(x2.^2) (x1.^3).*x2 x1.*(x2.^3) ...
    x1.^5 x2.^5 (x1.^4).*x2 x1.*(x2.^4) (x1.^3).*(x2.^2) (x1.^2).*(x2.^3)];
theta_D = lscov(phi_D, y);
y_hat_D = phi_D*theta_D;
q_D = length(theta_D);
epsilon_D = y - y_hat_D;
SSR_D = epsilon_D'*epsilon_D;

x1_ext = [1:1:365]';
x2_ext = [1:24]';
[X1,X2] = meshgrid(x1_ext, x2_ext);
phi_D_ext = [ones(length(X1(:)),1) X1(:) X2(:) X1(:).^2 X2(:).^2 X1(:).*X2(:) X1(:).^3 X2(:).^3 (X1(:).^2).*X2(:) X1(:).*(X2(:).^2) X1(:).^4 X2(:).^4 ...
    (X1(:).^2).*(X2(:).^2) (X1(:).^3).*X2(:) X1(:).*(X2(:).^3) X1(:).^5 X2(:).^5 (X1(:).^4).*X2(:) X1(:).*(X2(:).^4) (X1(:).^3).*(X2(:).^2) (X1(:).^2).*(X2(:).^3)];
y_hat_D_ext=phi_D_ext*theta_D;
y_hat_D_ext_mat = reshape(y_hat_D_ext, size(X1));

%% Dati + stima [QUINTO GRADO]
figure(4)
mesh(X1, X2, y_hat_D_ext_mat)
hold on
plot3(x1,x2,y,'bo')
grid on
title('Profilo orario della domenica durante l''anno')
xlabel('Giorno dell''anno')
ylabel('Ora del giorno')

%% TEST F (con il test F sui tre modelli risulta migliore il polinomio di quarto grado)
alpha = 0.05;
%% Polinomi di quarto grado vs Polinomio di terzo grado
f_alpha_C = finv(1-alpha, 1, n - q_C);
f_C = (n-q_C) * ((SSR_B - SSR_C)/SSR_C);

%% Polinomi di quinto grado vs Polinomio di quarto grado
f_alpha_D = finv(1-alpha, 1, n - q_D);
f_D = (n-q_D) * ((SSR_C - SSR_D)/SSR_D);

%% TEST FPE, AIC, MDL (con questi tre test risulta migliore il polinomio di quarto grado)
%% Polinomio di terzo grado
FPE_B = ((n + q_B)/(n - q_B)) * SSR_B;
AIC_B = 2*q_B/n + log(SSR_B);
MDL_B = log(n)*q_B/n + log(SSR_B);

%% Polinomio di quarto grado
FPE_C = ((n + q_C)/(n - q_C)) * SSR_C;
AIC_C = 2*q_C/n + log(SSR_C);
MDL_C = log(n)*q_C/n + log(SSR_C);

%% Polinomio di quinto grado
FPE_D = ((n + q_D)/(n - q_D)) * SSR_D;
AIC_D = 2*q_D/n + log(SSR_D);
MDL_D = log(n)*q_D/n + log(SSR_D);
