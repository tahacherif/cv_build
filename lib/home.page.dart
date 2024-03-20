import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  late SharedPreferences prefs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home Page"), backgroundColor: Colors.green,),
        body: Column(
          children: [
            Center(
              child: Wrap(
                children: [
                  InkWell(
                    child: Ink.image(
                      height: 180,
                      width: 180,
                      image: AssetImage('images/taha.jpg'),
                    ),
                    onTap: () {
                      _User(context, 'Taha'); // Pass 'Taha' as a parameter
                    },
                  ),

                  InkWell(
                    child: Ink.image(
                      height: 180,
                      width: 180,
                      image: AssetImage('images/taha.jpg'),
                    ),
                    onTap: () {
                      _User(context, 'Taieb'); // Pass 'OtherUser' as a parameter
                    },
                  ),

                ],
              ),),
            TextButton(onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/authentification');
            }, child: Text("J'ai deja un compte"))
          ],
        )
    );
  }

  Future<void> _User(BuildContext context, String userName) async {
    prefs = await SharedPreferences.getInstance();

    if (userName == 'Taha') {
      prefs.setString("user", "Taha");
      Navigator.pop(context);
      Navigator.pushNamed(context, '/cvPage');
    } else
    if (userName == 'Taieb') {
      prefs.setString("user","Taieb");
      Navigator.pop(context);
      Navigator.pushNamed(context, '/cvPage');
    } else {
      const snackBar = SnackBar(
        content: Text('Id or Password is invalid'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}