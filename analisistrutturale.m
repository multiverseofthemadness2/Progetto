
% Caricamento dell'Immagine Originale
file = 'COVID-101.png';
% Caricamento e conversione immediata in double
image = double(imread(file));

% Creazione delle due varianti per l'analisi 
% Variante "Liscia": applicazione di filtro Gaussiano (rimozione alte frequenze)
immagine_liscia = imgaussfilt(image, 2); 

% Variante "Rugosa": aggiunta di rumore gaussiano (introduzione alte frequenze)
immagine_rugosa = imnoise(uint8(image), 'gaussian', 0, 0.05);
immagine_rugosa = double(immagine_rugosa);

% Calcolo SVD per le due varianti
[U_l, S_l, V_l] = svd(immagine_liscia);
[U_r, S_r, V_r] = svd(immagine_rugosa);

% Estrazione valori singolari per il confronto (vettori diagonali)
s_liscia = diag(S_l);
s_rugosa = diag(S_r);

% Confronto Visivo tra le varianti analizzate
figure('Name', 'Confronto Varianti Immagine');
subplot(1,2,1); 
imshow(uint8(immagine_liscia)); 
title('Immagine Liscia');

subplot(1,2,2); 
imshow(uint8(immagine_rugosa)); 
title('Immagine Rugosa');

% Scegliamo un rango ridotto 
k = 50; 
% Ricostruzione dell'immagine liscia
img_liscia_rec = U_l(:,1:k) * S_l(1:k,1:k) * V_l(:,1:k)';

% Ricostruzione dell'immagine rugosa
img_rugosa_rec = U_r(:,1:k) * S_r(1:k,1:k) * V_r(:,1:k)';

% Visualizzazione del confronto delle ricostruzioni
figure('Name', ['Ricostruzione con k = ', num2str(k)]);
subplot(1,2,1);
imshow(uint8(img_liscia_rec))
title(['Liscia Ricostruita (k=', num2str(k), ')']);

subplot(1,2,2);
imshow(uint8(img_rugosa_rec));
title(['Rugosa Ricostruita (k=', num2str(k), ')']);  

% Decadimento dei Valori Singolari
figure('Name', 'Analisi Valori Singolari');
semilogy(s_liscia(1:100), 'b', 'LineWidth', 2); hold on;
semilogy(s_rugosa(1:100), 'r', 'LineWidth', 2);
title('Analisi Strutturale: Decadimento Valori Singolari');
xlabel('Indice k'); 
ylabel('Valore Singolare \sigma_k');
legend('Immagine Liscia', 'Immagine Rugosa');
grid on;