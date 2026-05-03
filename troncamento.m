

% Caricamento e Preparazione dell'Immagine Originale
file = 'COVID-101.png';

% Carica l'immagine medica e converti in double
image=imread(file)

% Carica l'immagine medica e converti in double
A = double(image);
[m, n] = size(A);

% Aggiunta del Rumore Gaussiano
livello_rumore = 30; % Fattore di scala per il rumore
rumore = livello_rumore * randn(m, n); 

A_rumorosa = A + rumore; 

% Definizione del Rango di Troncamento 
T = 50; 

% SVD e Troncamento sulla Matrice Rumorosa 
[U_hat, S_hat, V_hat] = svd(A_rumorosa);

% Troncamento e ricostruzione con solo i primi T componenti
U_T = U_hat(:, 1:T);
S_T = S_hat(1:T, 1:T);
V_T = V_hat(:, 1:T);

% Img_Recuperata è la nostra stima finale (A_T)
img_Recuperata = U_T * S_T * V_T'; 

% Visualizzazione
figure;

subplot(1, 3, 1);
imshow(A, []);
title('Immagine Originale');

subplot(1, 3, 2);
imshow(A_rumorosa, []);
title('Immagine Rumorosa');

subplot(1, 3, 3);
imshow(img_Recuperata, []);
title(['Immagine Recuperata (T=', num2str(T), ')']);

% Selezione della 100esima riga
riga = 100;

% Profili di intensità
profilo_originale  = A(riga, :);
profilo_rumoroso   = A_rumorosa(riga, :);
profilo_recuperato = img_Recuperata(riga, :);

% Grafico del profilo di intensità
figure;
plot(profilo_originale, 'b', 'LineWidth', 1.5);
hold on;
plot(profilo_rumoroso, 'r', 'LineWidth', 1);
plot(profilo_recuperato, 'g', 'LineWidth', 1.5);
hold off;

grid on;
xlabel('Indice del pixel');
ylabel('Intensità');
title("Confronto del Profilo di Intensità lungo una Riga dell'immagine");
legend('Originale', 'Rumorosa', 'Recuperata');
