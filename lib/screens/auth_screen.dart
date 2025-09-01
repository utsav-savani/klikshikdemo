import 'package:flutter/material.dart';
import 'package:klikshikdemo/screens/bottom_bar_screen.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../providers/auth_provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            if (authProvider.isLoading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.yellowE0A),
                    ),
                    // SizedBox(height: AppConstants.defaultPadding + 4),
                    // Text(
                    //   AppConstants.signingInText,
                    //   style: AppTextStyles.authSubtitle,
                    // ),
                  ],
                ),
              );
            }

            if (authProvider.isAuthenticated) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const BottomBarScreen(),
                  ),
                );
              });
              return const SizedBox.shrink();
            }

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.extraLargePadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const Icon(
                    //   Icons.photo_album,
                    //   size: AppConstants.logoSize,
                    //   color: AppColors.white,
                    // ),
                    // const SizedBox(height: AppConstants.defaultPadding + 4),
                    // const Text(
                    //   AppConstants.authScreenTitle,
                    //   style: AppTextStyles.authTitle,
                    // ),
                    // const SizedBox(height: AppConstants.smallPadding + 2),
                    // const Text(
                    //   AppConstants.appDescription,
                    //   style: AppTextStyles.authSubtitle,
                    // ),
                    // const SizedBox(height: AppConstants.extraLargePadding + 28),
                    _buildGoogleSignInButton(authProvider),
                    // if (authProvider.error != null) ...[
                    //   const SizedBox(height: AppConstants.defaultPadding + 4),
                    //   Text(
                    //     authProvider.error!,
                    //     style: const TextStyle(
                    //       color: AppColors.errorLight,
                    //       fontSize: 14,
                    //     ),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGoogleSignInButton(AuthProvider authProvider) {
    return ElevatedButton.icon(
      onPressed: () async {
        await authProvider.signInWithGoogle();
      },
      icon: Image.asset(
        AppConstants.googleLogoUrl,
        height: AppConstants.iconSizeMedium,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.login,
            size: AppConstants.iconSizeMedium,
          );
        },
      ),
      label: const Text(
        AppConstants.continueWithGoogleLabel,
        style: AppTextStyles.buttonText,
      ),
    );
  }
}