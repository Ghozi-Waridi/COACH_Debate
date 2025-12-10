# 🏗️ Arsitektur Project COACH Debate

## 📖 Penjelasan Arsitektur

Project **COACH Debate** dibangun menggunakan arsitektur **Clean Architecture** yang dikombinasikan dengan **BLoC Pattern** untuk state management, memastikan kode yang terstruktur, mudah diuji, dan scalable untuk pengembangan jangka panjang.

---

## 🗂️ Struktur Direktori Utama

### **lib/**

Folder utama yang menampung seluruh kode sumber aplikasi Flutter, terdiri dari beberapa module utama yang terorganisir berdasarkan fungsi dan tanggung jawabnya.

### **core/**

Berisi konfigurasi global dan utilitas inti yang digunakan di seluruh aplikasi, termasuk pengaturan tema, routing, penanganan error, dan konfigurasi API yang menjadi fondasi dari seluruh sistem.

### **features/**

Menampung semua fitur aplikasi yang diorganisir secara modular, di mana setiap fitur memiliki struktur lengkap Clean Architecture (data, domain, presentation) sehingga memudahkan pengembangan dan maintenance secara independen.

### **shared/**

Menyediakan komponen-komponen yang digunakan bersama oleh berbagai fitur, seperti widget umum, utilitas helper, dan logika yang dapat dipakai ulang di seluruh aplikasi untuk menghindari duplikasi kode.

### **injection.dart**

Mengelola dependency injection menggunakan GetIt sebagai service locator, bertanggung jawab untuk registrasi dan penyediaan semua dependencies seperti BLoC, UseCases, Repositories, dan DataSources agar mudah diakses di seluruh aplikasi.

### **main.dart**

Menjadi titik awal (entry point) aplikasi yang memuat konfigurasi awal seperti inisialisasi Supabase, environment variables, dependency injection, serta pengaturan routing dan penyediaan BLoC providers untuk state management global.

---

## 🏛️ Clean Architecture - 3 Layer

Project ini mengikuti prinsip **Clean Architecture** dengan pemisahan tanggung jawab menjadi 3 layer utama:

### **Presentation Layer** (Layer Luar)

Menangani seluruh antarmuka pengguna (UI) dan interaksi user, menggunakan BLoC untuk mengelola state aplikasi, serta menampilkan data kepada pengguna melalui halaman (pages) dan komponen widget yang reaktif terhadap perubahan state.

### **Domain Layer** (Layer Inti/Business Logic)

Merepresentasikan logika bisnis murni dari aplikasi yang tidak bergantung pada framework atau library eksternal, berisi entitas (entities) sebagai objek bisnis, use cases yang menjalankan aksi spesifik, dan interface repository yang mendefinisikan kontrak untuk pengambilan data.

### **Data Layer** (Layer Infrastruktur)

Menangani semua operasi terkait data baik dari sumber eksternal (API, Supabase) maupun lokal, mengimplementasikan repository interface dari domain layer, serta bertanggung jawab untuk transformasi data antara model (format JSON) dan entity (objek bisnis).

### Layer Responsibilities

#### 1. **Presentation Layer** (Outer Layer)

- Menampilkan UI kepada user
- Menangani user interaction
- Menggunakan BLoC untuk state management
- **Dependencies**: Domain Layer

#### 2. **Domain Layer** (Core/Business Logic)

- Berisi business logic aplikasi
- Tidak bergantung pada framework atau library eksternal
- Pure Dart code
- **Dependencies**: None (independent)

#### 3. **Data Layer** (Infrastructure)

- Implementasi konkret dari repository
- Komunikasi dengan external data sources (API, Database)
- Data transformation (Model ↔ Entity)
- **Dependencies**: Domain Layer

---

## Struktur Folder Root

```
lib/
├── core/               # Konfigurasi & utilities inti
├── features/           # Fitur-fitur aplikasi (modular)
├── shared/             # Komponen yang digunakan bersama
├── injection.dart      # Dependency Injection setup
└── main.dart          # Entry point aplikasi
```

---

## 📦 Core Module - Konfigurasi Inti Aplikasi

Core module menyediakan fondasi dan konfigurasi global yang digunakan di seluruh aplikasi.

### **core/config/**

Menampung konfigurasi aplikasi seperti pengaturan API endpoint, base URL untuk komunikasi dengan backend, API key untuk berbagai layanan eksternal, serta pengaturan timeout untuk request HTTP yang memastikan aplikasi dapat berkomunikasi dengan server dengan baik.

### **core/error/**

Mengelola sistem penanganan error secara terpusat menggunakan abstract class Failure yang diextend menjadi berbagai tipe error spesifik seperti ServerFailure untuk error dari API, CacheFailure untuk error penyimpanan lokal, dan NetworkFailure untuk masalah koneksi internet, sehingga error dapat ditangani secara konsisten di seluruh aplikasi.

### **core/router/**

Bertanggung jawab untuk navigasi dan routing aplikasi menggunakan package GoRouter, mendefinisikan semua route yang tersedia, mengelola deep linking, serta menyediakan enum untuk route names yang memastikan type-safe navigation dan mencegah error akibat typo pada nama route.

### **core/theme/**

Menyimpan konfigurasi visual aplikasi seperti color palette, typography, dan tema yang digunakan secara konsisten di seluruh aplikasi untuk memastikan user interface memiliki tampilan yang seragam dan sesuai dengan brand identity.

---

## 🎯 Features Module - Fitur-Fitur Aplikasi

- Definisi semua routes
- Route configuration
- Navigation logic
- Deep linking setup

**`app_router_enum.dart`**

- Enum untuk route names
- Memastikan type-safe routing
- Mencegah typo pada route names

```dart
enum AppRoute {
  home,
  debate,
  profile,
  // ... other routes
}
```

#### **theme/**

Menyimpan styling dan tema aplikasi.

**`color.dart`**

- Color palette aplikasi
- Brand colors
- Semantic colors (success, error, warning)

```dart
class AppColors {
  static const Color primary = Color(0xFF6C63FF);
  static const Color secondary = Color(0xFF3F3D56);
  // ... other colors
}
```

Features module mengorganisir aplikasi menjadi fitur-fitur modular yang independen, di mana setiap fitur memiliki struktur Clean Architecture lengkap dengan 3 layer (data, domain, presentation) untuk memudahkan pengembangan, testing, dan maintenance.

### **Struktur Per Feature**

Setiap feature dalam folder features/ mengikuti pola yang konsisten dengan pemisahan menjadi tiga layer utama.

#### **data/**

Menangani semua operasi terkait pengambilan dan penyimpanan data, terdiri dari datasources yang berkomunikasi dengan sumber data eksternal (API, database), models yang merepresentasikan struktur data dengan JSON serialization, dan repositories yang mengimplementasikan interface dari domain layer untuk menyediakan data kepada use cases.

#### **domain/**

Merepresentasikan logika bisnis murni yang tidak bergantung pada framework atau library eksternal, berisi entities sebagai objek bisnis yang immutable, repository interfaces yang mendefinisikan kontrak untuk pengambilan data tanpa implementasi konkret, dan usecases yang menjalankan aksi bisnis spesifik dengan single responsibility.

#### **presentation/**

Bertanggung jawab untuk menampilkan user interface dan menangani interaksi pengguna, terdiri dari bloc untuk state management yang mengelola events dan states, pages yang merupakan halaman-halaman utama aplikasi, serta widgets yang merupakan komponen UI reusable untuk membangun interface yang kompleks.

---

## 🎨 Fitur-Fitur Aplikasi

### **1. Auth (Autentikasi)**

Mengelola seluruh proses autentikasi pengguna mulai dari registrasi akun baru, login dengan email dan password, logout dari sistem, hingga mengambil informasi user yang sedang login, dengan integrasi penuh menggunakan Supabase Auth untuk keamanan dan kemudahan manajemen user.

**Data Layer**: Menggunakan Supabase sebagai remote data source untuk operasi autentikasi, dengan auth_model yang merepresentasikan data user, dan repository implementation yang menangani transformasi data serta error handling dari proses autentikasi.

**Domain Layer**: Berisi auth_entity sebagai representasi user dalam logika bisnis, auth_repository interface yang mendefinisikan kontrak operasi autentikasi, serta empat use cases utama yaitu SingInUsecase untuk login, SingUpUsecase untuk registrasi, SingOutUsecase untuk logout, dan GetCurrentUserUsecase untuk mendapatkan user aktif.

**Presentation Layer**: Menggunakan AuthBloc untuk mengelola state autentikasi (initial, loading, authenticated, unauthenticated, error), auth_pages sebagai halaman login dan registrasi, serta custom widgets seperti form input dan text field untuk membangun interface yang user-friendly.

---

### **2. Debate (Debat dengan AI)**

Menyediakan fitur inti aplikasi yaitu debat interaktif dengan AI coach, di mana pengguna dapat mengirim pesan, menerima response dari AI, membuat session debate baru, dan mengelola percakapan dalam format chat yang real-time dan responsif.

**Data Layer**: Berkomunikasi dengan backend API melalui chat_datasource untuk mengirim pesan dan menerima response, menggunakan chat_model dengan JSON serialization otomatis untuk parsing data, dan chat_repository_impl yang menangani transformasi antara model dan entity serta error handling.

**Domain Layer**: Mendefinisikan chat_entity sebagai objek pesan dengan properti role, content, dan session_id, chat_repository interface untuk kontrak operasi chat, serta use cases SendMessageUsecase untuk mengirim pesan ke AI dan CreateSessionUsecase untuk memulai debate session baru.

**Presentation Layer**: DebateBloc mengelola state percakapan dengan events seperti SendMessageEvent dan CreateSessionEvent, debate_page sebagai layar utama chat interface, serta widgets pendukung seperti chat_bubble untuk menampilkan pesan, chat_input untuk input user, dan session_info untuk informasi session aktif.

---

### **3. Topics (Topik Debat)**

Menyediakan berbagai topik debat yang diambil dari NewsAPI berdasarkan kategori tertentu seperti business, entertainment, health, science, sports, dan general, memungkinkan pengguna memilih topik yang menarik untuk dijadikan bahan debate dengan AI coach.

**Data Layer**: Mengintegrasikan NewsAPI melalui topic_datasource untuk mendapatkan berita terkini sebagai topik, topic_model dengan custom field mapping menggunakan @JsonKey untuk memetakan field 'title' dari API ke property 'topic', dan repository yang mengelola cache dan filtering topik berdasarkan kategori.

**Domain Layer**: Berisi topic_entity sebagai representasi topik dengan properti topic, topic_repository interface untuk kontrak pengambilan topik, GetTopicUsecase untuk mengambil topik berdasarkan kategori, dan GetCategoriesUsecase untuk mendapatkan daftar kategori yang tersedia.

**Presentation Layer**: TopicsBloc mengelola state topik dengan events untuk load topics dan filter by category, topics_page menampilkan daftar topik dalam grid atau list view, serta widgets seperti topic_card untuk item topik, category_chip untuk filter kategori, dan search bar untuk pencarian topik.

---

### **4. History (Riwayat Debat)**

Menyimpan dan menampilkan riwayat semua debate yang pernah dilakukan pengguna, memungkinkan user untuk melihat kembali percakapan lama, melanjutkan debate yang tersimpan, atau menghapus history yang tidak diperlukan lagi.

**Data Layer**: Berkomunikasi dengan backend API melalui history_datasource untuk CRUD operations history, history_model dengan struktur nested yang kompleks untuk menyimpan array of messages beserta metadata, dan repository yang menangani transformasi data history dengan proper error handling.

**Domain Layer**: Mendefinisikan history_entity dengan properti session_id, topic, dan history (list of messages), history_message_entity untuk representasi setiap pesan individual dengan timestamp, serta use cases GetHistoryUsecase untuk mengambil history berdasarkan session, GetAllHistoryUsecase untuk semua history user, dan DeleteHistoryUsecase untuk menghapus history.

**Presentation Layer**: HistoryBloc mengelola state history dengan loading, loaded, dan error states, history_page menampilkan list semua session debate yang pernah dilakukan, serta widgets seperti history_card untuk item riwayat dan history_detail untuk menampilkan detail percakapan lengkap.

---

### **5. Profile (Profil Pengguna)**

Mengelola informasi profil pengguna termasuk nama, email, dan institusi, memungkinkan user untuk melihat dan mengupdate data profil mereka dengan sinkronisasi ke Supabase user metadata untuk konsistensi data di seluruh sistem.

**Data Layer**: Menggunakan Supabase user metadata sebagai data source melalui profile_remote_data_source, profile_model dengan JSON serialization untuk properti userName, email, dan institusi, serta repository implementation yang menggunakan Either pattern untuk error handling yang fungsional.

**Domain Layer**: Berisi profile_entity sebagai representasi profil user, profile_repository interface dengan kontrak untuk fetch dan update profile, FetchProfileUsecase untuk mengambil data profil dari server, dan UpdateProfileUsecase untuk menyimpan perubahan profil user.

**Presentation Layer**: ProfileBloc mengelola state profil (initial, loading, loaded, error, updated), profile_page sebagai halaman profil dengan mode view dan edit, serta widgets seperti profile_form untuk form edit profil dan avatar widget untuk menampilkan foto profil user.

---

### **6. Stt (Speech-to-Text)**

Mengintegrasikan fitur speech recognition untuk mengkonversi suara pengguna menjadi text, memungkinkan input pesan debate melalui voice command sehingga user dapat berdebat secara lebih natural dan hands-free.

**Data Layer**: Membungkus package speech_to_text dalam stt_datasource sebagai abstraction layer, stt_model untuk merepresentasikan state recognition (text, speechEnable, isStoped, infoText), dan repository yang mengelola stream real-time dari speech recognition engine.

**Domain Layer**: Mendefinisikan stt_entity untuk state speech recognition, stt_repository interface dengan stream untuk updates real-time, InitSpeechToTextUsecase untuk inisialisasi permission dan engine, StartListeningUsecase untuk mulai recording, dan StopListeningUsecase untuk menghentikan dan finalisasi text.

**Presentation Layer**: SttBloc mengelola state dengan stream subscription untuk real-time updates, menghandle events seperti initialize, start, stop, dan toggle listening, serta menyediakan widgets seperti mic_button untuk trigger recording dan stt_indicator untuk menampilkan status recording.

---

### **7. Analis (Analisis Debat)**

Menyediakan fitur analisis dan evaluasi performa debat pengguna dengan menampilkan statistik komprehensif dan 5 sesi terbaru, memberikan insights tentang perkembangan kemampuan debat melalui visualisasi data yang informatif.

**Fitur Utama**:

- **Analytics Dashboard**: Menampilkan ringkasan statistik keseluruhan meliputi total sesi selesai, skor rata-rata, topik yang dikuasai, dan total waktu debat.
- **Recent Sessions**: Menampilkan 5 sesi debat terbaru dengan detail topik, score, durasi, dan tanggal.
- **Dynamic Scoring**: Sistem penilaian otomatis berdasarkan engagement (jumlah message dan kualitas interaksi).
- **Data Integration**: Mengambil data dari History untuk analisis komprehensif.

**Data Layer**: AnalisModel untuk analytics statistics dan session data dengan parsing dari JSON, AnalisRepositoryImpl mengakses HistoryRepository untuk mengambil data session dan menghitung metrics, serta implementasi caching untuk performa optimal.

**Domain Layer**: Mendefinisikan AnalyticsEntity untuk statistik keseluruhan (totalSessions, averageScore, masteredTopics, totalTime), SessionEntity untuk data sesi individual, AnalisRepository interface dengan methods getAnalytics() dan getRecentSessions(limit), GetAnalyticsUseCase untuk retrieve statistik, dan GetRecentSessionsUseCase untuk retrieve sesi terbaru.

**Presentation Layer**: AnalisBloc mengelola state analytics dan sessions dengan events LoadAnalisDataEvent dan RefreshAnalisDataEvent, states meliputi AnalisLoading, AnalisLoaded, dan AnalisError, AnalisPage menampilkan hero card, stats grid, dan sessions list, serta widgets CardItemWidget untuk stat cards dan CardSessionWidget untuk session items.

**Algoritma Scoring**:

- Score dihitung berdasarkan jumlah message dalam sesi (lebih engaged = score lebih tinggi)
- Formula: `score = (messageCount / 10).clamp(0, 10)`
- Topik dikuasai: session dengan score >= 8.0
- Durasi estimasi: 2 menit per message

**Ide Pengembangan Future**:

1. **Advanced Analytics**: Grafik tren performa dari waktu ke waktu, breakdown score per kategori (argumentasi, logika, retorika), comparison dengan user lain (leaderboard).
2. **AI-Powered Insights**: Analisis sentimen dari argumentasi, deteksi logical fallacies, saran improvement spesifik per topik.
3. **Detailed Session Analysis**: Deep dive per session dengan highlight best arguments, weak points analysis, time spent per argument.
4. **Achievement System**: Badges untuk milestones, streaks untuk consistency, level progression.
5. **Export & Share**: PDF report generation, share achievements ke social media, export data untuk personal review.
6. **Personalized Recommendations**: Topik yang perlu ditingkatkan, recommended practice topics, customized training plan.

---

### **8. Home (Halaman Utama)**

Berfungsi sebagai landing page atau dashboard aplikasi yang menjadi titik awal interaksi pengguna, menampilkan overview fitur-fitur utama, quick access ke debate baru, serta informasi singkat tentang aplikasi (minimal setup untuk saat ini).

---

## 🔧 Shared Module - Komponen Bersama

│ │ ├── chat_model.dart # Chat message model
│ │ └── chat_model.g.dart # Generated JSON serialization
│ └── repositories/
│ └── chat_repository_impl.dart # Chat logic implementation
├── domain/
│ ├── entities/
│ │ └── chat_entity.dart # Chat message entity
│ ├── repositories/
│ │ └── chat_repository.dart # Chat repository interface
│ └── usecases/
│ ├── send_message_usecase.dart # Send message to AI
│ └── create_session_usecase.dart # Create debate session
└── presentation/
├── bloc/
│ ├── debate_bloc.dart # Debate state management
│ ├── debate_event.dart # Debate events
│ └── debate_state.dart # Debate states
├── pages/
│ └── debate_page.dart # Debate chat screen
└── widgets/
├── chat_bubble_widget.dart # Message bubble
├── chat_input_widget.dart # Input field
└── session_info_widget.dart # Session information

```

**Key Components**:

- **Entity**: `ChatEntity` (role, content, session_id)
- **UseCases**:
  - `SendMessageUsecase` - Kirim pesan ke AI dan terima response
  - `CreateSessionUsecase` - Membuat session debate baru
- **BLoC Events**:
  - `SendMessageEvent` - User mengirim pesan
  - `CreateSessionEvent` - Memulai session baru
- **BLoC States**:
  - `DebateLoading` - Menunggu response
  - `DebateLoaded` - Pesan berhasil di-load
  - `DebateError` - Terjadi error

---

### 3. 📚 Topics

**Purpose**: Menampilkan dan mengelola topik-topik debate dari NewsAPI.

```

Topics/
├── data/
│ ├── datasources/
│ │ └── topic_datasource.dart # NewsAPI integration
│ ├── models/
│ │ ├── topic_model.dart # Topic model
│ │ └── topic_model.g.dart # Generated JSON serialization
│ └── repositories/
│ └── topic_repository_impl.dart # Topic logic
├── domain/
│ ├── entities/
│ │ └── topic_entity.dart # Topic entity
│ ├── repositories/
│ │ └── topic_repository.dart # Topic repository interface
│ └── usecases/
│ ├── get_topic_usecase.dart # Get topics by category
│ └── get_categori_usecase.dart # Get all categories
└── presentation/
├── bloc/
│ ├── topics_bloc.dart # Topics state management
│ ├── topics_event.dart # Topics events
│ └── topics_state.dart # Topics states
├── pages/
│ └── topics_page.dart # Topics list screen
└── widgets/
├── topic_card_widget.dart # Topic card item
├── category_chip_widget.dart # Category filter
└── topic_search_widget.dart # Search bar

```

**Key Components**:

- **DataSource**: Integrasi dengan NewsAPI untuk mendapatkan berita
- **Model**: `TopicModel` dengan custom JSON key mapping (`@JsonKey(name: 'title')`)
- **UseCases**:
  - `GetTopicUsecase` - Mendapatkan topik berdasarkan kategori
  - `GetCategoriesUsecase` - Mendapatkan list kategori
- **Categories**: business, entertainment, general, health, science, sports

---

### 4. 📖 History

**Purpose**: Menyimpan dan menampilkan riwayat debate yang telah dilakukan.

```

History/
├── data/
│ ├── datasources/
│ │ └── history_datasource.dart # API untuk history
│ ├── models/
│ │ ├── history_model.dart # History model
│ │ └── history_model.g.dart # Generated JSON serialization
│ └── repositories/
│ └── history_repository_impl.dart # History logic
├── domain/
│ ├── entities/
│ │ └── history_entity.dart # History entity
│ ├── repositories/
│ │ └── history_repository.dart # History repository interface
│ └── usecases/
│ ├── GetHistory_usecase.dart # Get history by session_id
│ ├── GetAllHistory_usecase.dart # Get all history
│ └── DeleteHistory_usecase.dart # Delete history
└── presentation/
├── bloc/
│ ├── history_bloc.dart # History state management
│ ├── history_event.dart # History events
│ └── history_state.dart # History states
├── pages/
│ └── history_page.dart # History list screen
└── widgets/
├── history_card_widget.dart # History item card
└── history_detail_widget.dart # History detail view

```

**Key Components**:

- **Entity**:
  - `HistoryEntity` - session_id, topic, history (List<Map>)
  - `HistoryMessageEntity` - role, content, timestamp
- **UseCases**:
  - `GetHistoryUsecase` - Ambil history berdasarkan session_id
  - `GetAllHistoryUsecase` - Ambil semua history user
  - `DeleteHistoryUsecase` - Hapus history tertentu
- **Complex Data**: History menyimpan struktur nested (list of messages)

---

### 5. 👤 Profile

**Purpose**: Mengelola profil user (view & update).

```

Profile/
├── data/
│ ├── datasources/
│ │ └── profile_remote_data_source.dart # Supabase user metadata
│ ├── models/
│ │ ├── profile_model.dart # Profile model
│ │ └── profile_model.g.dart # Generated JSON serialization
│ └── repositories/
│ └── profile_repository_impl.dart # Profile logic
├── domain/
│ ├── entities/
│ │ └── profile_entity.dart # Profile entity
│ ├── repositories/
│ │ └── profile_repository.dart # Profile repository interface
│ └── usecases/
│ ├── fetchProfile_usecase.dart # Get user profile
│ └── updateProfile_usecase.dart # Update user profile
└── presentation/
├── bloc/
│ ├── profile_bloc.dart # Profile state management
│ ├── profile_event.dart # Profile events
│ └── profile_state.dart # Profile states
├── pages/
│ └── profile_page.dart # Profile screen
└── widgets/
├── profile_form_widget.dart # Edit profile form
└── avatar_widget.dart # User avatar

```

**Key Components**:

- **Entity**: `ProfileEntity` (userName, email, institusi)
- **DataSource**: Menggunakan Supabase user metadata
- **UseCases**:
  - `FetchProfileUsecase` - Mengambil data profil user
  - `UpdateProfileUsecase` - Update informasi profil
- **Either Pattern**: Menggunakan `Either<Failure, ProfileEntity>` untuk error handling

---

### 6. 🎤 Stt (Speech-to-Text)

**Purpose**: Mengkonversi suara menjadi text untuk input debate.

```

Stt/
├── data/
│ ├── datasources/
│ │ └── stt_datasource.dart # speech_to_text package wrapper
│ ├── models/
│ │ └── stt_model.dart # STT state model
│ └── repositories/
│ └── stt_repository_impl.dart # STT logic implementation
├── domain/
│ ├── entities/
│ │ └── stt_entity.dart # STT entity
│ ├── repositories/
│ │ └── stt_repository.dart # STT repository interface
│ └── usecases/
│ ├── initSpeechToText_usecase.dart # Initialize STT
│ ├── startListening_usecase.dart # Start recording
│ └── stopListening_usecase.dart # Stop recording
└── presentation/
├── bloc/
│ ├── stt_bloc.dart # STT state management
│ ├── stt_event.dart # STT events
│ └── stt_state.dart # STT states
└── widgets/
├── mic_button_widget.dart # Microphone button
└── stt_indicator_widget.dart # Recording indicator

```

**Key Components**:

- **Entity**: `SttEntity` (text, speechEnable, isStoped, infoText)
- **DataSource**: Wrapper untuk `speech_to_text` package
- **Stream**: Menggunakan Stream untuk real-time speech recognition
- **UseCases**:
  - `InitSpeechToTextUsecase` - Inisialisasi permission & engine
  - `StartListeningUsecase` - Mulai mendengarkan suara
  - `StopListeningUsecase` - Stop dan finalisasi text
- **Real-time Updates**: BLoC menerima stream dari repository

---

### 7. 📊 Analis

**Purpose**: Menampilkan analisis komprehensif dan statistik performa debat pengguna.

```

Analis/
├── data/
│ ├── datasources/
│ │ ├── analis_local_data_source.dart # Local caching (untuk future)
│ │ └── analis_remote_data_source.dart # Remote API (untuk future)
│ ├── models/
│ │ └── analis_model.dart # AnalyticsModel & SessionModel
│ └── repositories/
│ └── analis_repository_impl.dart # Implementasi mengakses History
├── domain/
│ ├── entities/
│ │ └── analis_entity.dart # AnalyticsEntity & SessionEntity
│ ├── repositories/
│ │ └── analis_repository.dart # Repository interface
│ └── usecases/
│ ├── get_analytics_usecase.dart # Get overall statistics
│ └── get_recent_sessions_usecase.dart # Get 5 recent sessions
└── presentation/
├── bloc/
│ ├── analis_bloc.dart # Analis state management
│ ├── analis_event.dart # LoadData & Refresh events
│ └── analis_state.dart # Loading, Loaded, Error states
├── pages/
│ └── analis_page.dart # Analysis dashboard screen
└── widgets/
├── card_item_widget.dart # Stat card (total sessions, avg score, etc)
├── card_session_widget.dart # Session info card
└── (variants \_new.dart) # UI alternatives

```

**Key Components**:

- **Entities**:
  - `AnalyticsEntity` (totalSessions, averageScore, masteredTopics, totalTime)
  - `SessionEntity` (sessionId, topic, score, duration, date, messageCount)
- **Repository**: Mengakses `HistoryRepository` untuk calculate analytics
- **UseCases**:
  - `GetAnalyticsUseCase` - Retrieve overall statistics
  - `GetRecentSessionsUseCase` - Get 5 most recent sessions
- **BLoC Events**:
  - `LoadAnalisDataEvent` - Initial data load
  - `RefreshAnalisDataEvent` - Refresh data
- **BLoC States**:
  - `AnalisLoading` - Loading state
  - `AnalisLoaded` - Data berhasil dimuat (analytics + sessions)
  - `AnalisError` - Error state dengan message
- **Dynamic Metrics**:
  - Score calculation berdasarkan engagement
  - Auto-categorization topik yang dikuasai (score >= 8.0)
  - Duration estimation dari message count

**Fitur yang Ditampilkan**:
1. Hero Card - Overview analisis
2. Stats Grid - 4 metrik utama (sessions, avg score, mastered topics, total time)
3. Recent Sessions - 5 sesi terbaru dengan detail lengkap

---

### 8. 🏠 Home

**Purpose**: Landing page atau dashboard aplikasi.

```

Home/
├── data/
│ ├── datasources/
│ ├── models/
│ │ └── home_model.dart # Home model (empty)
│ └── repositories/
├── domain/
│ ├── entities/
│ ├── repositories/
│ └── usecases/
└── presentation/
└── pages/
└── home_page.dart # Home screen

```

**Note**: Feature ini minimal setup, mungkin hanya sebagai splash atau dashboard sederhana.

---


Shared module menyediakan komponen-komponen yang dapat digunakan kembali oleh berbagai fitur untuk menghindari duplikasi kode dan memastikan konsistensi di seluruh aplikasi.

### **shared/data/**
Menampung data sources atau models yang digunakan secara bersama oleh beberapa feature, seperti common API endpoints atau shared database models yang tidak spesifik untuk satu fitur tertentu.

### **shared/domain/**
Berisi entities atau repository interfaces yang sifatnya general dan dapat digunakan di berbagai feature, memastikan reusability logika bisnis yang umum tanpa perlu duplikasi code.

### **shared/presentation/**
Menyediakan widget-widget umum yang dapat dipakai di berbagai halaman seperti custom buttons, loading indicators, dialog boxes, dan komponen UI lainnya yang memiliki tampilan dan behavior konsisten di seluruh aplikasi.

### **shared/utils/**
Menampung utilitas helper dan tools yang mendukung fungsionalitas aplikasi.

**debouncer.dart** - Utility untuk menunda eksekusi fungsi sampai user selesai melakukan aksi tertentu, sangat berguna untuk search input agar tidak spam API call setiap karakter yang diketik, serta untuk auto-save yang menunggu user berhenti mengetik sebelum menyimpan data.

**logger.dart** - Sistem logging terpusat untuk debugging aplikasi dengan berbagai log levels (info, warning, error), formatted output yang mudah dibaca, mode berbeda untuk production dan development, serta kemampuan untuk log stack trace yang membantu troubleshooting bugs.

---

## 💉 Dependency Injection

File **injection.dart** mengelola seluruh dependency injection menggunakan GetIt sebagai service locator pattern, bertanggung jawab untuk registrasi dan penyediaan semua dependencies seperti BLoC, UseCases, Repositories, DataSources, dan external services agar dapat diakses dengan mudah di seluruh aplikasi tanpa tight coupling.

### **Tipe Registrasi**

**registerFactory** - Membuat instance baru setiap kali dipanggil, digunakan untuk BLoCs dan ViewModels yang perlu fresh instance untuk setiap screen agar state tidak tercampur.

**registerLazySingleton** - Membuat instance pertama kali diminta kemudian reuse instance yang sama untuk request selanjutnya, ideal untuk Repositories, DataSources, dan UseCases yang dapat dibagi di berbagai tempat tanpa perlu instance baru.

**registerSingleton** - Membuat dan menyimpan instance langsung saat registration, digunakan untuk external services seperti Dio dan Supabase client yang perlu diinisialisasi sekali dan digunakan sepanjang lifecycle aplikasi.

### **Alur Dependency**

Dependencies mengalir dari layer presentation ke data dengan pola: BLoC (Factory) → UseCase (LazySingleton) → Repository (LazySingleton) → DataSource (LazySingleton) → External API (Singleton), memastikan setiap layer mendapatkan dependencies yang dibutuhkan melalui constructor injection untuk loose coupling dan easy testing.

---

## 🔄 State Management dengan BLoC Pattern

Aplikasi menggunakan BLoC (Business Logic Component) Pattern dengan library flutter_bloc untuk mengelola state secara predictable, memisahkan business logic dari UI, dan memudahkan testing serta maintenance code.

### **Struktur BLoC**

Setiap feature memiliki tiga komponen BLoC yang saling bekerja sama untuk mengelola state aplikasi.

**Events** - Merepresentasikan input atau trigger dari user interface yang menandakan aksi tertentu yang perlu dilakukan, seperti SendMessageEvent ketika user mengirim pesan atau LoadProfileEvent ketika membuka halaman profil, setiap event membawa data yang diperlukan untuk menjalankan aksi tersebut.

**States** - Merepresentasikan kondisi atau keadaan aplikasi pada waktu tertentu yang akan mempengaruhi tampilan UI, seperti Loading state menampilkan loading indicator, Loaded state menampilkan data, Error state menampilkan pesan error, dan Initial state sebagai kondisi awal sebelum ada interaksi.

**BLoC** - Komponen inti yang menerima events dari UI, menjalankan business logic melalui use cases, dan emit states baru yang akan memicu rebuild widget, bertindak sebagai jembatan antara presentation layer dan domain layer dengan menjaga separation of concerns.

### **MultiBlocProvider**

Di file main.dart, semua BLoC yang dibutuhkan secara global didaftarkan menggunakan MultiBlocProvider sehingga dapat diakses dari mana saja dalam widget tree tanpa perlu passing melalui constructor, memudahkan state sharing antar screens dan mengurangi boilerplate code.

---

## 📊 Alur Data (Data Flow)

Data mengalir melalui arsitektur aplikasi dengan pola yang jelas dan terstruktur untuk memastikan separation of concerns dan kemudahan testing.

### **Flow dari User ke Backend**

1. **User Interaction** - User melakukan aksi di UI seperti tap button, input text, atau gesture lainnya
2. **Widget Dispatch Event** - Widget mengirim event ke BLoC menggunakan context.read<BLoC>().add(Event)
3. **BLoC Menerima Event** - BLoC menerima event dan emit loading state terlebih dahulu
4. **BLoC Calls UseCase** - BLoC memanggil use case yang sesuai dengan passing parameter yang diperlukan
5. **UseCase Execute Logic** - UseCase menjalankan business logic seperti validasi dan calls repository
6. **Repository Calls DataSource** - Repository memanggil data source untuk fetch atau save data
7. **DataSource Hits API** - DataSource melakukan HTTP request ke backend API
8. **Response Transformation** - DataSource menerima JSON, DataSource membuat Model dari JSON, Repository convert Model ke Entity
9. **Result Back to BLoC** - Menggunakan Either pattern (Left untuk error, Right untuk success) data kembali ke BLoC
10. **BLoC Emit New State** - BLoC emit state baru (Loaded atau Error) berdasarkan result
11. **UI Rebuilds** - BlocBuilder detect state change dan rebuild widget sesuai kondisi state

### **Contoh Flow: Mengirim Pesan Debate**

User ketik pesan dan tekan send → Widget dispatch SendMessageEvent → DebateBloc emit DebateLoading → DebateBloc calls SendMessageUsecase → UseCase validasi input dan call ChatRepository.sendMessage() → ChatRepositoryImpl calls ChatDatasource.sendMessage() → ChatDatasource kirim HTTP POST ke API → API response JSON diterima → ChatDatasource parse JSON ke ChatModel → Repository convert ChatModel ke ChatEntity → Repository return Either.right(entity) → DebateBloc terima result → DebateBloc emit DebateLoaded dengan messages updated → BlocBuilder rebuild UI → User melihat pesan baru di layar.

---

## 🔧 JSON Serialization

Project menggunakan **json_serializable** package untuk automatic JSON serialization yang type-safe dan performant, menghilangkan manual fromJson/toJson implementation yang error-prone.

### **Implementasi**

Setiap model menggunakan annotation @JsonSerializable() dan memiliki file .g.dart yang di-generate otomatis oleh build_runner, berisi implementasi fromJson dan toJson yang optimized dan type-safe.

### **Custom Field Mapping**

Untuk field yang nama JSON-nya berbeda dengan property Dart, menggunakan @JsonKey annotation seperti pada TopicModel yang memetakan field 'title' dari JSON ke property 'topicValue' di Dart, memastikan fleksibilitas dalam handling API response dengan naming yang berbeda.

### **Generate Command**

Untuk generate atau regenerate file serialization menggunakan command: `flutter pub run build_runner build --delete-conflicting-outputs` yang akan create atau update semua file .g.dart berdasarkan model yang memiliki @JsonSerializable annotation.

---

## 🧪 Error Handling

Aplikasi menggunakan functional error handling dengan Either pattern dari package dartz untuk menangani error secara type-safe dan explicit.

### **Failure Classes**

Error direpresentasikan sebagai Failure classes yang merupakan abstract class dengan berbagai subclass seperti ServerFailure untuk error dari API atau backend, CacheFailure untuk error penyimpanan lokal, dan NetworkFailure untuk masalah koneksi internet, memudahkan handling error secara spesifik.

### **Either Pattern**

Repository methods return Either<Failure, Data> di mana Left berisi error (Failure) dan Right berisi data sukses, memaksa developer untuk handle kedua kemungkinan (success dan error) sehingga mengurangi bugs karena unhandled errors.

### **Error Flow**

Ketika terjadi error di DataSource, error di-catch dan di-wrap dalam Failure object, repository return Left(Failure), UseCase forward Either ke BLoC, BLoC use fold() method untuk handle Left (emit Error state) atau Right (emit Success state), dan UI menampilkan error message atau success UI berdasarkan state yang di-emit.

---

## 🚀 Navigasi dan Routing

Aplikasi menggunakan **GoRouter** package untuk declarative routing yang powerful dan flexible, mendukung deep linking, navigation guards, dan route parameter passing dengan type-safe.

### **Route Configuration**

Semua routes didefinisikan di app_router.dart dengan path, name, dan builder untuk setiap screen, menggunakan AppRoute enum dari app_router_enum.dart untuk route names yang type-safe dan mencegah typo.

### **Navigation Methods**

Untuk navigasi menggunakan context.pushNamed() untuk push screen baru ke stack, context.goNamed() untuk replace current screen, dan context.pop() untuk kembali ke screen sebelumnya, semua navigation menggunakan named routes untuk code yang lebih maintainable.

---

## 📚 Dependencies Utama

### **Core Dependencies**
flutter_bloc untuk state management dengan BLoC pattern, get_it untuk dependency injection dan service locator, go_router untuk routing dan navigation, equatable untuk value comparison di BLoC states dan events, serta dartz untuk functional programming dengan Either pattern.

### **Data Layer**
dio untuk HTTP client yang powerful dengan interceptors dan timeout configuration, supabase_flutter untuk backend as a service dengan auth dan database, json_annotation untuk annotations pada models, build_runner untuk code generation, dan json_serializable untuk generate JSON serialization code.

### **Features**
speech_to_text untuk speech recognition di fitur STT, flutter_tts untuk text-to-speech functionality, intl untuk internationalization dan date formatting yang konsisten di seluruh aplikasi.

---

## ⚡ Optimasi dan Skalabilitas

### **Performance Optimization**

Lazy loading pada dependencies dengan LazySingleton registratio

  DebateBloc({required this.sendMessage}) : super(DebateInitial()) {
    on<SendMessageEvent>(_onSendMessage);
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<DebateState> emit,
  ) async {
    emit(DebateLoading());

    final result = await sendMessage(
      prompt: event.message,
      sessionId: event.sessionId,
    );

    result.fold(
      (failure) => emit(DebateError(failure.message)),
      (message) => emit(DebateLoaded(messages: [...messages, message])),
    );
  }
}
```

n memastikan dependencies hanya dibuat saat dibutuhkan untuk menghemat memory, BLoCs menggunakan Factory registration agar setiap screen mendapat fresh instance untuk state management yang bersih, dan Debouncer utility mengurangi unnecessary API calls pada fitur search dan input.

### **Code Generation**

JSON serialization menggunakan code generation bukan reflection sehingga lebih performant pada runtime, tidak ada overhead reflection di production build, dan type-safety dijamin saat compile time bukan runtime.

### **Modular Architecture**

Setiap feature adalah self-contained module yang dapat dikembangkan, ditest, dan di-deploy secara independen, memungkinkan tim bekerja parallel pada feature berbeda tanpa conflict, serta mudah untuk menambah atau remove feature tanpa mempengaruhi feature lain.

---

## 🌐 Penjelasan API yang Digunakan

Project COACH Debate mengintegrasikan beberapa API eksternal untuk mendukung fungsionalitas aplikasi, mulai dari backend custom untuk AI debate hingga API publik untuk mengambil topik berita terkini.

### **1. Django Backend API (Groq LLM)**

Backend custom yang di-deploy di Vercel berfungsi sebagai middleware untuk komunikasi dengan AI model Groq LLM, menangani seluruh logika debate termasuk processing pesan user, generating response dari AI coach, manajemen session debate, serta penyimpanan history percakapan yang dilakukan pengguna.

**Base URL**: `https://django-backend-debate-app.vercel.app`

**Endpoints yang Digunakan**:

**Chat Endpoint** (`/api/chat/`) - Endpoint utama untuk fitur debate yang menerima pesan dari user beserta session ID, memproses pesan tersebut melalui Groq LLM untuk menghasilkan response AI coach yang kontekstual dan relevan, kemudian mengembalikan response dalam format JSON yang berisi pesan AI beserta metadata session untuk melanjutkan percakapan yang koheren.

**Topics Endpoint** (`/api/topics/`) - Menyediakan daftar topik debate yang tersedia atau topik yang disarankan berdasarkan preferensi user, membantu user memilih tema debat yang menarik, dan dapat difilter berdasarkan kategori atau difficulty level untuk personalisasi pengalaman debate.

**History Endpoint** (`/api/history/`) - Mengelola penyimpanan dan pengambilan riwayat debate user dengan menyimpan seluruh percakapan beserta metadata seperti topik, timestamp, dan session ID, memungkinkan user untuk melihat kembali debate yang pernah dilakukan, melanjutkan session yang tersimpan, atau menghapus history yang tidak diperlukan lagi.

**Cara Penggunaan**:

Aplikasi berkomunikasi dengan backend melalui HTTP client Dio yang telah dikonfigurasi dengan timeout 60 detik untuk mencegah request hang, interceptor untuk logging request dan response guna debugging, serta automatic retry mechanism untuk handling network errors, semua request menggunakan JSON format untuk data exchange dengan proper error handling menggunakan Either pattern.

**Fitur yang Menggunakan**:

- Debate feature untuk chat dengan AI coach
- History feature untuk load dan manage riwayat
- Topics feature (optional) untuk suggested topics

---

### **2. NewsAPI - Public News API**

API publik dari NewsAPI.org yang menyediakan akses ke ribuan artikel berita dari berbagai sumber media di seluruh dunia, digunakan untuk mengambil topik-topik terkini yang dapat dijadikan bahan debate sehingga user dapat berdebat tentang isu-isu aktual dan relevan dengan kondisi terkini.

**Base URL**: `https://newsapi.org/v2`

**API Key**: Disimpan dalam `api_config.dart` untuk autentikasi ke NewsAPI service (Note: Sebaiknya dipindahkan ke environment variables untuk keamanan yang lebih baik).

**Endpoint yang Digunakan**:

**Everything Endpoint** (`/everything`) - Mengambil artikel berita berdasarkan kata kunci pencarian dengan berbagai filter yang fleksibel termasuk rentang tanggal publikasi, bahasa artikel, sorting berdasarkan relevancy atau popularity, serta pagination untuk load data secara bertahap dan efisien.

**Query Parameters**:

**q (query)** - Kata kunci pencarian untuk filtering berita berdasarkan topik tertentu seperti "teknologi", "politik", "kesehatan", mendukung boolean operators untuk pencarian yang lebih spesifik dan akurat.

**from & to** - Rentang tanggal publikasi artikel dalam format YYYY-MM-DD untuk mengambil berita dari periode tertentu, memungkinkan user mendapatkan topik yang time-relevant atau historical debate topics.

**language** - Filter bahasa artikel dengan default "id" untuk bahasa Indonesia, mendukung multiple language codes sesuai ISO 639-1 standard seperti "en" untuk English, "es" untuk Spanish, memastikan content yang sesuai dengan preferensi user.

**pageSize** - Jumlah artikel per request dengan default 10 items untuk optimasi bandwidth dan performance, dapat disesuaikan antara 1-100 articles tergantung kebutuhan UI dan UX design.

**page** - Nomor halaman untuk pagination yang memungkinkan infinite scrolling atau load more functionality, starting from page 1 dan increment untuk fetch additional articles.

**apiKey** - Authentication key untuk akses ke NewsAPI service yang diperlukan untuk setiap request, managed melalui ApiConfig class dengan proper security considerations.

**Method Helper**:

`getNewsAPIurl()` - Method utility di ApiConfig class yang membangun URL lengkap dengan query parameters secara dynamic, melakukan validation dan sanitization input, automatic removal null parameters untuk URL yang clean, serta ensure proper URL encoding untuk special characters dalam query string.

**Fitur yang Menggunakan**:

- Topics feature untuk menampilkan berita sebagai topik debate
- Category filtering (business, entertainment, health, science, sports)
- Search functionality untuk cari topik spesifik

**Implementasi**:

TopicDatasource menggunakan Dio untuk hit NewsAPI endpoint dengan proper error handling, response dari API di-parse menjadi TopicModel menggunakan JSON serialization, kemudian di-transform ke TopicEntity untuk digunakan di domain layer, dengan caching mechanism untuk reduce API calls dan improve performance terutama untuk frequently accessed categories.

---

### **3. Supabase - Backend as a Service**

Platform Backend as a Service yang menyediakan solusi lengkap untuk authentication, database, storage, dan real-time subscriptions, digunakan sebagai backbone untuk user management dan data persistence dengan infrastructure yang scalable dan secure.

**Configuration**: URL dan Anon Key disimpan dalam file `.env` dan di-load menggunakan flutter_dotenv untuk menjaga keamanan credentials, credentials tidak di-hardcode dalam source code untuk prevent exposure di version control.

**URL**: Loaded dari environment variable `SUPABASE_URL`  
**Anon Key**: Loaded dari environment variable `SUPABASE_KEY`

**Fitur yang Digunakan**:

**Supabase Auth** - Sistem autentikasi yang robust untuk mengelola user registration dengan email verification, login dengan email dan password yang secure, logout untuk clear session, password reset functionality, serta session management dengan automatic token refresh untuk maintain user login state.

**User Metadata** - Penyimpanan informasi profil user tambahan di luar data autentikasi standar seperti userName untuk display name, institusi untuk organizational affiliation, dan custom fields lainnya yang dapat extend sesuai kebutuhan aplikasi, semua tersinkronisasi dengan user authentication state.

**Row Level Security (RLS)** - Security policies di database level yang memastikan user hanya dapat access data mereka sendiri, automatic enforcement pada setiap query untuk data isolation, configurable rules untuk different tables dan operations, providing enterprise-grade security tanpa complex backend logic.

**Fitur yang Menggunakan**:

- Auth feature untuk login, register, logout
- Profile feature untuk fetch dan update user data
- Potential future use untuk store user preferences

**Implementasi**:

AuthRemoteDataSource menggunakan Supabase client untuk semua operasi autentikasi dengan proper error handling dan user-friendly error messages, ProfileRemoteDataSource menggunakan user metadata API untuk CRUD operations profil dengan validation dan sanitization, semua operations wrapped dalam Either pattern untuk consistent error handling across the application.

---

### **4. Speech-to-Text Package**

Package Flutter `speech_to_text` yang membungkus native speech recognition engines dari platform (Google Speech untuk Android dan Apple Speech untuk iOS) untuk mengkonversi audio input menjadi text secara real-time dengan accuracy yang tinggi.

**Bukan API Eksternal**: Ini adalah package yang menggunakan on-device speech recognition dari OS, tidak memerlukan API key atau network call untuk basic functionality, working offline dengan performance yang optimal dan privacy-friendly.

**Fitur**:

**Real-time Recognition** - Mengkonversi suara ke text secara live dengan latency minimal, memberikan feedback instant kepada user saat berbicara, mendukung continuous recognition untuk input yang panjang, serta partial results untuk show progress sebelum finalization.

**Permission Handling** - Otomatis request microphone permission dari user dengan proper messaging, handle permission denied gracefully dengan user-friendly error, re-request permission jika needed, serta comply dengan platform-specific permission requirements.

**Language Support** - Mendukung multiple bahasa termasuk Bahasa Indonesia dan English, automatic language detection atau manual selection, locale-aware recognition untuk better accuracy, supporting regional dialects dan accents.

**Fitur yang Menggunakan**:

- Stt feature untuk voice input di debate
- Alternative input method selain keyboard
- Accessibility support untuk users

**Implementasi**:

SttDatasource membungkus speech_to_text package dalam clean interface yang sesuai dengan arsitektur aplikasi, SttRepository mengelola stream of recognition results untuk real-time updates ke BLoC, proper initialization dan cleanup untuk prevent memory leaks, serta comprehensive error handling untuk various speech recognition scenarios.

---

## 🔐 Keamanan API

### **Environment Variables**

Sensitive data seperti Supabase credentials disimpan dalam file `.env` yang tidak di-commit ke version control (listed dalam `.gitignore`), loaded menggunakan flutter_dotenv package saat aplikasi startup, memastikan credentials tidak ter-expose di source code atau public repositories, dengan separate `.env` files untuk development dan production environments.

### **API Key Management**

NewsAPI key saat ini masih hardcoded di `api_config.dart` yang merupakan security concern, sebaiknya dipindahkan ke environment variables untuk better security practice, implement API key rotation policy untuk regular updates, serta consider using backend proxy untuk hide API keys dari client-side code dan add rate limiting untuk prevent abuse.

### **Rate Limiting**

NewsAPI memiliki rate limit berdasarkan tier subscription dengan free tier limited requests per day, aplikasi implement local caching untuk reduce unnecessary API calls, debouncing pada search input untuk prevent spam requests, serta proper error handling ketika rate limit exceeded dengan user-friendly messaging.

### **HTTPS Only**

Semua API communications menggunakan HTTPS protocol untuk encrypted data transmission, certificate pinning dapat di-implement untuk additional security pada production, ensure no fallback ke HTTP untuk prevent man-in-the-middle attacks, serta validate SSL certificates untuk trusted connections.

---

## 📡 HTTP Client Configuration

### **Dio Configuration**

Aplikasi menggunakan Dio sebagai HTTP client dengan konfigurasi optimal untuk reliability dan performance.

**Timeout Settings**: Connect timeout 60 detik untuk initial connection establishment, receive timeout 60 detik untuk waiting response dari server, send timeout 6 detik untuk uploading request data, semua configurable untuk different network conditions.

**Interceptors**: LogInterceptor untuk logging semua request dan response details guna debugging dan monitoring, potential untuk add authentication interceptor untuk automatic token injection, retry interceptor untuk handle temporary network failures, serta custom error interceptor untuk standardized error handling.

**Error Handling**: Automatic detection berbagai HTTP error codes dengan appropriate Failure mapping, network errors di-catch dan di-convert ke NetworkFailure, timeout errors handled gracefully dengan retry option, serta parse server error messages untuk user-friendly display.

---

## 🔄 API Integration Flow

### **Typical Request Flow**

User melakukan aksi di UI yang trigger event ke BLoC, BLoC calls appropriate UseCase untuk business logic execution, UseCase calls Repository dengan required parameters, Repository calls DataSource untuk external communication, DataSource menggunakan Dio untuk hit API endpoint dengan proper headers dan body, menerima response dalam JSON format, parsing JSON ke Model menggunakan json_serializable, Repository convert Model ke Entity untuk domain layer, return Either<Failure, Entity> based on success or error, BLoC emit appropriate state berdasarkan result, dan Widget rebuild dengan data baru atau error message.

### **Contoh: Fetch Topics dari NewsAPI**

User membuka Topics page yang trigger GetTopicsEvent, TopicsBloc emit loading state dan calls GetTopicUsecase, UseCase calls TopicRepository.getTopics(category), TopicRepositoryImpl calls TopicDatasource.getTopics(category), Datasource build URL menggunakan ApiConfig.getNewsAPIurl(), Dio execute GET request ke NewsAPI dengan query parameters, NewsAPI return JSON array of articles, Datasource parse JSON ke List<TopicModel>, Repository convert models ke List<TopicEntity>, Return Right(topics) jika success atau Left(Failure) jika error, BLoC emit GetTopicsState dengan data topics, dan TopicsPage rebuild menampilkan list topik di UI.

---

## 🎯 Best Practices API Integration

### **Caching Strategy**

Implement local caching untuk frequently accessed data seperti topics dan categories untuk reduce network calls dan improve response time, cache invalidation strategy dengan TTL (Time To Live) untuk ensure data freshness, persistent cache menggunakan shared_preferences atau database untuk offline access, serta cache warming untuk pre-load common data.

### **Error Recovery**

Implement retry mechanism dengan exponential backoff untuk temporary failures, provide offline mode dengan cached data ketika network unavailable, user-friendly error messages yang actionable bukan technical jargon, serta graceful degradation ketika API unavailable dengan fallback options.

### **Performance Optimization**

Pagination untuk large datasets agar tidak load semua data sekaligus, lazy loading dengan scroll-based triggers untuk infinite list, debouncing pada search dan user input untuk reduce API calls, serta request cancellation ketika user navigate away untuk save bandwidth.

### **Monitoring**

Logging semua API requests dan responses untuk debugging dan analytics, track API errors dan failures untuk identify patterns, monitor API response times untuk performance optimization, serta usage analytics untuk understand user behavior dan optimize API usage.

---

## 🎯 Best Practices

### **Yang Harus Dilakukan**

Pertahankan pemisahan layer dengan tidak skip layer dalam data flow untuk menjaga clean architecture, gunakan dependency injection dengan GetIt untuk loose coupling dan easy testing, buat entities immutable menggunakan const dan final untuk predictable state, gunakan Equatable untuk value comparison di BLoC states dan events, serta ikuti naming convention yang konsisten seperti _\_entity.dart untuk entities, _\_model.dart untuk models, _\_usecase.dart untuk use cases, dan _\_bloc.dart, _\_event.dart, _\_state.dart untuk BLoC.

### **Yang Tidak Boleh Dilakukan**

Jangan import presentation layer ke domain layer karena domain harus independent dari framework, jangan skip repository pattern dengan langsung call data source dari use case, jangan taruh business logic di widget melainkan di use case atau BLoC, jangan hardcode values seperti strings atau numbers melainkan gunakan constants, serta jangan ignore errors melainkan selalu handle dengan Either pattern dan Failure classes.

---

## 📖 Kesimpulan

Project **COACH Debate** dibangun dengan arsitektur yang solid menggunakan Clean Architecture dengan 3 layers (Presentation, Domain, Data) yang terpisah jelas, BLoC Pattern untuk state management yang predictable dan testable, Dependency Injection dengan GetIt untuk loose coupling, Repository Pattern untuk abstraksi data sources, Use Cases dengan single responsibility principle, Either Pattern untuk functional error handling yang type-safe, dan JSON Serialization otomatis untuk type-safe data parsing.

Arsitektur ini memastikan codebase yang testable dengan easy unit testing untuk business logic, maintainable dengan struktur yang jelas dan mudah dimodifikasi, scalable yang dapat bertumbuh dengan penambahan feature baru tanpa technical debt, serta readable dengan clear separation of concerns yang memudahkan developer baru memahami project.

---

**Terakhir Diperbarui**: 8 Desember 2025  
**Versi**: 1.0.0  
**Tim**: COACH Debate Development Team
