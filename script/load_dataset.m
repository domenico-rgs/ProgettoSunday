%% Import dati
opts=detectImportOptions('../dati/caricoITAhour.xlsx');
opts.VariableNamesRange = 'A2';
opts.DataRange='A3';
dati=readtable('../dati/caricoITAhour.xlsx', opts);

%% Dataset
dati_domenica = dati(dati.giorno_settimana==1&not(isnan(dati.dati)),:);
x1=dati_domenica.giorno_anno;
x2=dati_domenica.ora_giorno;

%Dati consumo di Domenica su due anni
y=dati_domenica.dati;

%Dati consumo giornaliero su due anni
dati_totali = dati.dati;

%Detrend
y_dt=detrend(y,1);
p=polyfit(linspace(1,1,2496)',y-y_dt,0);

%Griglia
x1_ext = [1:1:365]';
x2_ext = [1:24]';
[X1,X2] = meshgrid(x1_ext, x2_ext);

%Dati identificazione [primo anno]
x1_id = x1(1:1248,1);
x2_id = x2(1:1248,1);
y_id = y(1:1248,1);
y_id_dt=y_dt(1:1248,1);
n=length(y_id);

%Dati validazione [secondo anno]
x1_val = x1(1249:2496,1);
x2_val = x2(1249:2496,1);
y_val = y(1249:2496,1);
y_val_dt = y_dt(1249:2496,1);
nVal = length(y_val);

%% Visualizzazione dati
%Con trend
figure
plot3(x1_id,x2_id,y_id,'bo')
hold on
plot3(x1_val+365,x2_val,y_val, 'ro')
grid on
title('Carico elettrico italiano di Domenica')
xlabel('Giorno dell''anno')
ylabel('Ora del giorno')
zlabel('Consumo elettrico')
legend('Dati del primo anno', 'Dati del secondo anno')

% Detrendizzati
figure
plot3(x1_id,x2_id,y_id_dt+p,'bo')
hold on
plot3(x1_val+365,x2_val,y_val_dt+p, 'ro')
grid on
title('Carico elettrico italiano di Domenica - senza trend')
xlabel('Giorno dell''anno')
ylabel('Ora del giorno')
zlabel('Consumo elettrico')
legend('Dati del primo anno', 'Dati del secondo anno')



% Media carico elettrico Domenica
[dati_mean_id] = consumoMedioGiornaliero(y_id, 52);
[dati_mean_val] = consumoMedioGiornaliero(y_val, 52);
figure
xl_s = [1:1:52];
plot(xl_s, dati_mean_id)
hold on
plot(xl_s, dati_mean_val)
grid on
title('Consumo elettrico medio di Domenica')
ylabel('Consumo elettrico')
xlabel('Domenica dell''anno')
legend('Dati primo anno', 'Dati secondo anno')