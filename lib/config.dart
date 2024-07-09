// ignore_for_file: prefer_const_declarations

import 'package:flutter/material.dart';

class ApiConfig {
  static final String baseUrl = "http://127.0.0.1:8000";
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
