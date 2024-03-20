import 'package:cv_build/home.page.dart';
import 'package:flutter/material.dart';
import 'package:cv_build/cv.page.dart';


void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  final route= {
    '/cvPage':(context)=> CvPage(),
    '/home':(context)=> HomePage(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: route,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
