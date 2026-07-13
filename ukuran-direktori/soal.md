# Latihan 5: Studi Kasus Gabungan — Laporan Ukuran Direktori

Ini menggabungkan semua konsep dari Latihan 1–4: fungsi, `local`, argumen dinamis (`"$@"`),
nilai default, validasi, dan exit code berbasis jumlah masalah.

## Tugas
Copy `template.sh` ke file `ukuran-direktori.sh`:

1. Jika dijalankan **tanpa argumen**, gunakan direktori saat ini (`.`) sebagai satu-satunya target (nilai default), JANGAN error.
2. Jika dijalankan **dengan argumen**, proses semua argumen sebagai daftar direktori lewat `"$@"`.
3. Buat fungsi `ukuran_direktori` yang menerima satu path direktori dan **mencetak** ukurannya dalam KB (bilangan bulat) menggunakan `du -sk` (ambil kolom pertama saja). Gunakan `local` di dalamnya.
4. Untuk tiap direktori:
   - Jika tidak ditemukan → cetak `SKIP:<path>` dan naikkan counter skip.
   - Jika ditemukan → panggil `ukuran_direktori`, cetak `OK:<path>:<ukuran_kb>KB` dan naikkan counter berhasil.
5. Di baris terakhir, cetak ringkasan PERSIS: `RINGKASAN: berhasil=<n> skip=<m>`.
6. Exit code akhir script = jumlah direktori yang **di-skip** (`m`). Jika semua berhasil, exit 0.

### Contoh
```
$ ./ukuran-direktori.sh dirA dirB dir_ngawur
OK:dirA:124KB
OK:dirB:8KB
SKIP:dir_ngawur
RINGKASAN: berhasil=2 skip=1
$ echo $?
1
```

## Cara Cek Otomatis
```bash
chmod +x ukuran-direktori.sh cek_jawaban.sh
./cek_jawaban.sh
```
*(Karena ukuran KB aktual tergantung filesystem, checker ini memvalidasi FORMAT baris `OK:`/`SKIP:`/`RINGKASAN:` dan exit code — bukan angka KB persis. Baca pesan FAIL untuk detail jika ada yang meleset.)*

## Tantangan Tambahan (tidak divalidasi otomatis)
- Tambahkan opsi `--human` yang membuat script memakai `du -sh` (format human-readable seperti `1.2M`) alih-alih KB.
- Tambahkan `set -uo pipefail` di awal script dan pastikan skrip Anda tetap berjalan benar (tidak ada variabel unset yang dipakai).
