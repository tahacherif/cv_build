import 'package:flutter/material.dart';
import '../menu/drawer.widget.dart';
import 'package:cv_build/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cv_build/data/user_data_source.dart'; // Import UserDataSource

class ExpPage extends StatefulWidget {
  @override
  _ExpPageState createState() => _ExpPageState();
}

class _ExpPageState extends State<ExpPage> {
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
          "Professional Experience",
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
          children: _buildExperienceItems(_user.experiences),
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  List<Widget> _buildExperienceItems(List<Experience> experiences) {
    return experiences.map((experience) {
      return _buildExperienceItem(experience);
    }).toList();
  }

  Widget _buildExperienceItem(Experience exp) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // Background color of the container
        borderRadius: BorderRadius.circular(10.0), // Rounded corners of the container
      ),
      margin: EdgeInsets.only(bottom: 16.0), // Bottom margin for spacing between items
      padding: EdgeInsets.all(16.0), // Internal padding of the container
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              exp.position,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(exp.company),
            leading: Icon(Icons.work),
          ),
          SizedBox(height: 8.0),
          Text(
            'Start Date: ${exp.startDate}',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 4.0),
          Text(
            'End Date: ${exp.endDate}',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 8.0),
          Text(
            exp.description,
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
