% Menentukan berapa meter kawat yang dibutuhkan untuk pagar berbentuk layang-layang
% Panjang sisi layang-layang (misalnya sisi 1 dan sisi 2)
sisi1 = 5; % panjang sisi 1 (misalnya 5 meter)
sisi2 = 3; % panjang sisi 2 (misalnya 3 meter)

% Keliling layang-layang (2 pasang sisi)
keliling = 2 * (sisi1 + sisi2);

fprintf('Jumlah kawat yang dibutuhkan: %.2f meter\n', keliling);

% ======= Gambar layang-layang =======
% Tentukan titik-titik layang-layang
% Asumsikan layang-layang simetris di sekitar sumbu y
x = [0, sisi1, 0, -sisi1, 0];    % titik 1 ke 5 dan kembali ke titik 1
y = [0, sisi2, sisi2+sisi1, sisi2, 0];  % buat bentuk layang-layang

figure;
fill(x, y, [0.7 0.9 0.7]); % warna hijau muda
hold on;
plot(x, y, 'k-', 'LineWidth', 2); % garis tepi layang-layang
axis equal;
grid on;
title('Pagar Layang-Layang (Contoh Soal Geometri)');

% Tampilkan total kawat di tengah layang-layang
text(0, (max(y)+min(y))/2, ...
    sprintf('Keliling = %.2f m', keliling), ...
    'HorizontalAlignment', 'center', 'FontSize', 12, 'FontWeight', 'bold');

% Anotasi sisi
for i = 1:4
    x_mid = (x(i) + x(i+1))/2;
    y_mid = (y(i) + y(i+1))/2;
    if mod(i,2) == 1
        teks = sprintf('%.0f m', sisi1);
    else
        teks = sprintf('%.0f m', sisi2);
    end
    text(x_mid, y_mid, teks, 'FontSize', 10, 'Color', 'blue');
end

hold off;

