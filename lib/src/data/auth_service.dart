class AuthSession {
  const AuthSession({required this.userName, required this.email, required this.token});

  final String userName;
  final String email;
  final String token;
}

class AuthService {
  AuthSession? _session;

  AuthSession? get session => _session;
  bool get isSignedIn => _session != null;

  Future<AuthSession> signIn({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!email.contains('@')) {
      throw const AuthException('Введите корректный email.');
    }
    if (password.length < 6) {
      throw const AuthException('Пароль должен быть не короче 6 символов.');
    }
    _session = AuthSession(
      userName: 'Денис',
      email: email,
      token: 'luma_${DateTime.now().millisecondsSinceEpoch}',
    );
    return _session!;
  }

  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 180));
    _session = null;
  }
}

class AuthException implements Exception {
  const AuthException(this.message);

  final String message;
}
