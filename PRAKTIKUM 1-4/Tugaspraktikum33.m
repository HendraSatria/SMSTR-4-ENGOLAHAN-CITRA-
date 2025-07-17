pkg load image; % untuk Octave, pastikan ini diaktifkan

% Membaca gambar
F1 = imread('C:\KULIAH ILMU KOMPUTER\SEMESTER IV\PENGOLAHAN CITRA\image\Lion_Gaussian_Noise.png');
F2 = imread('C:\KULIAH ILMU KOMPUTER\SEMESTER IV\PENGOLAHAN CITRA\image\Lion_Poisson_Noise.png');
F3 = imread('C:\KULIAH ILMU KOMPUTER\SEMESTER IV\PENGOLAHAN CITRA\image\Lion_Quantization_Noise.png');
F4 = imread('C:\KULIAH ILMU KOMPUTER\SEMESTER IV\PENGOLAHAN CITRA\image\Lion_Salt_and_Pepper_Noise.png');
F5 = imread('C:\KULIAH ILMU KOMPUTER\SEMESTER IV\PENGOLAHAN CITRA\image\Lion_Speckle_Noise.png');

gambar_asli = {F1, F2, F3, F4, F5};
nama_gambar = {
    'Lion Gaussian Noise',
    'Lion Poisson Noise',
    'Lion Quantization Noise',
    'Lion Salt and Pepper Noise',
    'Lion Speckle Noise'
};

%% FILTER BATAS (Figure 1–5)
for i = 1:5
    img = gambar_asli{i};
    if ndims(img) == 3
        img = rgb2gray(img);
    end
    [tinggi, lebar] = size(img);
    G = img;

    for baris = 2:tinggi-1
        for kolom = 2:lebar-1
            neighbor = [img(baris-1, kolom-1), img(baris-1, kolom), img(baris-1, kolom+1), ...
                        img(baris, kolom-1), img(baris, kolom+1), ...
                        img(baris+1, kolom-1), img(baris+1, kolom), img(baris+1, kolom+1)];
            minPiksel = min(neighbor);
            maksPiksel = max(neighbor);
            if img(baris, kolom) < minPiksel
                G(baris, kolom) = minPiksel;
            elseif img(baris, kolom) > maksPiksel
                G(baris, kolom) = maksPiksel;
            end
        end
    end

    figure(i); % Figure 1–5
    subplot(2,2,1); imshow(img); title(['Sebelum - ' nama_gambar{i}]);
    subplot(2,2,2); imshow(G); title('Sesudah (Filter Batas)');
    subplot(2,2,3); imhist(img); title('Histogram Sebelum');
    subplot(2,2,4); imhist(G); title('Histogram Sesudah');
end

%% FILTER PERERATAAN (Figure 6–10)
for i = 1:5
    img = gambar_asli{i};
    if ndims(img) == 3
        img = rgb2gray(img);
    end
    img_double = double(img);
    [tinggi, lebar] = size(img_double);
    G = zeros(tinggi, lebar);

    for baris = 2:tinggi-1
        for kolom = 2:lebar-1
            blok = img_double(baris-1:baris+1, kolom-1:kolom+1);
            G(baris, kolom) = mean(blok(:));
        end
    end
    G = uint8(G);

    figure(i + 5); % Figure 6–10
    subplot(2,2,1); imshow(img); title(['Sebelum - ' nama_gambar{i}]);
    subplot(2,2,2); imshow(G); title('Sesudah (Perataan)');
    subplot(2,2,3); imhist(img); title('Histogram Sebelum');
    subplot(2,2,4); imhist(G); title('Histogram Sesudah');
end

%% FILTER MEDIAN (Figure 11–15)
for i = 1:5
    img = gambar_asli{i};
    if ndims(img) == 3
        img = rgb2gray(img);
    end
    G = img;
    [tinggi, lebar] = size(img);

    for baris = 2:tinggi-1
        for kolom = 2:lebar-1
            blok = [
                img(baris-1, kolom-1), img(baris-1, kolom), img(baris-1, kolom+1), ...
                img(baris, kolom-1),   img(baris, kolom),   img(baris, kolom+1), ...
                img(baris+1, kolom-1), img(baris+1, kolom), img(baris+1, kolom+1)
            ];
            G(baris, kolom) = median(blok);
        end
    end

    figure(i + 10); % Figure 11–15
    subplot(2,2,1); imshow(img); title(['Sebelum - ' nama_gambar{i}]);
    subplot(2,2,2); imshow(G); title('Sesudah (Median)');
    subplot(2,2,3); imhist(img); title('Histogram Sebelum');
    subplot(2,2,4); imhist(G); title('Histogram Sesudah');
end

