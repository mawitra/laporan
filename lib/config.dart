// ignore_for_file: prefer_const_declarations

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:laporan_masyarakat/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiConfig {
  static final String baseUrl = "http://192.168.1.175:80";
}

class GreetingUtil {
  static String getGreetingMessage() {
    final currentTime = DateTime.now().hour;

    if (currentTime >= 0 && currentTime < 12) {
      return 'Selamat Pagi';
    } else if (currentTime >= 12 && currentTime < 14) {
      return 'Selamat Siang';
    } else if (currentTime >= 14 && currentTime < 18) {
      return 'Selamat Sore';
    } else if (currentTime >= 18 && currentTime < 24) {
      return 'Selamat Malam';
    }

    return 'Selamat';
  }
}

class AppColor {
  static const Color primaryColor = Color.fromARGB(246, 255, 0, 0);
  static const Color basicColor = Color.fromARGB(246, 0, 255, 38);
  static const Color secondColor = Color(0xff495057);
  static const Color sekunderColor = Color(0xff777777);
  static const Color borderColor = Color(0xffF0F0F0);
  static const Color textColor = Color(0xffAAAAAA);
  static const Color strokeColor = Color(0xffF0F0F0);
  static const Color hintColor = Color(0xffBEBEBE);
}

class AppColorLapor {
  static const Color primaryColor = Color(0xF6E88220);
  static const Color secondColor = Color(0xff495057);
  static const Color sekunderColor = Color(0xff777777);
  static const Color borderColor = Color(0xffF0F0F0);
  static const Color textColor = Color(0xffAAAAAA);
  static const Color strokeColor = Color(0xffF0F0F0);
  static const Color hintColor = Color(0xffBEBEBE);
}

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel? user) {
    _user = user;
    notifyListeners();
  }
}

class StorageUtil {
  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', json.encode(userData));
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString('user_data');
    if (userDataString != null) {
      return json.decode(userDataString);
    }
    return null;
  }
}
