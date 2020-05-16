clear
clc
close all

load_dataset

%% Neural Network
setdemorandstream(491218342)
x = {x1_id';x2_id'};
t = y_id';
net = feedforwardnet(8);
net.name='Skynet';
net.numInputs = 2;
net.trainParam.max_fail = 10;
net.inputConnect = [1 1; 0 0];
net = configure(net,x);
[net, tr] = train(net,x,t);
nntraintool


%% Validazione
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