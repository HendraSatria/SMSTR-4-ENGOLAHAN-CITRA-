##
##
##% Membaca Citra
##img = imread('C:/KULIAH ILMU KOMPUTER/SEMESTER IV/PENGOLAHAN CITRA/uts/pp.jfif');
##
##% Menampilkan Citra Berwarna
##figure;
##imshow(img);
##title('Citra Berwarna');
##
##% Menampilkan Ukuran Citra
##disp('Ukuran citra:');
##disp(size(img));
##
##% Mengkonversi citra ke grayscale
##grayimg = rgb2gray(img);
##figure;
##imshow(grayimg);
##title('Citra Grayscale');
##
##% Mengkonversi grayscale ke biner
##threshold = 128;
##citra_biner = grayimg > threshold;
##
##% Menampilkan ketiganya dalam satu figure
##figure;
##subplot(1,3,1); imshow(img); title('Citra Berwarna');
##subplot(1,3,2); imshow(grayimg); title('Grayscale');
##subplot(1,3,3); imshow(citra_biner); title('Biner');
##
##% ==============================
##% Fungsi Kuantisasi (harus di akhir file di Octave jika inline)
##function qimg = kuantisasi(grayimg, level)
##  step = 256 / level;
##  qimg = floor(double(grayimg) / step) * step + step/2;
##  qimg = uint8(qimg);
##end
##
##% Kuantisasi ke 2, 4, dan 8 tingkat keabuan
##q2 = kuantisasi(grayimg, 2);
##q4 = kuantisasi(grayimg, 4);
##q8 = kuantisasi(grayimg, 8);
##
##% Menampilkan hasil kuantisasi
##figure;
##subplot(2,2,1); imshow(grayimg); title('Asli (256 tingkat)');
##subplot(2,2,2); imshow(q2); title('Kuantisasi 2 tingkat');
##subplot(2,2,3); imshow(q4); title('Kuantisasi 4 tingkat');
##subplot(2,2,4); imshow(q8); title('Kuantisasi 8 tingkat');
##
##% ==============================
##% EKUALISASI HISTOGRAM
##
##% Gunakan grayimg dari atas
##Equal = histeq(grayimg);
##
##figure;
##subplot(2,2,1);
##imshow(grayimg); title('Sebelum Ekualisasi');
##
##subplot(2,2,2);
##imshow(Equal); title('Setelah Ekualisasi');
##
##subplot(2,2,3);
##imhist(grayimg); title('Histogram Sebelum');
##
##subplot(2,2,4);
##imhist(Equal); title('Histogram Setelah');
pkg load image; % Aktifkan package image

% === 1. Load gambar ===
img = imread('C:\KULIAH ILMU KOMPUTER\SEMESTER IV\PENGOLAHAN CITRA\uts\no7.jfif'); % Ganti dengan nama file gambarmu

% === 2. Tentukan sudut rotasi agar gambar tegak lurus ===
% Misal sudut miring = 20 derajat (positif = putar berlawanan jarum jam)
theta = -20; % Rotasi negatif agar gambar tegak lurus

% === 3. Rotasi gambar dengan interpolasi bilinear ===
rotated_img = imrotate(img, theta, 'bilinear', 'crop');

% === 4. Perbesar citra (zoom) ===
scale_factor = 2; % Perbesar 2 kali lipat
resized_img = imresize(rotated_img, scale_factor, 'bilinear');

% === 5. Tampilkan hasil ===
figure;
subplot(1,2,1);
imshow(img);
title('Asli (Miring)');

subplot(1,2,2);
imshow(rotated_img);
title(['Rotasi Tegak & Perbesar ']);



