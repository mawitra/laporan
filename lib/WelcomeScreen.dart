import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporan_masyarakat/regScreen.dart';
import 'loginScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: Text(
                'SPBA Wilayah Ambon',
                style: TextStyle(
                  fontSize: 30.sp,
                  color: Color.fromARGB(255, 4, 4, 4),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: SizedBox(
                width: 200.w,
                height: 200.h,
                child: Image(image: AssetImage('assets/Lambang_Ambon.png')),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Text(
                'Selamat datang Di aplikasi',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Color.fromARGB(255, 4, 4, 4),
                ),
              ),
            ),
            Text(
              'Pengaduan Masyarakat',
              style: TextStyle(
                fontSize: 20.sp,
                color: Color.fromARGB(255, 4, 4, 4),
              ),
            ),
            SizedBox(
              height: 70.h,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const loginScreen()),
                );
              },
              child: Container(
                height: 53.w,
                width: 320.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                child: Center(
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 2, 2, 2),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegScreen()),
                );
              },
              child: Container(
                height: 53.w,
                width: 320.w,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                child: Center(
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
