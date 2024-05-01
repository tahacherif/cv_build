import 'package:flutter/material.dart';
import '../menu/drawer.widget.dart';
import 'package:cv_build/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cv_build/data/user_data_source.dart'; // Import UserDataSource

class SkillsPage extends StatefulWidget {
  @override
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
   late User _user;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userName = prefs.getString("user");
      if (userName != null) {
        User user = await UserDataSource.getUserByName(userName);
        setState(() {
          _user = user;
        });
      } else {
        throw Exception('No user found in SharedPreferences');
      }
    } catch (e) {
      // Handle exception
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Technical Skills",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey[900],
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFD7ACAC),
      ),
      body: _user != null
          ? SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildSkillItems(_user.skills),
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  List<Widget> _buildSkillItems(List<String> skills) {
    return skills.map((skill) {
      return _buildSkillItem(skill);
    }).toList();
  }

  Widget _buildSkillItem(String skill) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // Background color of the container
        borderRadius: BorderRadius.circular(10.0), // Rounded corners of the container
      ),
      margin: EdgeInsets.only(bottom: 16.0), // Bottom margin for spacing between items
      padding: EdgeInsets.all(16.0), // Internal padding of the container
      child: ListTile(
        title: Text(skill),
        leading: Icon(Icons.code),
        onTap: () {
          // Add logic to handle tap if needed
        },
      ),
    );
  }
}
