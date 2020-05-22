clear
clc
close all

load_dataset

% Neural Network MLP
setdemorandstream(491218342)
x = {x1_id';x2_id'};
t = y_id_dt';
<<<<<<< HEAD
net = feedforwardnet([23]);
=======
net = feedforwardnet([25]);
>>>>>>> 05f3bc8eeca13d4f66eb6d3d743a4847b2a2e072
net.name='Skynet';
net.numInputs = 2;
net.numLayers = 2;
net.divideParam.trainRatio = 1.0; % training set [%]
net.divideParam.valRatio   = 0.0; % validation set [%]
net.divideParam.testRatio  = 0.0; % test set [%]
net.inputConnect = [1 1; 0 0];
net = configure(net,x);
[net, tr] = train(net,x,t);
nntraintool

% Validazione
validation=[x1_val x2_val];
y = net(validation')+p;
SSR_MLP=sum((y_val_dt+p-y').^2)

figure
plot3(x1_val,x2_val,y,'rx')
hold on
plot3(x1_val, x2_val, y_val_dt+p, 'bo');
grid on
title('Validazione rete MLP')
xlabel('Giorno dell''anno')
ylabel('Ora del giorno')
zlabel('Consumo elettrico')
legend('dati della rete', 'dati da validare')

% Giorno a caso
data = [x1_val(385:1:408) x2_ext]; % giorno 201
carico = net(data')+p;
figure
plot(x2_ext, carico, '-m')
hold on
plot(x2_ext, y_val_dt(385:1:408)+p, '-b')
grid on
title('Validazione giorno 201')
legend('previsione','effettivo')

<<<<<<< HEAD
%% Neural Network RB
net = newrb(x,t,0.0,2,350);
net.name='Will';
y = sim(net,validation')+p;
SSR_RB=sum((y_val_dt+p-y').^2)

% Validazione
figure
plot3(x1_val,x2_val,y,'rx')
hold on
plot3(x1_val, x2_val, y_val_dt+p, 'bo');
grid on
title('Validazione rete RB')
xlabel('Giorno dell''anno')
ylabel('Ora del giorno')
zlabel('Consumo elettrico')
legend('dati della rete', 'dati da validare')

% Giorno a caso
data = [x1_val(385:1:408) x2_ext]; % giorno 201
carico = sim(net,data')+p;
figure
plot(x2_ext, carico, '-m')
hold on
plot(x2_ext, y_val_dt(385:1:408)+p, '-b')
grid on
title('Validazione giorno 201')
legend('previsione','effettivo')
=======
% %% Neural Network RB
% net = newrb(x,t,0.0,2,350);
% net.name='Will';
% y = sim(net,validation')+p;
% SSR_RB=sum((y_val_dt+p-y').^2)
% 
% % Validazione
% figure
% plot3(x1_val,x2_val,y,'rx')
% hold on
% plot3(x1_val, x2_val, y_val_dt+p, 'bo');
% grid on
% title('Validazione rete RB')
% xlabel('Giorno dell''anno')
% ylabel('Ora del giorno')
% zlabel('Consumo elettrico')
% legend('dati della rete', 'dati da validare')
% 
% % Giorno a caso
% data = [x1_val(385:1:408) x2_ext]; % giorno 201
% carico = sim(net,data')+p;
% figure
% plot(x2_ext, carico, '-m')
% hold on
% plot(x2_ext, y_val_dt(385:1:408)+p, '-b')
% grid on
% title('Validazione giorno 201')
% legend('previsione','effettivo')
>>>>>>> 05f3bc8eeca13d4f66eb6d3d743a4847b2a2e072
