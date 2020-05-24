clear
clc
close all

load_dataset

% Neural Network MLP
setdemorandstream(491218342)
x = {x1_id';x2_id'};
t = y_id_dt';
net = feedforwardnet([25]);
net.name='Skynet';
net.numInputs = 2;
net.numLayers = 2;
net.divideParam.trainRatio = 1.0; % training set [%]
net.divideParam.valRatio   = 0.0; % validation set [%]
net.divideParam.testRatio  = 0.0; % test set [%]
net.inputConnect = [1 1; 0 0];
net = configure(net,x);
[net, tr] = train(net,x,t);
view(net)
nntraintool

% Validazione
validation=[x1_val x2_val];
y = net(validation');
SSR_MLP=sum((y_val_dt-y').^2)

figure
plot3(x1_val,x2_val,y+p,'rx')
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
title('Validazione MLP giorno 201')
legend('previsione','effettivo')

% %% Neural Network RB
% net = newrb(x,t,0.0,2,300);
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
% title('Validazione RB giorno 201')
% legend('previsione','effettivo')
