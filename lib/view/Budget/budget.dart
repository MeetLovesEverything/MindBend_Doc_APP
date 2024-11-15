import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Docs',
          style: TextStyle(
            color: AppTheme.lightBackgroundColor,
          ),
        ),
      ),
      body: Placeholder(),
    );
  }
}


