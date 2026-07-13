#!/bin/bash
# Test runner offline untuk Latihan 5
# Catatan: ukuran KB aktual bervariasi antar filesystem, jadi kita hanya
# memvalidasi FORMAT baris dan jumlah berhasil/skip, bukan angka KB persis.

SOLUSI="$(cd "$(dirname "$0")" && pwd)/ukuran-direktori.sh"
PASS=0
FAIL=0
TMPBASE=$(mktemp -d)
trap 'rm -rf "$TMPBASE"' EXIT

if [ ! -x "$SOLUSI" ]; then
    echo "Skrip $SOLUSI belum bisa dieksekusi. Jalankan: chmod +x ukuran-direktori.sh"
    exit 1
fi

DIR_A="$TMPBASE/dirA"; DIR_B="$TMPBASE/dirB"; DIR_NGAWUR="$TMPBASE/dir_ngawur"
mkdir -p "$DIR_A" "$DIR_B"
head -c 20000 /dev/urandom > "$DIR_A/file1.bin" 2>/dev/null || dd if=/dev/zero of="$DIR_A/file1.bin" bs=1024 count=20 2>/dev/null
head -c 2000 /dev/urandom > "$DIR_B/file2.bin" 2>/dev/null || dd if=/dev/zero of="$DIR_B/file2.bin" bs=1024 count=2 2>/dev/null

echo "=== Menjalankan test Latihan 5: Laporan Disk ==="

out=$("$SOLUSI" "$DIR_A" "$DIR_B" "$DIR_NGAWUR" 2>/dev/null)
exit_code=$?

ok_a=$(echo "$out" | grep -c "^OK:$DIR_A:[0-9][0-9]*KB$")
ok_b=$(echo "$out" | grep -c "^OK:$DIR_B:[0-9][0-9]*KB$")
skip_line=$(echo "$out" | grep -c "^SKIP:$DIR_NGAWUR$")
ringkasan_line=$(echo "$out" | grep -c "^RINGKASAN: berhasil=2 skip=1$")

if [ "$ok_a" -eq 1 ] && [ "$ok_b" -eq 1 ] && [ "$skip_line" -eq 1 ] && [ "$ringkasan_line" -eq 1 ] && [ "$exit_code" -eq 1 ]; then
    echo "✅ PASS - Format OK/SKIP/RINGKASAN benar, exit code = jumlah skip (1)"
    PASS=$((PASS + 1))
else
    echo "❌ FAIL - Cek kombinasi 2 dir valid + 1 dir tidak ada"
    echo "--- Output aktual ---"
    echo "$out"
    echo "Exit code aktual: $exit_code (harus 1)"
    FAIL=$((FAIL + 1))
fi

# Test default ke direktori saat ini tanpa argumen
cd "$TMPBASE"
out_default=$("$SOLUSI" 2>/dev/null)
exit_default=$?
if echo "$out_default" | grep -qE "^OK:\.:[0-9]+KB$" && [ "$exit_default" -eq 0 ]; then
    echo "✅ PASS - Tanpa argumen -> default ke '.' dan exit 0"
    PASS=$((PASS + 1))
else
    echo "❌ FAIL - Tanpa argumen seharusnya memproses '.' dengan format 'OK:.:<n>KB' dan exit 0"
    echo "--- Output aktual ---"; echo "$out_default"
    echo "Exit code aktual: $exit_default"
    FAIL=$((FAIL + 1))
fi
cd - >/dev/null

echo ""
echo "=== Hasil: $PASS PASS, $FAIL FAIL ==="
[ "$FAIL" -eq 0 ]
