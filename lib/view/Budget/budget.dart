import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  final String googleSheetUrl =
      'https://docs.google.com/spreadsheets/d/191GfnePZxog_LQM1aNHMdjCq8c5rBWFyFpeSNBjYAMw/edit?usp=sharing';

  void _openGoogleSheet(BuildContext context) async {
    final Uri url = Uri.parse(googleSheetUrl);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url,
          mode: LaunchMode.externalApplication,
          // Add this to handle potential errors
          webViewConfiguration: const WebViewConfiguration(
            enableDomStorage: true,
            enableJavaScript: true,
          ),
        );
      } else {
        _showErrorSnackBar(context, 'Could not launch the URL');
      }
    } catch (e) {
      _showErrorSnackBar(context, 'An error occurred: ${e.toString()}');
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _openGoogleSheet(context),
          child: const Text('Open Google Sheet'),
        ),
      ),
    );
  }
}