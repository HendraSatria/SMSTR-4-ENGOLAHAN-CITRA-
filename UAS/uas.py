import cv2
import os
import numpy as np
from matplotlib import pyplot as plt
from tkinter import Tk, filedialog, Button, Label, Frame, BOTH, LEFT, RIGHT, TOP, BOTTOM, X, Y
from tkinter import font as tkFont

# Fungsi untuk ekstraksi fitur histogram grayscale
def extract_features(image_path):
    image = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)
    image = cv2.resize(image, (100, 100))  # Resize seragam
    hist = cv2.calcHist([image], [0], None, [256], [0, 256])
    hist = cv2.normalize(hist, hist).flatten()
    return hist

# Load database dari subfolder (setiap subfolder = 1 label)
def load_database_features(database_path):
    features = []
    labels = []
    image_paths = []

    for root, dirs, files in os.walk(database_path):
        for filename in files:
            if filename.lower().endswith(('.jpg', '.jpeg', '.png')):
                path = os.path.join(root, filename)
                label = os.path.basename(root).lower()  # nama folder sebagai label
                feat = extract_features(path)
                features.append(feat)
                labels.append(label)
                image_paths.append(path)

    return features, labels, image_paths

# Fungsi pencocokan CBIR
def retrieve_most_similar(query_feat, db_feats):
    similarities = [cv2.compareHist(query_feat, feat, cv2.HISTCMP_CORREL) for feat in db_feats]
    best_index = np.argmax(similarities)
    return best_index, similarities[best_index]

# Fungsi untuk memilih gambar dan menjalankan pencocokan
def run_cbir():
    input_image_path = filedialog.askopenfilename(
        title="Pilih gambar input",
        filetypes=[("Image Files", "*.jpg *.jpeg *.png")]
    )
    if not input_image_path:
        return

    query_feat = extract_features(input_image_path)
    db_feats, db_labels, db_paths = load_database_features(database_path)
    
    best_idx, similarity = retrieve_most_similar(query_feat, db_feats)
    predicted_label = db_labels[best_idx]
    best_match_path = db_paths[best_idx]

    result_label.config(
        text=f"Ekspresi wajah terdeteksi: {predicted_label.upper()} (Similarity: {similarity:.2f})",
        fg="#1e88e5"
    )

    # Tampilkan gambar input dan hasil pencocokan
    input_img = cv2.imread(input_image_path)
    match_img = cv2.imread(best_match_path)

    plt.figure(figsize=(8,4))
    plt.subplot(1, 2, 1)
    plt.imshow(cv2.cvtColor(input_img, cv2.COLOR_BGR2RGB))
    plt.title('Input Image')

    plt.subplot(1, 2, 2)
    plt.imshow(cv2.cvtColor(match_img, cv2.COLOR_BGR2RGB))
    plt.title(f'Matched: {predicted_label.upper()}')

    plt.tight_layout()
    plt.show()

# Fungsi untuk tombol Back
def back_to_home():
    result_label.config(text="")

# Path database (ubah sesuai kebutuhan)
database_path = 'C:\\KULIAH ILMU KOMPUTER\\SEMESTER IV\\PENGOLAHAN CITRA\\uts\\ck\\CK+48'

# GUI dengan tkinter
root = Tk()
root.title("CBIR Ekspresi Wajah")
root.geometry("520x320")
root.configure(bg="#232946")  # Dark blue background

# Font
title_font = tkFont.Font(family="Segoe UI", size=20, weight="bold")
label_font = tkFont.Font(family="Segoe UI", size=12)
button_font = tkFont.Font(family="Segoe UI", size=11, weight="bold")

# Frame utama dengan border dan rounded effect
main_frame = Frame(root, bg="#fffffe", bd=0, relief="flat", highlightbackground="#eebbc3", highlightthickness=3)
main_frame.pack(expand=True, fill=BOTH, padx=30, pady=30)

# Judul dengan shadow effect
title_label = Label(
    main_frame, text="CBIR Ekspresi Wajah", font=title_font,
    bg="#fffffe", fg="#232946"
)
title_label.pack(pady=(10, 5))

# Garis bawah judul
underline = Frame(main_frame, bg="#eebbc3", height=3, width=260)
underline.pack(pady=(0, 10))

# Instruksi
Label(
    main_frame, text="Pilih gambar untuk dicocokkan dengan database:",
    font=label_font, bg="#fffffe", fg="#393e46"
).pack(pady=5)

# Tombol pilih gambar dengan efek hover
def on_enter(e):
    pilih_btn['background'] = "#eebbc3"
    pilih_btn['foreground'] = "#232946"
def on_leave(e):
    pilih_btn['background'] = "#232946"
    pilih_btn['foreground'] = "#fffffe"

pilih_btn = Button(
    main_frame, text="Pilih Gambar", command=run_cbir,
    font=button_font, bg="#232946", fg="#fffffe", activebackground="#eebbc3",
    activeforeground="#232946", relief="flat", bd=0, padx=16, pady=8, cursor="hand2"
)
pilih_btn.pack(pady=16)
pilih_btn.bind("<Enter>", on_enter)
pilih_btn.bind("<Leave>", on_leave)

# Label hasil
result_label = Label(
    main_frame, text="", font=label_font, bg="#fffffe", fg="#eebbc3", wraplength=400, justify="center"
)
result_label.pack(pady=10)

# Footer
footer = Label(
    root, text="© 2024 CBIR Ekspresi Wajah | by @LekHen", font=("Segoe UI", 9),
    bg="#232946", fg="#f6f7f9"
)
footer.pack(side=BOTTOM, pady=5)

root.mainloop()
