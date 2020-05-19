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
trend = y-y_dt;
m = mean(trend);

%Asse X con date complete 
for i = 6:7:730
    for q = 1:24
       axis_X(q,i) = (datetime([2018,01,00]) + caldays(i));
    end
    
end
axis_X = rmmissing(axis_X, 2);
axis_X = reshape(axis_X,[],1);
axis_X_id = axis_X(1:1248,1);
axis_X_val = axis_X(1249:2496,1);

x1_ext = [1:1:365]';
x2_ext = [1:24]';
[X1,X2] = meshgrid(x1_ext, x2_ext);

%Dati identificazione [primo anno]
x1_id = x1(1:1248,1);
x2_id = x2(1:1248,1);
y_id = y_dt(1:1248,1);

trend_1=trend(1:1248,1);
n=length(y_id);

%Dati validazione [secondo anno]
x1_val = x1(1249:2496,1);
x2_val = x2(1249:2496,1);
trend_2=trend(1249:2496,1);
y_val = y_dt(1249:2496,1);
nVal =length(y_val);

%% Visualizzazione dati
% con trend
figure
plot3(axis_X_id,x2_id,y(1:1248,1),'bo')
hold on
plot3(axis_X_val,x2_val,y(1249:2496,1), 'rx')
grid on
title('Carico elettrico italiano di domenica - with trend')
xlabel('Giorno dell''anno')
ylabel('Ora del giorno')
zlabel('Consumo elettrico')
legend('dati di identificazione', 'dati di validazione')

% Detrendizzati
figure
plot3(axis_X_id,x2_id,y_id,'bo')
hold on
plot3(axis_X_val,x2_val,y_val, 'rx')
grid on
title('Carico elettrico italiano di domenica - dati detrend')
xlabel('Giorno dell''anno')
ylabel('Ora del giorno')
zlabel('Consumo elettrico')
legend('dati di identificazione', 'dati di validazione')


%2D giorni
figure
x1_s = axis_X(1:1:2496);
plot(x1_s,y)
grid on
title('Plot dati giornaliero annuale')
ylabel('Consumo elettrico')

% %2D ore
% figure
% plot(x1_s,y)
% grid on
% title('Plot dati orario annuale')
% ylabel('Consumo elettrico')
