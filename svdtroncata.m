file = '000007.dcm';
image = dicomread(file);
% Calcoliamo l' SVD Troncata dell'immagine
[U, S, V] = svd(double(image));
% Numero di valori singolari da mantenere
t = 50;
Ut = U(:, 1:t);
St = S(1:t, 1:t);
Vt = V(:, 1:t);
% Calcoliamo l'approssimazione dell'immagine originale
troncamento = Ut * St * Vt';
% Visualizziamo l'immagine originale
subplot(1, 2, 1);
imshow(image, []);
title('Immagine Originale');
% Visualizziamo l'immagine dopo SVD Troncata
subplot(1, 2, 2);
imshow(troncamento, []);
title('Immagine Approssimata con SVD Troncata');