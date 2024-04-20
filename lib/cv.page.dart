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
          return CircularProgressIndicator(); // Afficher un indicateur de chargement pendant le chargement des données utilisateur
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Afficher un message d'erreur si le chargement des données échoue
        } else {
          User user = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Bienvenue sur mon cv !",
                textAlign: TextAlign.center,
              ),
              centerTitle: true, // Centrer le titre de l'appBar horizontalement
              backgroundColor: Colors.green,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.remove("user");
                  Navigator.pop(context); // Fermer la page actuelle
                  Navigator.of(context).pushNamed('/home'); // Naviguer vers la page d'accueil
                },
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('images/' + user.image), // Chemin de votre image
                      ),
                      SizedBox(width: 8),
                      Text(
                        user.name,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
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
