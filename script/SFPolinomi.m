clear
clc
close all

load_dataset

%% Modello SF 1 Armonica
phi_B=[ones(n,1) sin(2*pi*x1_id/365) cos(2*pi*x1_id/365) sin(2*pi*x2_id/24) cos(2*pi*x2_id/24)];
phi_B_ext = [ones(length(X1(:)),1) sin(2*pi*X1(:)/365) cos(2*pi*X1(:)/365) sin(2*pi*X2(:)/24) cos(2*pi*X2(:)/24)];

[theta_B, std_theta_B, q_B, y_hat_B, epsilon_B, SSR_B, y_hat_B_ext, y_hat_B_ext_mat] = identificazioneModello(phi_B, phi_B_ext, X1, y_id_dt);

% Plot Dati + stima 
stampaModello('Modello 1 armoniche',X1,X2,y_hat_B_ext_mat+p, x1_id, x2_id, y_id_dt+p)

%% Modello SF 2 Armoniche
phi_C=[ones(n,1) sin(2*pi*x1_id/365) cos(2*pi*x1_id/365) sin(2*pi*2*x1_id/365) cos(2*pi*2*x1_id/365) sin(2*pi*x2_id/24) cos(2*pi*x2_id/24) sin(2*pi*2*x2_id/24) cos(2*pi*2*x2_id/24)];
phi_C_ext = [ones(length(X1(:)),1) sin(2*pi*X1(:)/365) cos(2*pi*X1(:)/365) sin(2*pi*2*X1(:)/365) cos(2*pi*2*X1(:)/365) sin(2*pi*X2(:)/24) cos(2*pi*X2(:)/24) sin(2*pi*2*X2(:)/24) cos(2*pi*2*X2(:)/24)];

[theta_C, std_theta_C, q_C, y_hat_C, epsilon_C, SSR_C, y_hat_C_ext, y_hat_C_ext_mat] = identificazioneModello(phi_C, phi_C_ext, X1, y_id_dt);

% Plot Dati + stima
stampaModello('Modello 2 armoniche',X1,X2,y_hat_C_ext_mat+p, x1_id, x2_id, y_id_dt+p)

%% Modello SF 3 Armoniche
phi_D=[ones(n,1) sin(2*pi*x1_id/365) cos(2*pi*x1_id/365) sin(2*pi*2*x1_id/365) cos(2*pi*2*x1_id/365) sin(2*pi*3*x1_id/365) cos(2*pi*3*x1_id/365)...
    sin(2*pi*x2_id/24) cos(2*pi*x2_id/24) sin(2*pi*2*x2_id/24) cos(2*pi*2*x2_id/24) sin(2*pi*3*x2_id/24) cos(2*pi*3*x2_id/24)];
phi_D_ext = [ones(length(X1(:)),1) sin(2*pi*X1(:)/365) cos(2*pi*X1(:)/365) sin(2*pi*2*X1(:)/365) cos(2*pi*2*X1(:)/365) sin(2*pi*3*X1(:)/365) cos(2*pi*3*X1(:)/365)...
    sin(2*pi*X2(:)/24) cos(2*pi*X2(:)/24) sin(2*pi*2*X2(:)/24) cos(2*pi*2*X2(:)/24) sin(2*pi*3*X2(:)/24) cos(2*pi*3*X2(:)/24)];

[theta_D, std_theta_D, q_D, y_hat_D, epsilon_D, SSR_D, y_hat_D_ext, y_hat_D_ext_mat] = identificazioneModello(phi_D, phi_D_ext, X1, y_id_dt);


save('theta.mat','theta_D');

% Plot Dati + stima 
stampaModello('Modello 3 armoniche',X1,X2,y_hat_D_ext_mat+p, x1_id, x2_id, y_id_dt+p)

%% Modello SF 4 Armoniche
phi_E=[ones(n,1) sin(2*pi*x1_id/365) cos(2*pi*x1_id/365) sin(2*pi*2*x1_id/365) cos(2*pi*2*x1_id/365) sin(2*pi*3*x1_id/365) cos(2*pi*3*x1_id/365) sin(2*pi*4*x1_id/365) cos(2*pi*4*x1_id/365)...
    sin(2*pi*x2_id/24) cos(2*pi*x2_id/24) sin(2*pi*2*x2_id/24) cos(2*pi*2*x2_id/24) sin(2*pi*3*x2_id/24) cos(2*pi*3*x2_id/24) sin(2*pi*4*x2_id/24) cos(2*pi*4*x2_id/24)];
phi_E_ext = [ones(length(X1(:)),1) sin(2*pi*X1(:)/365) cos(2*pi*X1(:)/365) sin(2*pi*2*X1(:)/365) cos(2*pi*2*X1(:)/365) sin(2*pi*3*X1(:)/365) cos(2*pi*3*X1(:)/365) sin(2*pi*4*X1(:)/365) cos(2*pi*4*X1(:)/365)...
    sin(2*pi*X2(:)/24) cos(2*pi*X2(:)/24) sin(2*pi*2*X2(:)/24) cos(2*pi*2*X2(:)/24) sin(2*pi*3*X2(:)/24) cos(2*pi*3*X2(:)/24) sin(2*pi*4*X2(:)/24) cos(2*pi*4*X2(:)/24)];

[theta_E, std_theta_E, q_E, y_hat_E, epsilon_E, SSR_E, y_hat_E_ext, y_hat_E_ext_mat] = identificazioneModello(phi_E, phi_E_ext, X1, y_id_dt);

% Plot Dati + stima 
stampaModello('Modello 4 armoniche',X1,X2,y_hat_E_ext_mat+p, x1_id, x2_id, y_id_dt+p)


%% TEST F
alpha = 0.05;

% Seconda armonica vs prima armonica
[f_alpha1,f1] = TestF(alpha,n,q_C,SSR_B, SSR_C);

% Terza armonica vs seconda armonica
[f_alpha2,f2] = TestF(alpha,n,q_D,SSR_C, SSR_D);

% Quarta armonica vs terza armonica
[f_alpha3,f3] = TestF(alpha,n,q_E,SSR_D, SSR_E);
%% FPE, AIC, MDL
%Prima armonica
[FPE_1,AIC_1,MDL_1] = TestOggettivi(n, q_B, SSR_B);

%Seconda armonica
[FPE_2,AIC_2,MDL_2] = TestOggettivi(n, q_C, SSR_C);

%Terza armonica
[FPE_3,AIC_3,MDL_3] = TestOggettivi(n, q_D, SSR_D);

%Quarta armonica
[FPE_4,AIC_4,MDL_4] = TestOggettivi(n, q_E, SSR_E);

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

%1 armonica
phi_B_Val=[ones(n,1) sin(2*pi*x1_val/365) cos(2*pi*x1_val/365) sin(2*pi*x2_val/24) cos(2*pi*x2_val/24)];
[yhat3Val, epsilon3Val, SSR1Val] = crossvalidazioneModello(phi_B_Val, theta_B, y_val_dt);

%2 armoniche
phi_C_Val=[ones(n,1) sin(2*pi*x1_val/365) cos(2*pi*x1_val/365) sin(2*pi*2*x1_val/365) cos(2*pi*2*x1_val/365) sin(2*pi*x2_val/24) cos(2*pi*x2_val/24) sin(2*pi*2*x2_val/24) cos(2*pi*2*x2_val/24)];
[yhat4Val, epsilon4Val, SSR2Val] = crossvalidazioneModello(phi_C_Val, theta_C, y_val_dt);

%3 armoniche
phi_D_Val=[ones(n,1) sin(2*pi*x1_val/365) cos(2*pi*x1_val/365) sin(2*pi*2*x1_val/365) cos(2*pi*2*x1_val/365) sin(2*pi*3*x1_val/365) cos(2*pi*3*x1_val/365)...
    sin(2*pi*x2_val/24) cos(2*pi*x2_val/24) sin(2*pi*2*x2_val/24) cos(2*pi*2*x2_val/24) sin(2*pi*3*x2_val/24) cos(2*pi*3*x2_val/24)];
[yhat5Val, epsilon5Val, SSR3Val] = crossvalidazioneModello(phi_D_Val, theta_D, y_val_dt);

%4 armoniche
phi_E_Val=[ones(n,1) sin(2*pi*x1_val/365) cos(2*pi*x1_val/365) sin(2*pi*2*x1_val/365) cos(2*pi*2*x1_val/365) sin(2*pi*3*x1_val/365) cos(2*pi*3*x1_val/365) sin(2*pi*4*x1_val/365) cos(2*pi*4*x1_val/365)...
    sin(2*pi*x2_val/24) cos(2*pi*x2_val/24) sin(2*pi*2*x2_val/24) cos(2*pi*2*x2_val/24) sin(2*pi*3*x2_val/24) cos(2*pi*3*x2_val/24) sin(2*pi*4*x2_val/24) cos(2*pi*4*x2_val/24)];
[yhat6Val, epsilon6Val, SSR4Val] = crossvalidazioneModello(phi_E_Val, theta_E, y_val_dt);
