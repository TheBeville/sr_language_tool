import 'package:flutter/material.dart';
import 'package:sr_language_tool/constants.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                fixedSize: Size(150, 42),
              ),
              onPressed: () {},
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
            const SizedBox(height: 20),
            const Text('Settings Page - Coming Soon!'),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
