import 'package:flutter/material.dart';
import 'package:untitled2/login_Page.dart';

import 'SpleshPage.dart';
import 'homePage.dart';

void main() {
  runApp(const Abc());
}

class Abc extends StatefulWidget {
  const Abc({super.key});

  @override
  State<Abc> createState() => _AbcState();
}

class _AbcState extends State<Abc> {




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen()
    );
  }
}
