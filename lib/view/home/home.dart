import 'package:flutter/material.dart';
import 'package:mind_bend_doc/view/form/form_1.dart';
import '../../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          height: 50,
          color: Colors.black,
          alignment: Alignment.center,
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.lightBackgroundColor,
              overlayColor: Colors.yellow,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MOUform(),
                ),
              );
            },
            child: Text(
              'hi',
              style: TextStyle(
                color: AppTheme.lightBackgroundColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
