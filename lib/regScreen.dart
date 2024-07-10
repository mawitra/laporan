// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporan_masyarakat/config.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({super.key});

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool buttonClicked = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> register() async {
    setState(() {
      isLoading = true;
    });
    try {
      final registerUrl = Uri.parse('${ApiConfig.baseUrl}/api/registers');

      final registerResponse = await http.post(
        registerUrl,
        body: json.encode({
          'fullname': fullnameController.text,
          'name': usernameController.text,
          'email': emailController.text,
          'password': passwordController.text,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final responseBodyString =
          registerResponse.body.replaceAll(RegExp(r'<!--|-->'), '');
      final responseBody = json.decode(responseBodyString);

      if (registerResponse.statusCode == 200 &&
          responseBody['status'] == 'success') {
        // Handle successful registration
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Registration successful! Welcome ${responseBody['data']['fullname']}'),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        // Handle registration failure with error messages
        String errorMessage = '';
        if (responseBody['errors'] != null) {
          responseBody['errors'].forEach((key, value) {
            errorMessage += '${value.join(', ')}\n';
          });
        }
        String message = responseBody['message'] ?? 'Registration failed';

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Row(
              children: [
                Icon(Icons.cancel, color: Colors.orange, size: 35.sp),
                SizedBox(height: 8.w),
                Text(
                  message,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: Text(
              errorMessage,
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Oke',
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
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
                    padding: EdgeInsets.only(top: 40.h),
                    child: Image(
                      width: 150.w,
                      height: 150.w,
                      image: const AssetImage(
                        'assets/Lapor.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
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
                                      "Register",
                                      style: TextStyle(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25.sp,
                                      ),
                                    ),
                                    Text(
                                      "Belum memiliki akun ? daftar terlebih dahulu!",
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
                                          controller: emailController,
                                          placeholder: "Masukan Email",
                                          validasi: buttonClicked &&
                                                  emailController.text.isEmpty
                                              ? "* Email tidak boleh kosong"
                                              : "",
                                          icon: Icons.email,
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        TextInput(
                                          controller: fullnameController,
                                          placeholder: "Nama Lengkap",
                                          validasi: buttonClicked &&
                                                  fullnameController
                                                      .text.isEmpty
                                              ? "* Nama Lengkap tidak boleh kosong"
                                              : "",
                                          icon: Icons.person,
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        TextInput(
                                          controller: usernameController,
                                          placeholder: "Masukan Username",
                                          validasi: buttonClicked &&
                                                  usernameController
                                                      .text.isEmpty
                                              ? "* username tidak boleh kosong"
                                              : "",
                                          icon: Icons.person_pin,
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
                                                offset: Offset(0, 5),
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
                                                        isLoading = false;
                                                      });
                                                      return;
                                                    }

                                                    register();
                                                  },
                                            child: isLoading
                                                ? SizedBox(
                                                    width: 20.w,
                                                    height: 20.w,
                                                    child:
                                                        CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(
                                                        Colors.white,
                                                      ),
                                                    ),
                                                  )
                                                : Text(
                                                    "Daftar",
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
                                    duration: Duration(milliseconds: 1),
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
              style: TextStyle(
                color: AppColor.primaryColor,
              ),
              obscureText: obscureText,
              controller: widget.controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: AppColor.primaryColor,
                  size: 20,
                ),
                hintText: widget.sandi,
                hintStyle: TextStyle(
                  color: AppColor.hintColor,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: obscureText
                      ? Icon(Icons.visibility_off, color: AppColor.primaryColor)
                      : Icon(Icons.visibility, color: AppColor.hintColor),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColor.strokeColor,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
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
    required this.icon,
  });

  final TextEditingController controller;
  final String placeholder;
  final String validasi;
  final IconData icon;

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
                style: TextStyle(color: AppColor.primaryColor),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    widget.icon,
                    color: AppColor.primaryColor,
                    size: 20.sp,
                  ),
                  hintText: widget.placeholder,
                  hintStyle: TextStyle(
                    color: AppColor.hintColor,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.strokeColor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
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
