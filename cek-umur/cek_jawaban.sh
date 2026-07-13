#!/bin/bash
# Test runner offline untuk Latihan 2

SOLUSI="./cek-umur.sh"
PASS=0
FAIL=0

jalankan_test() {
    local deskripsi="$1" expected_stdout="$2" expected_exit="$3"
    shift 3
    local actual_stdout actual_exit
    actual_stdout=$("$SOLUSI" "$@" 2>/dev/null)
    actual_exit=$?
    if [ "$actual_stdout" = "$expected_stdout" ] && [ "$actual_exit" -eq "$expected_exit" ]; then
        echo "✅ PASS - $deskripsi"; PASS=$((PASS + 1))
    else
        echo "❌ FAIL - $deskripsi"
        echo "   Exit exp: $expected_exit | actual: $actual_exit"
        echo "   Output exp: '$expected_stdout' | actual: '$actual_stdout'"
        FAIL=$((FAIL + 1))
    fi
}

if [ ! -x "$SOLUSI" ]; then
    echo "Skrip $SOLUSI belum bisa dieksekusi. Jalankan: chmod +x cek-umur.sh"
    exit 1
fi

echo "=== Menjalankan test Latihan 2: Cek Umur ==="
jalankan_test "Umur 20 -> DEWASA, exit 0"       "DEWASA"        0 20
jalankan_test "Umur 17 -> DEWASA (batas)"       "DEWASA"        0 17
jalankan_test "Umur 15 -> BELUM DEWASA, exit 1" "BELUM DEWASA"  1 15
jalankan_test "Umur 0 -> BELUM DEWASA"          "BELUM DEWASA"  1 0

echo ""
echo "--- Test validasi error ---"
"$SOLUSI" abc >/tmp/_stdout_a 2>/tmp/_stderr_a
exit_abc=$?
if [ "$exit_abc" -eq 2 ] && grep -qi "error" /tmp/_stderr_a; then
    echo "✅ PASS - Argumen bukan angka -> exit 2 + pesan error"; PASS=$((PASS + 1))
else
    echo "❌ FAIL - Argumen bukan angka seharusnya exit 2 + pesan mengandung 'Error' ke stderr (actual exit: $exit_abc)"
    FAIL=$((FAIL + 1))
fi

"$SOLUSI" >/tmp/_stdout_b 2>/tmp/_stderr_b
exit_kosong=$?
if [ "$exit_kosong" -eq 2 ] && grep -qi "error" /tmp/_stderr_b; then
    echo "✅ PASS - Argumen kosong -> exit 2 + pesan error"; PASS=$((PASS + 1))
else
    echo "❌ FAIL - Argumen kosong seharusnya exit 2 + pesan error (actual exit: $exit_kosong)"
    FAIL=$((FAIL + 1))
fi

rm -f /tmp/_stdout_a /tmp/_stderr_a /tmp/_stdout_b /tmp/_stderr_b

echo ""
echo "=== Hasil: $PASS PASS, $FAIL FAIL ==="
[ "$FAIL" -eq 0 ]
