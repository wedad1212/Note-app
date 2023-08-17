import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  GetStorage _get = GetStorage();
  String _key = "isDarkMod";

  bool _loadTheme() => _get.read(_key) ?? false;

  ThemeMode get theme {
    return _loadTheme() ? ThemeMode.dark : ThemeMode.light;
  }

  _saveTheme(bool isTheme) => _get.write(_key, isTheme);

  void swichTheme(){
    Get.changeThemeMode(_loadTheme()?ThemeMode.light:ThemeMode.dark);
    _saveTheme(!_loadTheme());
  }
}
