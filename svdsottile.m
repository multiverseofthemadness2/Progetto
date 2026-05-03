file = '000007.dcm';
image = dicomread(file);
% Calcoliamo la SVD sottile
[U, S, V] = svd(double(image), 'econ');
% Visualizziamo l'immagine originale
subplot(1, 2, 1);
imshow(image, []);
title('Immagine Originale');
% Visualizziamo l'immagine dopo aver applicato SVD sottile
immagine_ricostruita = U * S * V';
subplot(1, 2, 2);
imshow(immagine_ricostruita, []);
title('Immagine Ricostruita con SVD sottile');