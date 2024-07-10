// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, unused_import, non_constant_identifier_names, prefer_const_constructors_in_immutables, prefer_const_declarations, unnecessary_null_comparison, avoid_print, avoid_unnecessary_containers, use_build_context_synchronously, unused_local_variable, unused_field, deprecated_member_use, sized_box_for_whitespace

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporan_masyarakat/config.dart';
import 'package:laporan_masyarakat/loginScreen.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String fullname = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await StorageUtil.getUserData();
    if (userData != null && userData.containsKey('fullname')) {
      setState(() {
        fullname = userData['fullname'];
      });
    }
  }

  @override
  void dispose() {
    // _isMounted = false;
    super.dispose();
  }

  bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  final Stream<DateTime> _clockStream = Stream.periodic(
    Duration(seconds: 1),
    (_) => DateTime.now(),
  );

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi'),
        content: Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Tidak',
              style: TextStyle(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Ya',
              style: TextStyle(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    return WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            backgroundColor: AppColor.primaryColor,
            elevation: 0,
            title: Text(
              'Hai, $fullname',
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.logout, color: Colors.white),
                onPressed: () async {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => loginScreen()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
          // drawer: CustomDrawer(
          //   onIndexSelected: (int index) {
          //     setState(() {
          //       index_color = index;
          //     });
          //   },
          // ),
          body: SafeArea(
            child: Stack(
              children: [
                ClipPath(
                  // clipper: ClipPathClass(),
                  child: Container(
                    height: 160.h,
                    color: AppColor.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
