import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'package:note/services/theme_services.dart';
import 'package:note/ui/pages/home_page.dart';
import 'package:note/ui/theme.dart';

import 'db/db_helper.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await DBHelper.initDb();
 await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: Themes.light,
      darkTheme:Themes.dark ,
      themeMode: ThemeServices().theme,
      debugShowCheckedModeBanner: false,
      home:  HomePage(),
    );
  }
}
