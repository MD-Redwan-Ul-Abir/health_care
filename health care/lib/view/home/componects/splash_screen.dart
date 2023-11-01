import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:patient_health_care/view/home/Home.dart';
import 'package:patient_health_care/view/registration/log_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Box _boxLogin = Hive.box("login");

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () {
      if (_boxLogin.get('token') != null) {
        Get.offAll(() => const Homepage());
      } else {
        Get.offAll(() => const Login());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: const Center(
            child: Text('Welcome',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ))),
      ),
    );
  }
}
