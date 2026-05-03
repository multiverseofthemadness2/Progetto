file = '000007.dcm';
image = dicomread(file);
% Calcoliamo la SVD Compatta
[U, S, V] = svd(double(image));
% Specifichiamo il numero di valori singolari
r = 50;
Ur = U(:, 1:r);
Sr = S(1:r, 1:r);
Vr = V(:, 1:r);
% Visualizziamo l'immagine originale
subplot(1, 2, 1);
imshow(image, []);
title('Immagine Originale');
% Visualizziamo l'immagine dopo la SVD Compatta
immagine_ricostruita = Ur * Sr * Vr';
subplot(1, 2, 2);
imshow(immagine_ricostruita, []);
title(['Immagine Ricostruita con  SVD Compatta']);