import 'package:flutter/material.dart';

import 'data/auth_service.dart';
import 'features/auth/login_screen.dart';
import 'theme/luma_theme.dart';

class LumaVaultApp extends StatelessWidget {
  const LumaVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LumaVault',
      theme: LumaTheme.dark(),
      home: LoginScreen(authService: AuthService()),
    );
  }
}
