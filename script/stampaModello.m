function stampaModello(titolo,O,G,curva_matrix, x1, x2, y)
figure
mesh(O,G,curva_matrix);
hold on
plot3(x1, x2, y, 'o');
title(titolo)
xlabel('Giorno dell''anno')
ylabel('Ora del giorno')
zlabel('Consumo elettrico')
colorbar
colormap('default')
end