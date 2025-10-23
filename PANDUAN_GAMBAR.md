# 📸 PANDUAN PENEMPATAN GAMBAR UNTUK README

## 📍 Lokasi Folder Screenshot

Folder screenshot sudah dibuat di:

```
/choach_debate/screenshots/
```

## 📋 Gambar yang Harus Ditambahkan

Tambahkan **7 file gambar** berikut ke dalam folder `screenshots/`:

### Baris 1 (4 gambar):

1. `splash_screen.png` - Screenshot splash screen aplikasi saat pertama buka
2. `login_screen.png` - Screenshot halaman login atau register
3. `home_screen.png` - Screenshot dashboard/halaman utama setelah login
4. `debate_screen.png` - Screenshot saat sedang berdebat dengan AI

### Baris 2 (3 gambar):

5. `topics_screen.png` - Screenshot halaman daftar topik debat
6. `profile_screen.png` - Screenshot halaman profil pengguna
7. `analysis_screen.png` - Screenshot halaman analisis hasil debat

## 🎯 Cara Menambahkan Gambar

### Step-by-Step:

1. **Ambil Screenshot dari Aplikasi**

   - Jalankan aplikasi: `flutter run`
   - Navigasi ke setiap halaman
   - Ambil screenshot (lihat cara di bawah)

2. **Simpan File Gambar**

   - Buka folder project: `/choach_debate/screenshots/`
   - Copy semua screenshot ke folder ini
   - Rename file sesuai nama yang sudah ditentukan

3. **Verifikasi**
   - Pastikan nama file **PERSIS SAMA** dengan di atas
   - Format: PNG atau JPG
   - Ukuran: < 2MB per file

## 📱 Cara Mengambil Screenshot

### Dari Android Emulator:

- Klik icon **kamera** di toolbar emulator (sebelah kanan)
- Atau tekan `Ctrl + S` (Windows) / `Cmd + S` (Mac)

### Dari iOS Simulator:

- Tekan `Cmd + S` pada keyboard
- File akan tersimpan di Desktop

### Dari Physical Device:

- Android: `Power + Volume Down`
- iPhone: `Side Button + Volume Up`

## ✅ Struktur Akhir

Setelah semua gambar ditambahkan, struktur folder akan seperti ini:

```
screenshots/
├── .gitkeep                    (bisa dihapus setelah ada gambar)
├── README_SCREENSHOTS.md       (panduan detail)
├── splash_screen.png          ← TAMBAHKAN INI
├── login_screen.png           ← TAMBAHKAN INI
├── home_screen.png            ← TAMBAHKAN INI
├── debate_screen.png          ← TAMBAHKAN INI
├── topics_screen.png          ← TAMBAHKAN INI
├── profile_screen.png         ← TAMBAHKAN INI
└── analysis_screen.png        ← TAMBAHKAN INI
```

## 🖼️ Di Mana Gambar Akan Muncul di README?

Gambar akan otomatis muncul di **bagian paling atas** README.md, tepat setelah judul dan sebelum "Deskripsi".

Preview di README.md akan seperti ini:

```
# COACH Debate

[Deskripsi singkat]

## 📸 Screenshots

[4 gambar baris pertama]
[3 gambar baris kedua]

## 📋 Deskripsi
...
```

## 💡 Tips Penting

1. **Nama File**: Harus **exact match** dengan yang ada di README:

   - ✅ `splash_screen.png`
   - ❌ `Splash_Screen.PNG`
   - ❌ `splash-screen.png`

2. **Ukuran**: Compress jika file > 2MB menggunakan:

   - [TinyPNG](https://tinypng.com)
   - [Squoosh](https://squoosh.app)

3. **Kualitas**: Ambil dari device dengan resolusi tinggi untuk hasil terbaik

4. **Konten**: Pastikan tidak ada data sensitif atau real user data

## 🔗 Informasi Tambahan yang Sudah Ditambahkan

✅ **Screenshot section** - Di bagian paling atas README
✅ **Langkah clone & setup detail** - Step-by-step untuk developer lain
✅ **Limit Request** - 1000 token per request
✅ **Link Backend** - https://github.com/Ghozi-Waridi/COACH_Debate_Backend
✅ **Troubleshooting** - Common problems & solutions
✅ **Environment setup** - File .env dan credentials

## 📝 Yang Perlu Dilakukan Selanjutnya

- [ ] Jalankan aplikasi dan ambil 7 screenshot
- [ ] Simpan semua gambar ke folder `screenshots/`
- [ ] Rename file sesuai nama yang ditentukan
- [ ] Compress jika ukuran > 2MB
- [ ] Push ke GitHub
- [ ] Cek apakah gambar muncul di README

---

**Setelah gambar ditambahkan, README.md akan terlihat jauh lebih menarik dan profesional!** 🎉
