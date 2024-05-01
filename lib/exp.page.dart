import 'package:flutter/material.dart';
import '../menu/drawer.widget.dart';
import 'package:cv_build/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cv_build/data/user_data_source.dart';

import 'main.dart'; // Import UserDataSource

class ExpPage extends StatefulWidget {
  @override
  _ExpPageState createState() => _ExpPageState();
}

class _ExpPageState extends State<ExpPage> {
  late User _user;
  bool _isLoading = true;
  String _errorMessage = '';

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
          _isLoading = false;
        });
      } else {
        throw Exception('No user found in SharedPreferences');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load user data: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEnglishOn ? "Experiance Professionelle" : "Professional Experience",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isLightMode ? Colors.grey[900] : Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: isLightMode ? Color(0xFFD7ACAC) : Colors.black,
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : _errorMessage.isNotEmpty
          ? Center(
        child: Text(
          _errorMessage,
          style: TextStyle(color: Colors.red),
        ),
      )
          : SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildExperienceItems(_user.experiences),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: isLightMode ? Colors.white : Colors.black,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamed(context, '/formation');
              },
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Icon(
                Icons.home,
                size: 30, // Taille du logo
                color: isLightMode ? Color(0xFFD7ACAC) : Colors.white, // Couleur du logo
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.pushNamed(context, '/skills');
              },
            ),
          ],
        ),
      ),
      backgroundColor: isLightMode ? Colors.white : Colors.black, // Set background color based on mode
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
