file = '000007.dcm'; % File DICOM
image = dicomread(file);
% Conversione in double
[U, S, V] = svd(double(image));
% Numero di componenti per il sottospazio dei dati dell'immagine
K = 20;
% Calcoliamo l'approssimazione a rango K
sottospazio_dati_immagine = U(:, 1:K) * S(1:K, 1:K) * V(:, 1:K)';
% Calcolo del Rumore Estratto
rumore_estratto = double(image) - double(sottospazio_dati_immagine);
figure('Name', 'Riduzione del rumore con SVD con K=20');
% Visualizzazione dell'Immagine Originale
subplot(1, 3, 1);
imshow(image, []);
title('Immagine Originale');

% Sottospazio Dati Immagine (Immagine Filtrata)
subplot(1, 3, 2);
imshow(sottospazio_dati_immagine, []);
title(['Immagine Filtrata (K = ' num2str(K) ')']);

% Rumore Estratto 
subplot(1, 3, 3);
imshow(rumore_estratto, []); 
title('Rumore Estratto');