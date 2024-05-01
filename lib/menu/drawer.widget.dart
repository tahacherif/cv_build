import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/global.params.dart';
import 'package:cv_build/model/user.dart'; // Import the User model

class MyDrawer extends StatelessWidget {
  late SharedPreferences prefs;
  final User user; // Add user as a parameter to the constructor

  MyDrawer({required this.user}); // Constructor to receive user object

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFFA47676),Color(
                    0xFFD0B0B0)])
            ),
            child: Center(
              child: CircleAvatar(
                // Use the user's image here
                backgroundImage: AssetImage('images/' + user.image),
                radius: 80,
              ),
            ),
          ),
          ...(GlobalParams.menus as List).map((item){
            return Column(
              children: [
                ListTile(
                  title: Text('${item['title']}', style: TextStyle(fontSize: 15)),
                  leading: item['icon'],
                  trailing: Icon(Icons.arrow_right,color: Color(0xFFA47676),),
                  onTap: () async{
                    if('${item['title']}'!="Déconnexion"){
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "${item['route']}");
                    }
                    else
                    {prefs = await SharedPreferences.getInstance();
                    prefs.setBool("connecte", false);
                    Navigator.pushNamedAndRemoveUntil(context, '/authentification', (route) => false);
                    }
                  },
                ),
                Divider(height: 4,color: Color(0xFFA47676))
              ],
            );
          })
        ],
      ),
    );
  }
}
