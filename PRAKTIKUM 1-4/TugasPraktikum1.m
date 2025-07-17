%Tugas Praktikum 1%

%Membaca Citra%

img=imread('dedaunan.png');

%Menampilkan Citra%

imshow(img);
title('Citra berwarna')
%menampilkan Ukuran Citra%

size(img)

%mengkonversi citra warna ke greyscale%
grayimg = rgb2gray(img);

figure;
imshow(grayimg);
title ('Citra Greyscale');
%mengkonversi citra warna greyscale ke biner%
threshold = 128;
citra_biner = grayimg > threshold;
figure;
imshow(citra_biner);
title('CitraBiner');
subplot(1,3,1);imshow(img);title('Citra berwarna');
subplot(1,3,2);imshow(grayimg);title('Citra Greyscale');
subplot(1,3,3);imshow(citra_biner);title('CitraBiner');

%menyimpan Citra %
imwrite(img,'C:/KULIAH ILMU KOMPUTER/SEMESTER IV/PENGOLAHAN CITRA/image/image/Citra Berwarna.jpg');
imwrite(grayimg,'C:/KULIAH ILMU KOMPUTER/SEMESTER IV/PENGOLAHAN CITRA/image/image/Citra Greyscale.jpg');
imwrite(citra_biner,'C:/KULIAH ILMU KOMPUTER/SEMESTER IV/PENGOLAHAN CITRA/image/image/CitraBiner.jpg');







