%TUGAS PRAKTIKUM 2%

%MEMUAT PACKAGE YANG DIBUTUHKAN HISTOGRAM
pkg load image;

%MEMUAH GAMBAR
img = imread('C:\KULIAH ILMU KOMPUTER\SEMESTER IV\PENGOLAHAN CITRA\image\okk.jfif');
img = im2uint8(img); %gambar dalam format uint8

citra_asli = imread('C:\KULIAH ILMU KOMPUTER\SEMESTER IV\PENGOLAHAN CITRA\image\pp.jfif');

%MENGUBAH CITRA MENJADI ABU-ABU
imgGray = rgb2gray(img);
citra_gray = rgb2gray(citra_asli);

% 1. MENAMPILKAN HISTOGRAM
figure;
subplot(4,1,1);
imhist(img); title('Histogram gambar asli');

R =img(:, :, 1); % Pisahkan Channel RGB
G =img(:, :, 2);
B =img(:, :, 3);

subplot(4,1,2);
imhist(R); title('Histogram Merah');
xlim([0 255]);

subplot(4,1,3);
imhist(G); title('Histogram Hijau');
xlim([0 255]);

subplot(4,1,4);
imhist(B); title('Histogram Biru');
xlim([0 255]);

% 2. MENINGKATKAN KECERAHAN
figure;
subplot(2,2,1);
imshow(imgGray); title('Sebelum dicerahkan');

subplot(2,2,2);
imgCerah = imgGray + 50; %menambahkan kecerahan sebesar 50 piksel
imshow(imgCerah); title('Setelah dicerahkan');

subplot(2,2,3);
imhist(imgGray); title('Histogram Sebelum Dicerahkan');

subplot(2,2,4);
imhist(imgCerah); title('Histogram Setelah Dicerahkan');

% 3. MEREGANGKAN KONTRAS
figure;
subplot(2,2,1);
imshow(imgGray); title('Sebelum diregangkan');

subplot(2,2,3);
imhist(imgGray); title('Histogram sebelum diregangkan');

subplot(2,2,2);
K = 1.7 * imgGray; %mengkalikan dengan nilai 1,7
imshow(K); title('Setelah diregangkan');

subplot(2,2,4);
imhist(K); title('Histogram setelah diregangkan');

% 4. KOMBINASI KECERAHAN DAN KONTRAS
figure;
subplot(2,2,1);
imshow(imgGray); title('Sebelum dikombinasi');

subplot(2,2,3);
imhist(imgGray); title('Histogram sebelum dikombinasi');

subplot(2,2,2);
C = imgGray - 30; %mengurangi kecerahan
k = C * 1.9; %meningkatkan kontras
imshow(k); title('Setelah dikombinasi');

subplot(2,2,4);
imhist(k); title('Histogram setelah dikombinasi');

% 5. MEMBALIKKAN CITRA
figure;
subplot(2,2,1);
imshow(imgGray); title('Sebelum dibalik');

subplot(2,2,3);
imhist(imgGray); title('Histogram sebelum dibalik');

subplot(2,2,2);
imgBalik = 255-imgGray; %mengurangi nilai maksimal citra dengan citra abu-abu
imshow(imgBalik); title('Setelah dibalik');

subplot(2,2,4);
imhist(imgBalik); title('Histogram setelah dibalik');

% 6. PEMETAAN NON LINIER
figure;
subplot(2,2,1);
imshow(imgGray); title('Sebelum dipetakan');

subplot(2,2,3);
imhist(imgGray); title('Histogram sebelum dipetakan');

subplot(2,2,2);
c = log(1+double(imgGray)); %rumusnya
c2 = im2uint8(mat2gray(c));
imshow(c2); title('Setelah dipetakan');

subplot(2,2,4);
imhist(c2); title('Histogram setelah dipetakan');

% 7. PEMOTONGAN ARAS KEABUAN
batas_bawah = 0; %menentukan rentang aras keabuan yang akan dipotong
batas_atas = 50;

nilai_baru = 255; %nilai intensitas baru untuk piksel dalam rentang

citra_baru = citra_gray; %konversi nilai citra
indeks = (citra_gray >= batas_bawah) & (citra_gray <= batas_atas);
citra_baru(indeks) = nilai_baru;

figure;
subplot(2, 2, 1);
imshow(citra_gray); title('Sebelum pemotongan');

subplot(2,2,3);
imhist(citra_gray); title('Histogram sebelum pemotongan');

subplot(2, 2, 2);
imshow(citra_baru);
title(['Sesudah pemotongan[', num2str(batas_bawah), ', ', num2str(batas_atas), ']']);

subplot(2,2,4);
imhist(citra_baru); title('Histogram Setelah pemotongan');

% 8. EKUALIASASI HISTOGRAM
Equal = histeq(imgGray);
figure;
subplot(2,2,1);
imshow(imgGray); title('Sebelum diekualisasi');

subplot(2,2,3);
imhist(imgGray); title('Histogram sebelum diekualisasi');

subplot(2,2,2);
imshow(Equal); title('Setelah diekualisasi');

subplot(2,2,4);
imhist(Equal); title('Histogram Setelah diekualisasi');



