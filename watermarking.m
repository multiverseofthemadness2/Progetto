% Caricamento Immagine DICOM
file = '000007.dcm';
image = dicomread(file);
img = double(image(:,:,1)); % Semplificato per 2D

w_data = dicomread(file); 
w = double(w_data(:,:,1));

% 2. Parametri e SVD
alpha = 0.005; 
[U, S, V] = svd(img);
w_r = imresize(w, size(S));

% Otteniamo Uw e Vw (la "forma") e Sw (l'energia) del watermark
[Uw, Sw, Vw] = svd(w_r); 

% Inserimento coerente:
S_wt = S + alpha * Sw; 
w_img = U * S_wt * V'; 

% Visualizzazione Risultati Inserimento
w_img_u8 = uint8(255 * (w_img - min(w_img(:))) / (max(w_img(:)) - min(w_img(:))));
img_u8 = uint8(255 * (img - min(img(:))) / (max(img(:)) - min(img(:))));
w_u8 = uint8(255 * (w - min(w(:))) / (max(w(:)) - min(w(:))));

figure(1);
subplot(1,3,1); imshow(img_u8); title('Immagine Originale');
subplot(1,3,2); imshow(w_img_u8); title('Con Watermark');
subplot(1,3,3); imshow(w_u8); title('Watermark');

[~, S_w_est, ~] = svd(w_img); % SVD dell'immagine marchiata
Sw_recuperata = (S_w_est - S) / alpha; % Isolo i valori singolari

w_estratto_finale = Uw * Sw_recuperata * Vw'; 

% Visualizzazione Risultati Estrazione 
norm_w_e = uint8(255 * (w_estratto_finale - min(w_estratto_finale(:))) ...
    / (max(w_estratto_finale(:)) - min(w_estratto_finale(:))));

figure(2);
subplot(1,2,1); imshow(w_u8); title('Watermark Originale');
subplot(1,2,2); imshow(norm_w_e); title('Watermark Estratto');