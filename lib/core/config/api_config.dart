class ApiConfig {
  /// ==================
  /// API untuk Groq LLM
  /// ==================
  static const String _urlGroqAPI =
      "https://django-backend-debate-app.vercel.app";
  static String get chatEndpoint => "$_urlGroqAPI/api/chat/";
  static String get topicsEndpoint => "$_urlGroqAPI/api/topics/";

  /// ================
  /// API Keys NewsAPI
  /// ================
  static const String APIKEY = "417ec91627b4457ba4d2a1aa7433f968";

  /// ================
  /// Base URL NewsAPI
  /// ================
  static const String _urlNewsAPI = "https://newsapi.org/v2";
  static String get topicsNewsEndpoint => "$_urlNewsAPI/everything?";

  /// ===========================
  /// Methode untuk membuat panggilan
  /// API lengkap ke API Public 'https://newsapi.org/'
  /// ===========================
  ///
  /// [q] = kata kunci pencarian berita
  /// [from  = tanggal mulai pencarian berita (format: YYYY-MM-DD)
  /// [to] = tanggal akhir pencarian berita (format: YYYY-MM-DD)
  /// [language] = filter berdasarkan bahasa (contoh: 'en' untuk bahasa Inggris, 'id' untuk bahasa Indonesia)

  static String getNewsAPIurl({
    String? q,
    String? from,
    String? to,
    String language = "id",
    int pageSize = 10,
    int page = 1,
  }) {
    final uri = Uri.parse(topicsNewsEndpoint).replace(
      queryParameters: {
        'q': q,
        'from': from,
        'to': to,
        'language': language,
        'pageSize': pageSize.toString(),
        'page': page.toString(),
        'apiKey': APIKEY,
      }..removeWhere((key, value) => value == null),
    );
    return uri.toString();
  }
}
