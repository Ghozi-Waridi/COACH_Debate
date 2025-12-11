# COACH Debate

Aplikasi debat interaktif berbasis Flutter yang menggunakan Large Language Model (LLM) untuk melatih kemampuan berdebat pengguna. Aplikasi ini menyediakan platform untuk berdebat dengan AI, analisis argumen, dan pelacakan progres.

##  Screenshots

<!-- Tambahkan screenshot aplikasi Anda di sini -->
<!-- Buat folder 'screenshots' di root project dan simpan gambar-gambar di sana -->

<div align="center">
  <img src="screenshots/page10.jpeg" width="200" alt="Home Screen"/>
  <img src="screenshots/page6.jpeg" width="200" alt="Topics Screen"/>
  <img src="screenshots/page2.jpeg" width="200" alt="Debate Screen"/>
</div>

<div align="center">
<img src="screenshots/page.jpeg" width="200" alt="SingUp Screen"/>
  <img src="screenshots/page3.jpeg" width="200" alt="Login Screen"/>
  <img src="screenshots/page8.jpeg" width="200" alt="Profile Screen"/>
  <img src="screenshots/page7.jpeg" width="200" alt="Analysis Screen"/>
</div>
<div align="center">
  <img src="screenshots/page4.jpeg" width="200" alt="SingUp Screen"/>
  <img src="screenshots/page5.jpeg" width="200" alt="Login Screen"/>
  <img src="screenshots/page9.jpeg" width="200" alt="Profile Screen"/>
  <img src="screenshots/page11.jpeg" width="200" alt="Analysis Screen"/>
</div>



## 📋 Deskripsi

COACH Debate adalah aplikasi mobile yang dirancang untuk membantu pengguna meningkatkan kemampuan berdebat mereka melalui interaksi dengan AI. Aplikasi ini mengintegrasikan teknologi Speech-to-Text, Text-to-Speech, dan LLM untuk memberikan pengalaman debat yang realistis dan interaktif.

## ✨ Fitur Utama

- **🔐 Autentikasi Pengguna**: Sistem login dan registrasi dengan Supabase
- **💬 Debat Interaktif**: Berdebat secara real-time dengan AI berbasis LLM
- **🎤 Speech-to-Text**: Konversi suara ke teks untuk input argumen
- **🔊 Text-to-Speech**: Output suara dari respons AI
- **📊 Analisis Debat**: Evaluasi dan analisis argumen pengguna
- **📚 Topik Debat**: Berbagai topik debat yang dapat dipilih
- **👤 Profil Pengguna**: Manajemen profil dan tracking progress

## 🏗️ Arsitektur

Aplikasi ini dibangun menggunakan **Clean Architecture** dengan struktur sebagai berikut:

```
lib/
├── core/                    # Core utilities dan konfigurasi
│   ├── config/             # Konfigurasi aplikasi
│   ├── error/              # Error handling
│   ├── router/             # Routing dengan GoRouter
│   └── theme/              # Theme dan styling
├── features/               # Fitur-fitur utama
│   ├── Analis/            # Analisis debat
│   ├── Auth/              # Autentikasi
│   ├── Debate/            # Sesi debat
│   ├── Home/              # Halaman utama
│   ├── Profile/           # Profil pengguna
│   ├── Stt/               # Speech-to-Text
│   └── Topics/            # Topik debat
├── shared/                 # Komponen bersama
│   ├── data/
│   ├── domain/
│   ├── presentation/
│   └── utils/
├── injection.dart          # Dependency Injection
└── main.dart              # Entry point
```

Setiap fitur mengikuti struktur Clean Architecture:

- **Data Layer**: Datasources, Models, Repositories Implementation
- **Domain Layer**: Entities, Repositories Interface, Usecases
- **Presentation Layer**: Pages, Widgets, BLoC/State Management

## 🛠️ Teknologi yang Digunakan

### Framework & Language

- **Flutter**: Framework utama (SDK ^3.9.0)
- **Dart**: Bahasa pemrograman

### State Management

- **flutter_bloc** (^9.1.1): State management dengan BLoC pattern
- **equatable** (^2.0.7): Equality comparison untuk state

### Backend & Database

- **supabase_flutter** (^2.10.0): Backend-as-a-Service
- **dio** (^5.9.0): HTTP client untuk API calls
- **http** (^1.5.0): HTTP package alternatif

### Speech & Audio

- **speech_to_text** (^7.3.0): Konversi suara ke teks
- **flutter_tts** (^4.2.3): Text-to-Speech

### Navigation & UI

- **go_router** (^16.1.0): Deklaratif routing
- **liquid_glass_renderer** (^0.1.1-dev.10): Efek visual

### Utilities

- **get_it** (^8.2.0): Dependency Injection
- **dartz** (^0.10.1): Functional programming (Either, Option)
- **flutter_dotenv** (^6.0.0): Environment variables
- **logger** (^2.6.1): Logging

## 📦 Instalasi & Menjalankan Project

### Prasyarat

Pastikan Anda sudah menginstall tools berikut:

- **Flutter SDK** version ^3.9.0 atau lebih tinggi - [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Dart SDK** ^3.9.0 (sudah include dalam Flutter)
- **Android Studio** atau **VS Code** dengan ekstensi Flutter
- **Git** untuk clone repository
- **Akun Supabase** (gratis) - [Daftar di sini](https://supabase.com)

### Langkah-langkah Clone & Setup

#### 1. **Verifikasi Instalasi Flutter**

Pastikan Flutter sudah terinstall dengan benar:

```bash
flutter doctor
```

Pastikan semua komponen yang diperlukan sudah terinstall (tandai ✓).

#### 2. **Clone Repository**

Clone project dari GitHub:

```bash
git clone https://github.com/Ghozi-Waridi/COACH_Debate.git
cd choach_debate
```

Atau jika menggunakan SSH:

```bash
git clone git@github.com:Ghozi-Waridi/COACH_Debate.git
cd choach_debate
```

#### 3. **Install Dependencies**

Install semua package yang diperlukan:

```bash
flutter pub get
```

Tunggu hingga proses selesai. Jika ada error, jalankan:

```bash
flutter clean
flutter pub get
```

#### 4. **Setup Backend (Supabase)**

**Penting**: Project ini memerlukan backend untuk berfungsi dengan baik.

📌 **Link Backend**: [COACH Debate Backend Repository](https://github.com/Ghozi-Waridi/django-backend-DebateAPP)

Ikuti langkah-langkah berikut:

a. **Buat Project Supabase**

- Buka [Supabase Dashboard](https://app.supabase.com)
- Klik "New Project"
- Isi nama project, database password, dan region
- Tunggu hingga project selesai dibuat

b. **Dapatkan Credentials**

- Di Supabase Dashboard, pergi ke **Settings** → **API**
- Copy **Project URL** (sebagai `SUPABASE_URL`)
- Copy **anon public** key (sebagai `SUPABASE_KEY`)

c. **Setup Database & Functions**

- Clone dan setup backend sesuai instruksi di [Backend Repository](https://github.com/Ghozi-Waridi/COACH_Debate_Backend) [ NOTE : Msih Terjadi Error 😭😭]
- Deploy Edge Functions untuk AI debat
- Setup database tables dan security policies

#### 5. **Konfigurasi Environment Variables**

Buat file `.env` di **root project** (sejajar dengan pubspec.yaml):

```bash
touch .env
```

Isi file `.env` dengan credentials Supabase Anda:

```env
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_KEY=your-anon-key-here
```

⚠️ **Penting**:

- Jangan commit file `.env` ke Git (sudah ada di `.gitignore`)
- Pastikan format URL benar dan tidak ada spasi
- Gunakan `anon key` bukan `service_role key`

#### 6. **Setup Device/Emulator**

**Untuk Android:**

```bash
# Cek device yang tersedia
flutter devices

```


**Untuk Physical Device:**

- Enable USB Debugging di Android
- Hubungkan device via USB
- Verifikasi dengan `flutter devices`

#### 7. **Jalankan Aplikasi**

Jalankan aplikasi di device/emulator:

```bash
# Mode debug
flutter run

# Atau pilih device spesifik
flutter run -d <device_id>

# Mode release (lebih cepat)
flutter run
```

#### 8. **Verifikasi**

Setelah aplikasi berjalan:

- ✅ Buka aplikasi dan coba fitur Register
- ✅ Test login dengan akun yang baru dibuat
- ✅ Coba fitur Speech-to-Text (izinkan permission microphone)
- ✅ Pilih topik dan mulai debat
- ✅ Pastikan AI merespons dengan baik

### ⚠️ Limit & Quota

**Request Limit**: 1000 token per request

- Setiap pesan debat dibatasi maksimal **1000 token**
- Untuk pesan yang lebih panjang, akan dipotong otomatis
- Token dihitung berdasarkan jumlah kata dan karakter
- Saran: Buat argumen yang concise dan focused (200-500 kata)

**Supabase Free Tier Limits**:

- 500MB database storage
- 1GB file storage
- 50,000 monthly active users
- 2GB bandwidth

Untuk production, pertimbangkan upgrade plan jika usage melebihi limit.

### 🐛 Troubleshooting

**Problem**: Error "SUPABASE_URL not found"

- **Solution**: Pastikan file `.env` ada dan formatnya benar

**Problem**: Build failed Android

- **Solution**:
  ```bash
  cd android
  ./gradlew clean
  cd ..
  flutter clean
  flutter pub get
  flutter run
  ```

**Problem**: Speech-to-Text tidak bekerja

- **Solution**: Pastikan permission microphone sudah diizinkan di device settings

**Problem**: AI tidak merespons

- **Solution**:
  - Cek koneksi internet
  - Pastikan backend sudah di-deploy
  - Verify Supabase credentials di `.env`

### 📚 Resource Tambahan

- [Flutter Documentation](https://docs.flutter.dev/)
- [Supabase Documentation](https://supabase.com/docs)
- [Backend Repository](https://github.com/Ghozi-Waridi/django-backend-DebateAPP)



## 📱 Fitur Detail

### 1. Autentikasi (Auth)

- Sign Up dengan email dan password
- Sign In untuk pengguna terdaftar
- Sign Out
- Get current user session
- Integrasi dengan Supabase Authentication

### 2. Debate (Debat)

- Membuat sesi debat baru
- Mengirim pesan/argumen
- Menerima respons dari AI
- Real-time conversation
- History percakapan

### 3. Speech-to-Text (STT)

- Inisialisasi speech recognition
- Mulai mendengarkan input suara
- Berhenti mendengarkan
- Stream hasil recognition
- Konversi real-time

### 4. Topics (Topik)

- Daftar topik debat yang tersedia
- Pilih topik untuk memulai debat
- Kategori topik yang beragam

### 5. Profile (Profil)

- Melihat profil pengguna
- Update informasi profil
- Tracking statistik debat

### 6. Analysis (Analisis)

- Analisis kualitas argumen
- Feedback dan saran perbaikan
- Visualisasi performa

## 🔧 Konfigurasi

### Supabase Setup

1. Buat project di [Supabase](https://supabase.com)
2. Dapatkan URL dan Anon Key dari project settings
3. Masukkan ke file `.env`

### Android Permissions

Permissions yang diperlukan (sudah dikonfigurasi di `AndroidManifest.xml`):

- Internet access
- Microphone access (untuk Speech-to-Text)
- Audio recording


## 📝 Dependency Injection

Aplikasi menggunakan **GetIt** untuk dependency injection. Semua dependencies didaftarkan di `lib/injection.dart`:

- **Repositories**: Interface dan implementasi
- **Datasources**: Remote dan local data sources
- **Usecases**: Business logic
- **BLoCs**: State management
- **External services**: Dio, Supabase client

## 🎨 Styling

- Material Design components
- Custom theme configuration
- Adaptive UI untuk berbagai ukuran layar
- Glass morphism effects dengan liquid_glass_renderer

## 📄 Lisensi

Project ini bersifat private dan tidak dipublikasikan ke pub.dev.

## 👥 Kontribusi

Untuk berkontribusi pada project ini:

1. Fork repository
2. Buat branch fitur (`git checkout -b feature/AmazingFeature`)
3. Commit perubahan (`git commit -m 'Add some AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Buat Pull Request

## 📞 Kontak

GitHub: [@Ghozi-Waridi](https://github.com/Ghozi-Waridi)

Repository: [COACH_Debate](https://github.com/Ghozi-Waridi/COACH_Debate)

## 🙏 Acknowledgments

- Flutter Team untuk framework yang luar biasa
- Supabase untuk backend infrastructure
- Komunitas Flutter Indonesia

---

**Built with ❤️ using Flutter**
