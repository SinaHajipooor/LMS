class AuthApi {
  // ---------------- BASE URL ------------------
  static const _baseUrl = 'http://45.149.77.156:8081/api';
//-------------- API INSTANCE -----------------
  static final AuthApi _instance = AuthApi._();
//----------------- Auth ---------------------
  static const _userPassLogin = '$_baseUrl/auth/base/login';
  static const _mobileLogin = '$_baseUrl/auth/otp/login';
  static const _mobileConfirm = '$_baseUrl/auth/otp/confirm';
  static const _logout = '$_baseUrl/auth/base/logout';
// ----------------- getter --------------------
  static AuthApi get instance => _instance;
  String get baseUrl => _baseUrl;
  String get userPassLoginUrl => _userPassLogin;
  String get mobileLoginUrl => _mobileLogin;
  String get mobileConfirmUrl => _mobileConfirm;
  String get logoutUrl => _logout;
  AuthApi._();
}
