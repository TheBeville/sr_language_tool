import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sr_language_tool/constants.dart';
import 'package:sr_language_tool/pages/auth_page.dart';
import 'package:sr_language_tool/services/auth_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SETTINGS',
          style: appBarTitleStyling,
        ),
      ),
      body: Center(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state is AuthAuthenticated) ...[
                  Text(
                    state.user.email ?? '',
                    style: const TextStyle(fontSize: 16),
                  ),
                  if (state.user.userMetadata?['username'] != null)
                    Text(
                      state.user.userMetadata!['username'] as String,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => context.read<AuthCubit>().signOut(),
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ] else if (state is AuthLoading) ...[
                  const CircularProgressIndicator(),
                ] else ...[
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.blue.shade400,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      fixedSize: const Size(150, 42),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AuthPage(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_upload,
                          color: Colors.blue.shade400,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Cloud Sync',
                          style: TextStyle(
                            color: Colors.blue.shade400,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Sign in to enable cloud sync',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
                const SizedBox(height: 20),
                const Text('Settings Page - Coming Soon!'),
              ],
            );
          },
        ),
      ),
    );
  }
}
