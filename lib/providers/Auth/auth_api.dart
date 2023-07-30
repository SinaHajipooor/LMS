import 'package:lms/http/api.dart';

class AuthApi {
  // ---------------- BASE URL ------------------
  static final _baseUrl = '${Api.instance.baseUrl}8081/api';
//-------------- API INSTANCE -----------------
  static final AuthApi _instance = AuthApi._();
//----------------- Auth ---------------------
  static final _userPassLogin = '$_baseUrl/auth/base/login';
  static final _mobileLogin = '$_baseUrl/auth/otp/login';
  static final _mobileConfirm = '$_baseUrl/auth/otp/confirm';
  static final _logout = '$_baseUrl/auth/base/logout';
// ----------------- getter --------------------
  static AuthApi get instance => _instance;
  String get baseUrl => _baseUrl;
  String get userPassLoginUrl => _userPassLogin;
  String get mobileLoginUrl => _mobileLogin;
  String get mobileConfirmUrl => _mobileConfirm;
  String get logoutUrl => _logout;
  AuthApi._();
}
