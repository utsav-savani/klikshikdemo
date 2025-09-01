import 'package:flutter/material.dart';
import 'package:klikshikdemo/providers/auth_provider.dart';
import 'package:klikshikdemo/screens/auth_screen.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../core/constants/app_constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _handleSignOut(context),
            tooltip: AppConstants.signOutLabel,
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Coming Soon',
          style: AppTextStyles.eventTitle?.copyWith(
            fontSize: 28,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  void _handleSignOut(BuildContext context) {
    context.read<AuthProvider>().signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const AuthScreen(),
      ),
    );
  }
}