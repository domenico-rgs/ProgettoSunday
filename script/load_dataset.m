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

y_dt=detrend(y,1);
p=polyfit(linspace(1,1,2496),y-y_dt,0);

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
y_val_dt=y_dt(1249:2496,1);
nVal =length(y_val);

%% Visualizzazione dati
% con trend
figure
plot3(x1_id,x2_id,y_id,'bo')
hold on
plot3(x1_val+365,x2_val,y_val, 'rx')
grid on
title('Carico elettrico italiano di domenica - with trend')
xlabel('Giorno dell''anno')
ylabel('Ora del giorno')
zlabel('Consumo elettrico')
legend('dati di identificazione', 'dati di validazione')

% Detrendizzati
figure
plot3(x1_id,x2_id,y_id_dt+p,'bo')
hold on
plot3(x1_val+365,x2_val,y_val_dt+p, 'rx')
grid on
title('Carico elettrico italiano di domenica - without trend')
xlabel('Giorno dell''anno')
ylabel('Ora del giorno')
zlabel('Consumo elettrico')
legend('dati di identificazione', 'dati di validazione')


%2D giorni
figure
x1_s = [1:1:2496]';
plot(x1_s,y)
grid on
title('Plot dati giornaliero annuale')
ylabel('Consumo elettrico')

% % %2D ore
% % figure
% % plot(x1_s,y)
% % grid on
% % title('Plot dati orario annuale')
% % ylabel('Consumo elettrico')
