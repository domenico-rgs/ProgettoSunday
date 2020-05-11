clear
clc
close all

%% Import dati
opts=detectImportOptions('caricoITAhour.xlsx');
opts.VariableNamesRange = 'A2';
opts.DataRange='A3';
dati=readtable('caricoITAhour.xlsx', opts);

%% Dataset
dati_domenica = dati(dati.giorno_settimana==1&not(isnan(dati.dati)),:);
x1=dati_domenica.giorno_anno;
x2 = dati_domenica.ora_giorno;
y=dati_domenica.dati;
n=length(y);

%Dati per la validazione
y_val = y(1249:2496,1);
nVal =length(y_val);

x1_ext = [1:1:365]';
x2_ext = [1:24]';
[X1,X2] = meshgrid(x1_ext, x2_ext);

%% Visualizzazione dati
figure
plot3(x1,x2,y,'bo')
grid on
title('Carico elettrico italiano di domenica')
xlabel('Giorno dell''anno')
ylabel('Ora del giorno')
zlabel('Consumo elettrico')
%% Modello bidimensionale (polinomio terzo grado)
phi_B=[ones(n,1) x1 x2 x1.^2 x2.^2 x1.*x2 x1.^3 x2.^3 (x1.^2).*x2 x1.*(x2.^2)];
phi_B_ext = [ones(length(X1(:)),1) X1(:) X2(:) X1(:).^2 X2(:).^2 X1(:).*X2(:) X1(:).^3 X2(:).^3 (X1(:).^2).*X2(:)...
    X1(:).*(X2(:).^2)];

[theta_B, std_theta_B, q_B, y_hat_B, epsilon_B, SSR_B, y_hat_B_ext, y_hat_B_ext_mat] = identificazioneModello(phi_B, phi_B_ext, X1, y);

% Plot Dati + stima (terzo grado)
stampaModello(X1,X2,y_hat_B_ext_mat, x1, x2, y)

%% Modello bidimensionale (polinomio di quarto grado)
phi_C=[ones(n,1) x1 x2 x1.^2 x2.^2 x1.*x2 x1.^3 x2.^3 (x1.^2).*x2 x1.*(x2.^2) x1.^4 x2.^4 (x1.^2).*(x2.^2) (x1.^3).*x2 x1.*(x2.^3)];
phi_C_ext = [ones(length(X1(:)),1) X1(:) X2(:) X1(:).^2 X2(:).^2 X1(:).*X2(:) X1(:).^3 X2(:).^3 (X1(:).^2).*X2(:)...
    X1(:).*(X2(:).^2) X1(:).^4 X2(:).^4 (X1(:).^2).*(X2(:).^2) (X1(:).^3).*X2(:) X1(:).*(X2(:).^3)];

[theta_C, std_theta_C, q_C, y_hat_C, epsilon_C, SSR_C, y_hat_C_ext, y_hat_C_ext_mat] = identificazioneModello(phi_C, phi_C_ext, X1, y);

% Plot Dati + stima (quarto grado)
stampaModello(X1,X2,y_hat_C_ext_mat, x1, x2, y)

%% Modello bidimensionale (polinomio di quinto grado)
phi_D=[ones(n,1) x1 x2 x1.^2 x2.^2 x1.*x2 x1.^3 x2.^3 (x1.^2).*x2 x1.*(x2.^2) x1.^4 x2.^4 (x1.^2).*(x2.^2) (x1.^3).*x2 x1.*(x2.^3) ...
    x1.^5 x2.^5 (x1.^4).*x2 x1.*(x2.^4) (x1.^3).*(x2.^2) (x1.^2).*(x2.^3)];
phi_D_ext = [ones(length(X1(:)),1) X1(:) X2(:) X1(:).^2 X2(:).^2 X1(:).*X2(:) X1(:).^3 X2(:).^3 (X1(:).^2).*X2(:) X1(:).*(X2(:).^2) X1(:).^4 X2(:).^4 ...
    (X1(:).^2).*(X2(:).^2) (X1(:).^3).*X2(:) X1(:).*(X2(:).^3) X1(:).^5 X2(:).^5 (X1(:).^4).*X2(:) X1(:).*(X2(:).^4) (X1(:).^3).*(X2(:).^2) (X1(:).^2).*(X2(:).^3)];

[theta_D, std_theta_D, q_D, y_hat_D, epsilon_D, SSR_D, y_hat_D_ext, y_hat_D_ext_mat] = identificazioneModello(phi_D, phi_D_ext, X1, y);

% Plot Dati + stima (quinto grado)
stampaModello(X1,X2,y_hat_D_ext_mat, x1, x2, y)

%% TEST F
alpha = 0.05;

% Polinomio quarto vs primo terzo
[f_alpha1,f1] = TestF(alpha,n,q_C,SSR_B, SSR_C);

% Polinomio quinto vs quarto
[f_alpha2,f2] = TestF(alpha,n,q_D,SSR_C, SSR_D);


%% FPE, AIC, MDL
%Terzo grado
[FPE3,AIC3,MDL3] = TestOggettivi(n, q_B, SSR_B);

%Quarto grado
[FPE4,AIC4,MDL4] = TestOggettivi(n, q_C, SSR_C);

%Quinto grado
[FPE5,AIC5,MDL5] = TestOggettivi(n, q_D, SSR_D);

%% CROSSVALIDAZIONE
%Dati identificazione [primo anno]
x1_id = x1(1:1248,1);
x2_id = x2(1:1248,1);
y_id = y(1:1248,1);

%Dati validazione [secondo anno]
x1_val = x1(1249:2496,1);
x2_val = x2(1249:2496,1);

figure(5)
plot3(x1_id,x2_id,y_id,'bo')
hold on
plot3(x1_val, x2_val, y_val, 'md');
hold on
mesh(X1, X2, y_hat_C_ext_mat)
grid on
title('Carico elettrico italiano di Domenica')
xlabel('Giorno dell''anno')
ylabel('Ora del giorno')
zlabel('Consumo elettrico')
legend('dati di identificazione', 'dati di validazione')

%Terzo grado
phi_B_Val=[ones(nVal,1) x1_val x2_val x1_val.^2 x2_val.^2 x1_val.*x2_val x1_val.^3 x2_val.^3 (x1_val.^2).*x2_val x1_val.*(x2_val.^2)];
[yhat3Val, epsilon3Val, SSR3Val] = crossvalidazioneModello(phi_B_Val, theta_B, y_val);

%Quarto grado
phi_C_Val=[ones(nVal,1) x1_val x2_val x1_val.^2 x2_val.^2 x1_val.*x2_val x1_val.^3 x2_val.^3 (x1_val.^2).*x2_val x1_val.*(x2_val.^2) x1_val.^4 x2_val.^4 (x1_val.^2).*(x2_val.^2) (x1_val.^3).*x2_val x1_val.*(x2_val.^3)];
[yhat4Val, epsilon4Val, SSR4Val] = crossvalidazioneModello(phi_C_Val, theta_C, y_val);

%Quinto grado
phi_D_Val=[ones(nVal,1) x1_val x2_val x1_val.^2 x2_val.^2 x1_val.*x2_val x1_val.^3 x2_val.^3 (x1_val.^2).*x2_val x1_val.*(x2_val.^2) x1_val.^4 x2_val.^4 (x1_val.^2).*(x2_val.^2) (x1_val.^3).*x2_val x1_val.*(x2_val.^3) ...
    x1_val.^5 x2_val.^5 (x1_val.^4).*x2_val x1_val.*(x2_val.^4) (x1_val.^3).*(x2_val.^2) (x1_val.^2).*(x2_val.^3)];
[yhat5Val, epsilon5Val, SSR5Val] = crossvalidazioneModello(phi_D_Val, theta_D, y_val);

