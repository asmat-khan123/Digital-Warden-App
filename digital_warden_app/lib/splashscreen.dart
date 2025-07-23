import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Homepage.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/splashscreenjpg.jpg',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _checkLoginState()  {
   Timer(Duration(seconds: 3),() async{
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

     if (isLoggedIn) {
       final String? name = prefs.getString('name');
       final String? post = prefs.getString('post');
       final String? district = prefs.getString('district');

       if (name != null && post != null && district != null) {
         Navigator.pushReplacement(
           context,
           MaterialPageRoute(
             builder: (context) => Homepage(
               name: name,
               post: post,
               district: district,
             ),
           ),
         );
       } else {
         // Clear invalid data and redirect to login
         await prefs.clear();
         _redirectToLogin();
       }
     } else {
       _redirectToLogin();
     }
   },) ;

  }

  void _redirectToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MyHomePage(title: 'Flutter Login'),
      ),
    );
  }
}
