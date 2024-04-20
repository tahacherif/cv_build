import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Page d'Accueil",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey[900],
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFD7ACAC),
      ),
      body: Container(
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
                        color: Color(0xFFD7ACAC),
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
                        color: Color(0xFFD7ACAC),
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
