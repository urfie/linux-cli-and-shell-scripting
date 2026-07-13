# Latihan 2: Cek Umur (Fungsi dengan Return Status)

## Tugas
Kopi `cek-umur.sh` ke file `cek-umur.sh` dan ubah sebagai berikut:

1. Buat fungsi `cek_umur` yang menerima **satu argumen** (umur, berupa bilangan bulat). Fungsi ini **tidak mencetak apa pun** — ia hanya `return`:
   - `return 0` jika umur `>= 17` (dewasa)
   - `return 1` jika umur `< 17` (belum dewasa)
2. Validasi dulu di main script: jika `$1` kosong atau bukan bilangan bulat non-negatif, cetak `Error: umur harus berupa angka` ke stderr dan `exit 2`.
3. Jika valid, panggil `cek_umur "$1"`, lalu gunakan `if` (BUKAN `&&`/`||` bertingkat, agar tidak kena jebakan seperti dijelaskan di modul) untuk mencetak PERSIS salah satu dari:
   - `DEWASA` (lalu script exit 0)
   - `BELUM DEWASA` (lalu script exit 1)

### Contoh
```
$ ./cek-umur.sh 20
DEWASA
$ echo $?
0

$ ./cek-umur.sh 15
BELUM DEWASA
$ echo $?
1

$ ./cek-umur.sh 17
DEWASA

$ ./cek-umur.sh abc
Error: umur harus berupa angka
$ echo $?
2
```

## Cara Cek Otomatis
```bash
chmod +x cek-umur.sh cek_jawaban.sh
./cek_jawaban.sh
```

## Tantangan Tambahan
- Tambahkan kategori ketiga: `LANSIA` jika umur ≥ 60 (tetap dianggap "dewasa" untuk exit code, tapi teks output berbeda).
- Pikirkan: kenapa memakai `if` di sini lebih aman dibanding `cek_umur "$1" && echo DEWASA || echo "BELUM DEWASA"`? (Lihat kembali jebakan `&&`/`||` di modul.)

