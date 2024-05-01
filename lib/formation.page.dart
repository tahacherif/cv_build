import 'package:flutter/material.dart';
import '../menu/drawer.widget.dart';
import 'package:cv_build/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cv_build/data/user_data_source.dart'; // Import UserDataSource

class FormationPage extends StatefulWidget {
  @override
  _FormationPageState createState() => _FormationPageState();
}

class _FormationPageState extends State<FormationPage> {
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
          "Academic Formation",
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
          children: _buildEducationItems(_user.educations),
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  List<Widget> _buildEducationItems(List<Education> educations) {
    return educations.map((education) {
      return _buildEducationItem(education);
    }).toList();
  }
  Widget _buildEducationItem(Education e) {
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
              e.degree,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(e.institution),
            leading: Icon(Icons.school),
          ),
          SizedBox(height: 8.0),
          Text(
            'Start Date: ${e.startDate}',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 4.0),
          Text(
            'End Date: ${e.endDate}',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 8.0),
          Text(
            e.description,
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }

}
