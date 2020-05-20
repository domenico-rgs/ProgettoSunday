clear
clc
close all

load_dataset

%Normalizzazione 
x1_id=x1_id/365;
x2_id=x2_id/24;
x1_val=x1_val/365;
x2_val=x2_val/24;
[X1,X2] = meshgrid(linspace(0,1,365), linspace(0,1,24));

%% Modello bidimensionale (polinomio terzo grado)
phi_B=[ones(n,1) x1_id x2_id x1_id.^2 x2_id.^2 x1_id.*x2_id x1_id.^3 x2_id.^3 (x1_id.^2).*x2_id];
phi_B_ext = [ones(length(X1(:)),1) X1(:) X2(:) X1(:).^2 X2(:).^2 X1(:).*X2(:) X1(:).^3 X2(:).^3 (X1(:).^2).*X2(:)];

[theta_B, std_theta_B, q_B, y_hat_B, epsilon_B, SSR_B, y_hat_B_ext, y_hat_B_ext_mat] = identificazioneModello(phi_B, phi_B_ext, X1, y_id_dt);

% Plot Dati + stima (terzo grado)
stampaModello('Modello III grado',X1,X2,y_hat_B_ext_mat+p, x1_id, x2_id, y_id_dt+p)

%% Modello bidimensionale (polinomio di quarto grado)
phi_C=[ones(n,1) x1_id x2_id x1_id.^2 x2_id.^2 x1_id.*x2_id x1_id.^3 x2_id.^3 (x1_id.^2).*x2_id x1_id.*(x2_id.^2) x1_id.^4 x2_id.^4 (x1_id.^2).*(x2_id.^2) (x1_id.^3).*x2_id x1_id.*(x2_id.^3)];
phi_C_ext = [ones(length(X1(:)),1) X1(:) X2(:) X1(:).^2 X2(:).^2 X1(:).*X2(:) X1(:).^3 X2(:).^3 (X1(:).^2).*X2(:)...
    X1(:).*(X2(:).^2) X1(:).^4 X2(:).^4 (X1(:).^2).*(X2(:).^2) (X1(:).^3).*X2(:) X1(:).*(X2(:).^3)];

[theta_C, std_theta_C, q_C, y_hat_C, epsilon_C, SSR_C, y_hat_C_ext, y_hat_C_ext_mat] = identificazioneModello(phi_C, phi_C_ext, X1, y_id_dt);

% Plot Dati + stima (quarto grado)
stampaModello('Modello IV grado',X1,X2,y_hat_C_ext_mat+p, x1_id, x2_id, y_id_dt+p)

%% Modello bidimensionale (polinomio di quinto grado)
phi_D=[ones(n,1) x1_id x2_id x1_id.^2 x2_id.^2 x1_id.*x2_id x1_id.^3 x2_id.^3 (x1_id.^2).*x2_id x1_id.*(x2_id.^2) x1_id.^4 x2_id.^4 (x1_id.^2).*(x2_id.^2) (x1_id.^3).*x2_id x1_id.*(x2_id.^3) ...
     x2_id.^5 (x1_id.^4).*x2_id x1_id.*(x2_id.^4) (x1_id.^3).*(x2_id.^2) (x1_id.^2).*(x2_id.^3)];
phi_D_ext = [ones(length(X1(:)),1) X1(:) X2(:) X1(:).^2 X2(:).^2 X1(:).*X2(:) X1(:).^3 X2(:).^3 (X1(:).^2).*X2(:) X1(:).*(X2(:).^2) X1(:).^4 X2(:).^4 ...
    (X1(:).^2).*(X2(:).^2) (X1(:).^3).*X2(:) X1(:).*(X2(:).^3) X2(:).^5 (X1(:).^4).*X2(:) X1(:).*(X2(:).^4) (X1(:).^3).*(X2(:).^2) (X1(:).^2).*(X2(:).^3)];

[theta_D, std_theta_D, q_D, y_hat_D, epsilon_D, SSR_D, y_hat_D_ext, y_hat_D_ext_mat] = identificazioneModello(phi_D, phi_D_ext, X1, y_id_dt);

% Plot Dati + stima (quinto grado)
stampaModello('Modello V grado',X1,X2,y_hat_D_ext_mat+p, x1_id, x2_id, y_id_dt+p)


%% Modello bidimensionale (polinomio di sesto grado)
phi_E=[ones(n,1) x1_id x2_id x1_id.^2 x2_id.^2 x1_id.*x2_id x1_id.^3 x2_id.^3 (x1_id.^2).*x2_id x1_id.*(x2_id.^2) x1_id.^4 x2_id.^4 (x1_id.^2).*(x2_id.^2) (x1_id.^3).*x2_id x1_id.*(x2_id.^3) ...
     x1_id.^5 x2_id.^5 (x1_id.^4).*x2_id x1_id.*(x2_id.^4) (x1_id.^3).*(x2_id.^2) (x1_id.^2).*(x2_id.^3)...
     x1_id.^6 x2_id.^6 x1_id.^5.*x2_id x1_id.*(x2_id.^5) (x1_id.^4).*(x2_id.^2) (x1_id.^2).*(x2_id.^4) (x1_id.^3).*(x2_id.^3)];
phi_E_ext = [ones(length(X1(:)),1) X1(:) X2(:) X1(:).^2 X2(:).^2 X1(:).*X2(:) X1(:).^3 X2(:).^3 (X1(:).^2).*X2(:) X1(:).*(X2(:).^2) X1(:).^4 X2(:).^4 ...
    (X1(:).^2).*(X2(:).^2) (X1(:).^3).*X2(:) X1(:).*(X2(:).^3) X1(:).^5 X2(:).^5 (X1(:).^4).*X2(:) X1(:).*(X2(:).^4) (X1(:).^3).*(X2(:).^2) (X1(:).^2).*(X2(:).^3)...
    X1(:).^6 X2(:).^6 (X1(:).^5).*X2(:) X1(:).*(X2(:).^5) (X1(:).^4).*(X2(:).^2) (X1(:).^2).*(X2(:).^4) (X1(:).^3).*(X2(:).^3)];

[theta_E, std_theta_E, q_E, y_hat_E, epsilon_E, SSR_E, y_hat_E_ext, y_hat_E_ext_mat] = identificazioneModello(phi_E, phi_E_ext, X1, y_id_dt);

% Plot Dati + stima (quinto grado)
stampaModello('Modello VI grado',X1,X2,y_hat_E_ext_mat+p, x1_id, x2_id, y_id_dt+p)
%% TEST F
alpha = 0.05;

% Polinomio quarto vs primo terzo
[f_alpha1,f1] = TestF(alpha,n,q_C,SSR_B, SSR_C);

% Polinomio quinto vs quarto
[f_alpha2,f2] = TestF(alpha,n,q_D,SSR_C, SSR_D);

% Polinomio quinto vs sesto
[f_alpha3,f3] = TestF(alpha,n,q_E,SSR_D, SSR_E);

%% FPE, AIC, MDL
%Terzo grado
[FPE3,AIC3,MDL3] = TestOggettivi(n, q_B, SSR_B);

%Quarto grado
[FPE4,AIC4,MDL4] = TestOggettivi(n, q_C, SSR_C);

%Quinto grado
[FPE5,AIC5,MDL5] = TestOggettivi(n, q_D, SSR_D);

%Sesto grado
[FPE6,AIC6,MDL6] = TestOggettivi(n, q_E, SSR_E);

%% CROSSVALIDAZIONE
figure
plot3(x1_id,x2_id,y_id_dt+p,'bo')
hold on
plot3(x1_val, x2_val, y_val_dt+p, 'rx');
hold on
mesh(X1, X2, y_hat_D_ext_mat+p)
grid on
title('Crossvalidazione')
xlabel('Giorno dell''anno')
ylabel('Ora del giorno')
zlabel('Consumo elettrico')
legend('dati di identificazione', 'dati di validazione')
colorbar
colormap('default')

%Terzo grado
phi_B_Val=[ones(n,1) x1_val x2_val x1_val.^2 x2_val.^2 x1_val.*x2_val x1_val.^3 x2_val.^3 (x1_val.^2).*x2_val];
[yhat3Val, epsilon3Val, SSR3Val] = crossvalidazioneModello(phi_B_Val, theta_B, y_val_dt);

%Quarto grado
phi_C_Val=[ones(n,1) x1_val x2_val x1_val.^2 x2_val.^2 x1_val.*x2_val x1_val.^3 x2_val.^3 (x1_val.^2).*x2_val x1_val.*(x2_val.^2) x1_val.^4 x2_val.^4 (x1_val.^2).*(x2_val.^2) (x1_val.^3).*x2_val x1_val.*(x2_val.^3)];
[yhat4Val, epsilon4Val, SSR4Val] = crossvalidazioneModello(phi_C_Val, theta_C, y_val_dt);

%Quinto grado
phi_D_Val=[ones(n,1) x1_val x2_val x1_val.^2 x2_val.^2 x1_val.*x2_val x1_val.^3 x2_val.^3 (x1_val.^2).*x2_val x1_val.*(x2_val.^2) x1_val.^4 x2_val.^4 (x1_val.^2).*(x2_val.^2) (x1_val.^3).*x2_val x1_id.*(x2_val.^3) ...
     x2_val.^5 (x1_val.^4).*x2_val x1_val.*(x2_val.^4) (x1_val.^3).*(x2_val.^2) (x1_val.^2).*(x2_val.^3)];
[yhat5Val, epsilon5Val, SSR5Val] = crossvalidazioneModello(phi_D_Val, theta_D, y_val_dt);

%Sesto grado
phi_E_Val=[ones(n,1) x1_val x2_val x1_val.^2 x2_val.^2 x1_val.*x2_val x1_val.^3 x1_val.^3 (x1_val.^2).*x2_val x1_val.*(x1_val.^2) x1_val.^4 x2_val.^4 (x1_val.^2).*(x1_val.^2) (x1_val.^3).*x2_val x1_val.*(x2_val.^3) ...
     x1_val.^5 x2_val.^5 (x1_val.^4).*x2_val x1_val.*(x2_val.^4) (x1_val.^3).*(x2_val.^2) (x1_val.^2).*(x2_val.^3)...
     x1_val.^6 x2_val.^6 x1_val.^5.*x2_val x1_val.*(x2_val.^5) (x1_val.^4).*(x2_val.^2) (x1_val.^2).*(x2_val.^4) (x1_val.^3).*(x2_val.^3)];
[yhat6Val, epsilon6Val, SSR6Val] = crossvalidazioneModello(phi_E_Val, theta_E, y_val_dt);