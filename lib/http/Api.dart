class Api {
  // ---------------- BASE URL ------------------
  static const _baseUrl = 'http://45.149.77.156:';
//-------------- API INSTANCE -----------------
  static final Api _instance = Api._();
// ----------------- getter --------------------
  static Api get instance => _instance;
  String get baseUrl => _baseUrl;
  Api._();
}
