import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CvPage extends StatefulWidget {
  @override
  _CvPageState createState() => _CvPageState();
}

class _CvPageState extends State<CvPage> {
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {}); // Update the state to rebuild the UI with fetched data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(8),
          child: ElevatedButton(
            onPressed: () {},
            child: Text(prefs.getString("user") ?? "User"), // Show "User" if prefs.getString("user") is null
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
              backgroundColor: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}