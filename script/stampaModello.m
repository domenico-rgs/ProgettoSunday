function stampaModello(G,P,curva_matrix, x1, x2, y)
figure
mesh(G,P,curva_matrix);
hold on
plot3(x1, x2, y, 'o');
title('Profilo orario della domenica durante l''anno')
xlabel('Giorno dell''anno')
ylabel('Ora del giorno')
end