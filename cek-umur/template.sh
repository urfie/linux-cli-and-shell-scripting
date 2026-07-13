#!/bin/bash
# Latihan 2: Cek Umur
# TODO: lengkapi fungsi cek_umur dan validasi di bawah ini

cek_umur() {
    local umur="$1"
    # TODO: return 0 jika umur >= 17, return 1 jika < 17
    :
}

# ── Main ──────────────────────────────────────────────
# TODO: validasi $1 wajib diisi dan berupa bilangan bulat non-negatif
#       jika tidak valid -> "Error: umur harus berupa angka" ke stderr, exit 2

UMUR="$1"

# TODO: panggil cek_umur "$UMUR" di dalam struktur if/else
#       cetak "DEWASA" (exit 0) atau "BELUM DEWASA" (exit 1)
