clear
clc
close all

load_dataset

%% Neural Network MLP
setdemorandstream(491218342)
x = {x1_id';x2_id'};
t = y_id';
net = feedforwardnet(10);
net.name='Skynet';
net.numInputs = 2;
net.trainParam.max_fail = 6;
net.inputConnect = [1 1; 0 0];
net = configure(net,x);
[net, tr] = train(net,x,t);
nntraintool

% Validazione
validation=[x1_val x2_val];
y = net(validation');
perf = perform(net,y_val,y)
 
figure
plot3(x1_val,x2_val,y+m,'rx')
hold on
plot3(x1_val, x2_val, y_val+trend_2, 'bo');
grid on
title('Carico elettrico italiano di Domenica')
xlabel('Giorno dell''anno')
ylabel('Ora del giorno')
zlabel('Consumo elettrico')
legend('dati della rete', 'dati da validare')

% Giorno a caso
data = [x1_val(745:1:768) x2_ext]; % giorno 201
carico = net(data');
figure
plot(x2_ext, carico+m, '-m')
hold on
plot(x2_ext, y_val(745:1:768)+m, '-b')
grid on
legend('previsione','effettivo')

% %% Neural Network RB
% net = newrb(x,t,1.0,3,200);
% net.name='Will';
% y = sim(net,validation');
% perf = perform(net,y_val,y)
% 
% % Validation
% figure
% plot3(x1_val,x2_val,y+m,'rx')
% hold on
% plot3(x1_val, x2_val, y_val+trend_2, 'bo');
% grid on
% title('Carico elettrico italiano di Domenica')
% xlabel('Giorno dell''anno')
% ylabel('Ora del giorno')
% zlabel('Consumo elettrico')
% legend('dati della rete', 'dati da validare')