import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  bool get isDarkMode => _box.read(_key) ?? false;

  ThemeMode get theme => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void changeTheme(bool val) {
    _box.write(_key, val);
    Get.changeThemeMode(val ? ThemeMode.dark : ThemeMode.light);
    update();
  }

  void toggleTheme() {
    changeTheme(!isDarkMode);
  }
}
