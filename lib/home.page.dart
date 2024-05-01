import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class HomePage extends StatelessWidget {
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEnglishOn ? "Page d'Accueil" : "Home page",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isLightMode ? Colors.grey[900] : Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: isLightMode ?Color(0xFFD7ACAC)  : Colors.black,
      ),
      body: Container(
        color: isLightMode ? Colors.white : Colors.grey[800],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  _User(context, 'Mohamed Taha Cherif');
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 90,
                      backgroundImage: AssetImage('images/taha.jpg'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Mohamed Taha Cherif',
                      style: TextStyle(
                        color: isLightMode ? Color(0xFFD7ACAC) : Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              InkWell(
                onTap: () {
                  _User(context, 'Taieb Daoud');
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 90,
                      backgroundImage: AssetImage('images/taieb.jpg'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Taieb Daoud',
                      style: TextStyle(
                        color: isLightMode ? Color(0xFFD7ACAC) : Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _User(BuildContext context, String userName) async {
    prefs = await SharedPreferences.getInstance();

    if (userName == 'Mohamed Taha Cherif') {
      prefs.setString("user", "Mohamed Taha Cherif");
      Navigator.pop(context);
      Navigator.pushNamed(context, '/cvPage');
    } else if (userName == 'Taieb Daoud') {
      prefs.setString("user", "Taieb Daoud");
      Navigator.pop(context);
      Navigator.pushNamed(context, '/cvPage');
    }
  }
}
