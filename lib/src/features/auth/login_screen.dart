import 'package:flutter/material.dart';

import '../../data/auth_service.dart';
import '../shell/luma_shell.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.authService});

  final AuthService authService;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController(text: 'denis@lumavault.app');
  final _password = TextEditingController(text: 'portfolio');
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final session = await widget.authService.signIn(email: _email.text.trim(), password: _password.text);
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LumaShell(authService: widget.authService, session: session)),
      );
    } on AuthException catch (error) {
      setState(() => _error = error.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Container(
                      width: 82,
                      height: 82,
                      decoration: BoxDecoration(
                        color: const Color(0xFF22E0B8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.auto_awesome, color: Color(0xFF071318), size: 42),
                    ),
                    const SizedBox(height: 28),
                    const Text('LumaVault', style: TextStyle(fontSize: 44, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 12),
                    const Text(
                      'Финансовая панель с live-курсами, риск-скорингом операций и персональным бюджетом.',
                      style: TextStyle(fontSize: 16, height: 1.45, color: Color(0xFFC3D8DB)),
                    ),
                    const SizedBox(height: 28),
                    TextField(controller: _email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(prefixIcon: Icon(Icons.mail_outline), labelText: 'Email')),
                    const SizedBox(height: 12),
                    TextField(controller: _password, obscureText: true, decoration: const InputDecoration(prefixIcon: Icon(Icons.lock_outline), labelText: 'Пароль')),
                    if (_error != null) ...[
                      const SizedBox(height: 12),
                      Text(_error!, style: const TextStyle(color: Color(0xFFFFC857), fontWeight: FontWeight.w700)),
                    ],
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: FilledButton.icon(
                        onPressed: _loading ? null : _signIn,
                        icon: _loading ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.login),
                        label: Text(_loading ? 'Проверяем доступ' : 'Войти'),
                      ),
                    ),
                    const SizedBox(height: 28),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
