function [dati_mean] = consumoMedioGiornaliero(y)
dati_mean = ones(52,1);
b = 0;
temp = 0;
for a = 1:52
     c = 1+b;
    for r =(c):(c + 23)
         temp = temp + y(r,1);
         dati_mean(a,1) = temp;
         temp = 0;
    end
    b = 24 * a;
end
end