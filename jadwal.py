import random
import string

# Parameter huruf hanya a-p, angka 1-20
valid_letters = list(string.ascii_lowercase[:16])  # a to p
valid_numbers = list(range(1, 21))

# Data soal awal
original_rows = [
    "f9 b10 l15 g4 k1 c8",
    "f9 b10 l15 g4 k1 c8",
    "k8 e6 l15 i2 c8 b10",
    "k8 e3 k1 b10 c8 i2",
    "e3 k1 f9 b10 c8 o17",
    "e6 k1 f9 b20 g5 o17",
    "j13 g4 b10 i8 o17 f9",
    "l11 g4 b10 i8 o17 f9"
]

def generate_random_code(exclude_letters):
    while True:
        letter = random.choice(valid_letters)
        if letter not in exclude_letters:
            number = random.choice(valid_numbers)
            return f"{letter}{number}"

# Tambahkan dua kode acak di index ke-2 dan ke-5, patuhi aturan
final_rows = []
for row in original_rows:
    parts = row.lower().split()
    letters = [p[0] for p in parts]
    
    # Generate 2 kode baru
    new1 = generate_random_code(letters)
    letters.append(new1[0])
    new2 = generate_random_code(letters)
    
    # Sisipkan di posisi index 2 dan 5
    parts.insert(2, new1)
    parts.insert(5, new2)
    
    final_rows.append(" ".join(parts))

print(final_rows)
