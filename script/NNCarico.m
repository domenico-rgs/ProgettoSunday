close all
clc
clear all

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

x1_ext = [1:1:365]';
x2_ext = [1:24]';
[X1,X2] = meshgrid(x1_ext, x2_ext);

%Dati identificazione [primo anno]
x1_id = x1(1:1248,1);
x2_id = x2(1:1248,1);
y_id = y(1:1248,1);
n=length(y_id);

%Dati validazione [secondo anno]
x1_val = x1(1249:2496,1);
x2_val = x2(1249:2496,1);
y_val = y(1249:2496,1);
nVal =length(y_val);


%% Neural Network
input = [x1_id x2_id]; 
target = [y_id]; 
net = feedforwardnet(2);
net = train(net, input', target'); 
nntraintool

validation=[x1_val x2_val];
y = net(input');
perf = perform(net,y,y_val)

