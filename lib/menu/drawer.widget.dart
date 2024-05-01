import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cv_build/model/user.dart'; // Import the User model
import 'package:cv_build/main.dart';

class MyDrawer extends StatefulWidget {
  final User user;
  final bool isEnglishOn;

  MyDrawer({required this.user, required this.isEnglishOn}); // Update the constructor

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor:  isLightMode ? Colors.white : Colors.black,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors:  isLightMode ?  [Color(0xFFA47676), Color(0xFFD0B0B0)] : [Colors.black , Colors.white])
            ),
            child: Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('images/' + widget.user.image),
                radius: 80,
              ),
            ),
          ),
          ListTile(
            title: Text(widget.isEnglishOn ? "Acceuil" : "Home", style: TextStyle(fontSize: 15, color: isLightMode ? Colors.black : Colors.white)),
            leading: Icon(Icons.home, color:  isLightMode ? Color(0xFFA47676) : Colors.white),
            trailing: Icon(Icons.arrow_right, color:  isLightMode ?  Color(0xFFA47676) : Colors.white,),
            tileColor:  isLightMode ? Colors.white : Colors.black,

            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/home");
            },
          ),
          Divider(height: 4, color: Color(0xFFA47676)),
          ListTile(
            title: Text(widget.isEnglishOn ? "Formation Académique" : "Academic Formation", style: TextStyle(fontSize: 15, color: isLightMode ? Colors.black : Colors.white)),
            leading: Icon(Icons.school, color:  isLightMode ?  Color(0xFFA47676): Colors.white),
            trailing: Icon(Icons.arrow_right, color:  isLightMode ? Color(0xFFA47676) : Colors.white,),
            tileColor:  isLightMode ? Colors.white : Colors.black,

            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/formation");
            },
          ),
          Divider(height: 4, color: Color(0xFFA47676)),
          ListTile(
            title: Text(widget.isEnglishOn ? "Expérience Professionnelle" : "Professional Experience", style: TextStyle(fontSize: 15, color: isLightMode ? Colors.black : Colors.white)),
            leading: Icon(Icons.work, color:  isLightMode ?  Color(0xFFA47676): Colors.white),
            trailing: Icon(Icons.arrow_right, color:  isLightMode ? Color(0xFFA47676) : Colors.white,),
            tileColor:  isLightMode ? Colors.white : Colors.black,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/exp");
            },
          ),
          Divider(height: 4, color: Color(0xFFA47676)),
          ListTile(
            title: Text(widget.isEnglishOn ? "Compétences Techniques" : "Skills", style: TextStyle(fontSize: 15, color: isLightMode ? Colors.black : Colors.white)),
            leading: Icon(Icons.computer, color:  isLightMode ?  Color(0xFFA47676): Colors.white),
            trailing: Icon(Icons.arrow_right, color:  isLightMode ? Color(0xFFA47676) : Colors.white,),
            tileColor:  isLightMode ? Colors.white : Colors.black,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/skills");
            },
          ),
          Divider(height: 4, color: Color(0xFFA47676)),
          ListTile(
            title: Text(widget.isEnglishOn ? "Langue" : "Language", style: TextStyle(fontSize: 15, color: isLightMode ? Colors.black : Colors.white)),
            leading: Icon(Icons.language, color:  isLightMode ?  Color(0xFFA47676): Colors.white),
            trailing: Icon(Icons.arrow_right, color:  isLightMode ? Color(0xFFA47676) : Colors.white,),
            tileColor:  isLightMode ? Colors.white : Colors.black,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/langue");
            },
          ),
          Divider(height: 4, color: Color(0xFFA47676)),
          ListTile(
            title: Text(widget.isEnglishOn ? "Déconnexion" : "Logout", style: TextStyle(fontSize: 15, color: isLightMode ? Colors.black : Colors.white)),
            leading: Icon(Icons.exit_to_app, color:  isLightMode ?  Color(0xFFA47676): Colors.white),
            trailing: Icon(Icons.arrow_right, color:  isLightMode ? Color(0xFFA47676) : Colors.white,),
            tileColor:  isLightMode ? Colors.white : Colors.black,
            onTap: () async {
              prefs = await SharedPreferences.getInstance();
              prefs.setBool("connecte", false);
              Navigator.pushNamedAndRemoveUntil(context, '/authentification', (route) => false);
            },
          ),
          Divider(height: 4, color: Color(0xFFA47676)),
        ],
      ),
    );
  }

  void didUpdateWidget(MyDrawer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isEnglishOn != oldWidget.isEnglishOn) {
      setState(() {});
    }
  }
}
