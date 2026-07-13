#!/bin/bash
# Latihan 5: Studi Kasus Gabungan - Laporan Ukuran Direktori
# TODO: lengkapi logika di bawah ini

ukuran_direktori() {
    local dir="$1"
    # TODO: hitung ukuran direktori dalam KB pakai `du -sk`, cetak hanya angkanya
    :
}

# TODO: jika tidak ada argumen -> gunakan "." sebagai satu-satunya direktori target
# TODO: loop semua direktori target (pakai "$@" atau array), untuk tiap direktori:
#         - jika tidak ditemukan -> echo "SKIP:<path>", naikkan counter skip
#         - jika ditemukan -> panggil ukuran_direktori, echo "OK:<path>:<ukuran>KB", naikkan counter berhasil
# TODO: di akhir, echo "RINGKASAN: berhasil=<n> skip=<m>"
# TODO: exit dengan kode = jumlah skip
