import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _isFirstLaunchKey = 'is_first_launch';
  static const String _userTypeKey = 'user_type';

  static const String _adminEmail = 'admin@campusx.com';
  static const String _adminPassword = 'campusXadmin';

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isFirstLaunchKey) ?? true;
  }

  Future<void> setFirstLaunchComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isFirstLaunchKey, false);
  }

  Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userTypeKey);
  }

  Future<void> setUserType(String type) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userTypeKey, type);
  }

  Future<User?> loginAsAdmin(String email, String password) async {
    if (email.toLowerCase() != _adminEmail) {
      throw FirebaseAuthException(
        code: 'invalid-email',
        message: 'Only admin@campusx.com can login as admin',
      );
    }

    if (password != _adminPassword) {
      throw FirebaseAuthException(
        code: 'wrong-password',
        message: 'Invalid password',
      );
    }

    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await setUserType('admin');
      return credential.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> loginAsStudent() async {
    await setUserType('student');
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  bool isAdmin() {
    final user = _firebaseAuth.currentUser;
    return user?.email?.toLowerCase() == _adminEmail;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userTypeKey);
  }
}
