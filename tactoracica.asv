% Nome del file DICOM caricato
file = '000007.dcm';

% Lettura dell'immagine 
image = dicomread(file);

% Converti l'immagine al tipo double per l'elaborazione con SVD
[U, S, V] = svd(double(image));

% Definizione dei Livelli di Compressione
valori_singolari = [10, 25, 50, 75, 100];

% Valori singolari
sigma = diag(S);

% Energia totale
energia_totale = sum(sigma.^2);

% Preallocazione
informazione_catturata = zeros(size(valori_singolari));

% Calcolo percentuale di informazione
for i = 1:length(valori_singolari)
    K = valori_singolari(i);
    informazione_catturata(i) = ...
        sum(sigma(1:K).^2) / energia_totale * 100;
end

% Visualizzazione dei Risultati
figure;
set(gcf, 'Name', 'Compressione Immagine TC con SVD'); 

% Aggiungiamo un subplot per l'immagine originale
subplot(2, 3, 1);
% Visualizziamo l'immagine originale, usando la versione intera (image_uint) 
% o la versione double (image) con [] per la corretta scalatura.
imshow(image, []);
title('1. Immagine Originale');
colormap gray; 

% Ciclo per ricostruire e visualizzare le immagini compresse
for i = 1:length(valori_singolari)
    K = valori_singolari(i);
    
    % Riduciamo la dimensione delle matrici per l'approssimazione a basso rango
    U_k = U(:, 1:K);
    S_k = S(1:K, 1:K);
    V_k = V(:, 1:K);
    
    % Ricostruiamo l'immagine utilizzando la formula dell'approssimazione
    % La matrice risultante è di tipo double.
    immagine_ricostruita = U_k * S_k * V_k';
    
    % Aggiungiamo un subplot per l'immagine ricostruita
    subplot(2, 3, i + 1);
    
    % Visualizziamo l'immagine ricostruita
    imshow(immagine_ricostruita, []);
    title(['K = ', num2str(K)]);
    colormap gray; 
end
figure;
hold on;
plot(valori_singolari, informazione_catturata, '-o', 'LineWidth', 1.5);
xlabel('Numero di Valori Singolari Mantenuti');
ylabel('Informazione catturata (%)');
title('Informazione catturata vs Numero di Valori Singolari Mantenuti');
ylim([90 100]);
hold off;
figure;
hold on;
bar(valori_singolari, informazione_catturata);
xlabel('Numero di Valori Singolari Mantenuti');
ylabel('Informazione catturata (%)');
title('Informazione catturata vs Numero di Valori Singolari Mantenuti');
ylim([0 100]);
hold off;
