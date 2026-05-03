file = '000007.dcm';
image = dicomread(file);
% SVD
[U, S, V] = svd(double(image)); 
m = size(image, 1);
n = size(image, 2);

valori_singolari_da_visualizzare = [10, 20, 50, 100];

% Inizializzazione corretta
rapporto_compressione = zeros(1,length(valori_singolari_da_visualizzare));
rango_di_approssimazione = zeros(1,length(valori_singolari_da_visualizzare));

figure;
for i = 1:length(valori_singolari_da_visualizzare)
k = valori_singolari_da_visualizzare(i);
immagine_compressa = U(:, 1:k)*S(1:k, 1:k)* V(:,1:k)';

% Calcolo del rapporto di compressione (metrica di memoria occupata)
compression_ratio = (((n * k) + k + (m * k))/(m * n))*100;
rapporto_compressione(i) = compression_ratio;
rango_di_approssimazione(i) = k;

subplot(2, 2, i);
imshow(immagine_compressa, []);
title(['k = ' num2str(k) ', CR = ' num2str(compression_ratio) '%']);
end