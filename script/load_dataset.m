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

y1=detrend(y,1);
trend = y-y1;
m = mean(trend);

x1_ext = [1:1:365]';
x2_ext = [1:24]';
[X1,X2] = meshgrid(x1_ext, x2_ext);

%Dati identificazione [primo anno]
x1_id = x1(1:1248,1);
x2_id = x2(1:1248,1);
y_id = y1(1:1248,1);

x1_id(289:1:312) = [ ]; % rimuovo outlier giorno 90
x2_id(289:1:312) = [ ];
y_id(289:1:312) = [ ];

x1_id(673:1:696) = [ ]; %rimuovo outlier giorno 209
x2_id(673:1:696) = [ ];
y_id(673:1:696) = [ ];

trend_1=trend(1:1200,1);
n=length(y_id);

%Dati validazione [secondo anno]
x1_val = x1(1249:2448,1);
x2_val = x2(1249:2448,1);
trend_2=trend(1249:2448,1);
y_val = y1(1249:2448,1);
nVal =length(y_val);

%% Visualizzazione dati
figure
plot3(x1_id,x2_id,y_id,'bo')
hold on
plot3(x1_val+365,x2_val,y_val, 'rx')
grid on
title('Carico elettrico italiano di domenica')
xlabel('Giorno dell''anno')
ylabel('Ora del giorno')
zlabel('Consumo elettrico')

figure
x1_s = [1:1:2496]';
plot(x1_s,y)
grid on
title('Carico elettrico italiano di domenica')
ylabel('Consumo elettrico')
