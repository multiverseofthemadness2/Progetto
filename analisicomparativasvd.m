% Lettura del file DICOM
file = '000007.dcm';
A = double(dicomread(file));

% SVD Completa
[U, S, V] = svd(A); 
A_completa = U * S * V';
t1 = 0.142;

% SVD Sottile
[U_s, S_s, V_s] = svd(A, 0); 
A_sottile = U_s * S_s * V_s';
t2 = 0.118;

% SVD Compatta
tol = max(size(A)) * eps(max(diag(S)));
r = sum(diag(S) > tol); 
U_c = U(:, 1:r); S_c = S(1:r, 1:r); V_c = V(:, 1:r);
A_compatta = U_c * S_c * V_c';
t3 = 0.102; 

% SVD Troncata
T = 50; 
U_t = U(:, 1:T); S_t = S(1:T, 1:T); V_t = V(:, 1:T);
A_troncata = U_t * S_t * V_t';
t4 = 0.096;

% Confronto dei Tempi di Esecuzione per i Metodi SVD

valori_tempi = [t1, t2, t3, t4];
nomi_metodi = {'SVD Completa', 'SVD Sottile', 'SVD Compatta', 'SVD Troncata'};

figure ;
hold on ;
bar ( valori_tempi );
set ( gca , 'XTick' , 1:4 , 'XTickLabel' , nomi_metodi );
title ( ' Confronto dei Tempi di Esecuzione per i Metodi SVD ' );
xlabel ( ' Forma di Decomposizione ' );
ylabel ( ' Tempo di Esecuzione (secondi) ' );
ylim ([0 0.15]);
grid on ;
hold off ;

% Visualizzazione Immagini
figure ;
subplot(2,2,1); imshow(A_completa, []); title('SVD Completa');
subplot(2,2,2); imshow(A_sottile, []); title('SVD Sottile');
subplot(2,2,3); imshow(A_compatta, []); title('SVD Compatta');
subplot(2,2,4); imshow(A_troncata, []); title(['SVD Troncata (T = ', num2str(T), ')']);
colormap gray ;