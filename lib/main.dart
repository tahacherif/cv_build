import 'package:flutter/material.dart';
import 'package:cv_build/cv.page.dart';
import 'package:cv_build/home.page.dart';
import 'package:cv_build/data/user_data_source.dart';
import 'package:cv_build/model/user.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late User user;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    // For demonstration purposes, let's assume we want the first user in the list by default
    user = UserDataSource.users.isNotEmpty ? UserDataSource.users[0] : User.empty();
    setState(() {}); // Update the state to rebuild the UI with fetched data
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(), // Default light mode theme
      darkTheme: ThemeData.dark(), // Dark mode theme
      themeMode: ThemeMode.system, // Set to system to follow system settings, you can change it to ThemeMode.light or ThemeMode.dark
      routes: {
        '/cvPage': (context) => CvPage(), // Pass the user to CvPage
        '/home': (context) => HomePage(),
      },
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}