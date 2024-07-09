import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporan_masyarakat/config.dart';
import 'package:laporan_masyarakat/dashboard/dashboard.dart';

// ignore: camel_case_types
class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

// ignore: camel_case_types
class _loginScreenState extends State<loginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool buttonClicked = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> handleLogin() async {
    setState(() {
      isLoading = true;
    });
    try {
      final loginUrl = Uri.parse('${ApiConfig.baseUrl}/api/logins');

      final loginResponse = await http.post(
        loginUrl,
        body: json.encode({
          'fullname': usernameController.text,
          'password': passwordController.text,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (loginResponse.statusCode == 200) {
        final responseBody = json.decode(loginResponse.body);
        if (responseBody['status'] == 'success') {
          final userData = responseBody['data'];

          // Handle successful login and navigate to the desired screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Selamat Datang ${userData['fullname']}'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal masuk: ${responseBody['message']}'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else if (loginResponse.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SizedBox(
              height: 15.h,
              child: Center(
                child: Text(
                  'Login gagal, Periksa No Hp & password anda',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal masuk: ${loginResponse.body}'),
            duration: Duration(seconds: 2),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error during login: $e");

      // if (e is SocketException) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: SizedBox(
      //         height: 15.h,
      //         child: Center(
      //           child: Text(
      //             'Kesalahan jaringan, Periksa koneksi internet Anda.',
      //             textAlign: TextAlign.center,
      //             style: TextStyle(
      //               fontSize: 13.sp,
      //             ),
      //           ),
      //         ),
      //       ),
      //       duration: Duration(seconds: 2),
      //       behavior: SnackBarBehavior.floating,
      //     ),
      //   );
      // } else if (e is TimeoutException) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: SizedBox(
      //         height: 15.h,
      //         child: Center(
      //           child: Text(
      //             'Gagal Menghubungkan ke server. Silakan coba lagi.',
      //             textAlign: TextAlign.center,
      //             style: TextStyle(
      //               fontSize: 13.sp,
      //             ),
      //           ),
      //         ),
      //       ),
      //       duration: Duration(seconds: 2),
      //       behavior: SnackBarBehavior.floating,
      //     ),
      //   );
      // }

      setState(() {
        isLoading = false;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColor.strokeColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 50.h),
                    child: Image(
                      width: 150.w,
                      height: 150.w,
                      image: const AssetImage(
                        'assets/Lapor.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Expanded(
                    child: Container(
                      width: 360.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Login",
                                      style: TextStyle(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25.sp,
                                      ),
                                    ),
                                    const Text(
                                      "Silakan masuk dengan akun Anda",
                                      style: TextStyle(
                                        color: AppColor.sekunderColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Expanded(
                              child: Stack(
                                children: [
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        TextInput(
                                          controller: usernameController,
                                          placeholder: "Masukan username",
                                          validasi: buttonClicked &&
                                                  usernameController
                                                      .text.isEmpty
                                              ? "* username tidak boleh kosong"
                                              : "",
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        InputPassword(
                                          controller: passwordController,
                                          sandi: "Masukan Kata Sandi",
                                          validasi: buttonClicked &&
                                                  passwordController
                                                      .text.isEmpty
                                              ? "* Kata sandi tidak boleh kosong"
                                              : "",
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColor.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColor.primaryColor
                                                    .withOpacity(0.2),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: const Offset(0, 5),
                                              ),
                                            ],
                                          ),
                                          width: double.infinity,
                                          height: 40.h,
                                          child: TextButton(
                                            onPressed: isLoading
                                                ? null
                                                : () {
                                                    setState(() {
                                                      buttonClicked = true;
                                                    });

                                                    if (usernameController
                                                            .text.isEmpty ||
                                                        passwordController
                                                            .text.isEmpty) {
                                                      setState(() {
                                                        isLoading = true;
                                                      });
                                                      return;
                                                    }

                                                    handleLogin();
                                                  },
                                            child: isLoading
                                                ? SizedBox(
                                                    width: 20.w,
                                                    height: 20.w,
                                                    child:
                                                        const CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(
                                                        Colors.white,
                                                      ),
                                                    ),
                                                  )
                                                : Text(
                                                    "Login",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                  AnimatedPositioned(
                                    duration: const Duration(milliseconds: 1),
                                    curve: Curves.easeInOut,
                                    bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom +
                                        12,
                                    right: 4.w,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: Text(
                                        "Laporan-masyarakat. 2024 V1.0",
                                        style: TextStyle(
                                          color: AppColor.primaryColor,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InputPassword extends StatefulWidget {
  const InputPassword({
    Key? key,
    required this.controller,
    required this.sandi,
    required this.validasi,
  }) : super(key: key);

  final TextEditingController controller;
  final String sandi;
  final String validasi;

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  var obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              cursorColor: AppColor.primaryColor,
              style: const TextStyle(
                color: AppColor.primaryColor,
              ),
              obscureText: obscureText,
              controller: widget.controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.lock,
                  color: AppColor.primaryColor,
                  size: 20,
                ),
                hintText: widget.sandi,
                hintStyle: const TextStyle(
                  color: AppColor.hintColor,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: obscureText
                      ? const Icon(Icons.visibility_off,
                          color: AppColor.primaryColor)
                      : const Icon(Icons.visibility, color: AppColor.hintColor),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColor.strokeColor,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
            ),
            if (widget.validasi.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  widget.validasi,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.sp,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class TextInput extends StatefulWidget {
  const TextInput({
    super.key,
    required this.placeholder,
    required this.validasi,
    required this.controller,
  });

  final TextEditingController controller;
  final String placeholder;
  final String validasi;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  String? inputValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: TextFormField(
                controller: widget.controller,
                cursorColor: AppColor.primaryColor,
                autocorrect: false,
                style: const TextStyle(color: AppColor.primaryColor),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.account_circle,
                    color: AppColor.primaryColor,
                    size: 20.sp,
                  ),
                  hintText: widget.placeholder,
                  hintStyle: const TextStyle(
                    color: AppColor.hintColor,
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.strokeColor,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    inputValue = value;
                  });
                },
              ),
            ),
            if (widget.validasi.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  widget.validasi,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.sp,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}