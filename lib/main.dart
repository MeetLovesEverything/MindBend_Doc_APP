import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mind_bend_doc/routes/app_page.dart';
import 'package:mind_bend_doc/routes/app_route.dart';
import 'package:mind_bend_doc/theme/app_theme.dart';

import 'Model/budget_model.dart';
import 'api/gsheets_api.dart';


void main() async{
  await GsheetsApi.init();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      getPages: AppPage.list,
      initialRoute: AppRoute.dashboard,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
    );
  }
}