import 'package:flutter/material.dart';
import 'package:cv_build/data/user_data_source.dart'; // Import UserDataSource
import 'package:cv_build/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CvPage extends StatelessWidget {
  CvPage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Display a loading indicator while fetching user data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Display an error message if data fetching fails
        } else {
          User user = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text("Resume Page"),
              backgroundColor: Colors.green,
              leading: TextButton(
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.remove("user");
                  Navigator.pop(context); // Pop the current page
                  Navigator.of(context).pushNamed('/home'); // Navigate to the home page
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    user.title,
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Email: ${user.email}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Phone: ${user.phone}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Address: ${user.address}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Summary: ${user.summary}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Skills: ${user.skills.join(', ')}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Experiences:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: user.experiences.map((exp) => Text(
                      '- ${exp.position} at ${exp.company}: ${exp.startDate} - ${exp.endDate}\n${exp.description}',
                      style: TextStyle(fontSize: 16),
                    )).toList(),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Educations:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: user.educations.map((edu) => Text(
                      '- ${edu.degree} at ${edu.institution}: ${edu.startDate} - ${edu.endDate}\n${edu.description}',
                      style: TextStyle(fontSize: 16),
                    )).toList(),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Interests: ${user.interests.join(', ')}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<User> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString("user");
    if (userName != null) {
      return UserDataSource.getUserByName(userName);
    } else {
      throw Exception('No user found in SharedPreferences');
    }
  }
}
