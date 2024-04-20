import 'package:flutter/material.dart';
import 'package:cv_build/data/user_data_source.dart'; // Import UserDataSource
import 'package:cv_build/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'menu/drawer.widget.dart';

import 'package:url_launcher/url_launcher.dart';


class CvPage extends StatelessWidget {
  CvPage();

  // Définition de la couleur "poudre de riz"
  static const Color poudreDeRiz = Color(0xFFF5E6E6);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(), // Afficher un indicateur de chargement pendant le chargement des données utilisateur
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'), // Afficher un message d'erreur si le chargement des données échoue
          );
        } else {
          User user = snapshot.data!;
          return Scaffold(
            drawer: MyDrawer(),
            appBar: AppBar(
              title: Text(
                'Bienvenue dans mon CV',
                style: TextStyle(fontSize: 18), // Définir une taille de police plus petite
              ),
              backgroundColor: Color(0xFFF5E6E6),
              actions: [
                IconButton(
                  icon: Icon(Icons.language), // Utiliser l'icône de langue
                  onPressed: () {
                    // Ajoutez ici la logique pour changer la langue
                  },
                ),
                IconButton(
                  icon: Icon(Icons.nightlight_round), // Utiliser l'icône de mode nuit
                  onPressed: () {
                    // Ajoutez ici la logique pour activer/désactiver le mode nuit
                  },
                ),
              ],
            ),

            body: Padding(
              padding: EdgeInsets.all(0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Partie gauche pour la photo et les contacts
                  Container(
                    color: poudreDeRiz, // Utiliser la couleur "poudre de riz"
                    padding: EdgeInsets.all(0),
                    width: 200, // Largeur fixée pour correspondre à la taille de la photo
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Photo de l'utilisateur sans bordure
                        Container(
                          width: 200, // Largeur augmentée
                          height: 300, // Hauteur augmentée
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/' + user.image), // Chemin de votre image
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Conteneur pour aligner le mot "Contact" à gauche
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 16), // Ajouter un padding horizontal à gauche
                          child: Text(
                            'Contact:',
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white), // Modifier la couleur du texte en blanc
                          ),
                        ),
                        SizedBox(height: 1), // Ajouter un espace entre "Contact" et les informations
                        // Ligne pour l'email avec une icône
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 3), // Ajouter un padding pour aligner avec le mot "Contact"
                              child: Icon(Icons.email, color: Colors.black), // Changer la couleur de l'icône en noir
                            ),
                            SizedBox(width: 2),
                            Text(
                              '${user.email}',
                              style: TextStyle(fontSize: 13, color: Colors.black), // Modifier la couleur du texte en noir
                            ),
                          ],
                        ),
                        SizedBox(height: 1), // Ajouter un espace entre les lignes d'informations
                        // Ligne pour le téléphone avec une icône
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 3), // Ajouter un padding pour aligner avec le mot "Contact"
                              child: Icon(Icons.phone, color: Colors.black), // Changer la couleur de l'icône en noir
                            ),
                            SizedBox(width: 2),
                            Text(
                              '${user.phone}',
                              style: TextStyle(fontSize: 16, color: Colors.black), // Modifier la couleur du texte en noir
                            ),
                          ],
                        ),
                        SizedBox(height: 2), // Ajouter un espace entre les lignes d'informations
                        // Ligne pour l'adresse avec une icône
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 3), // Ajouter un padding pour aligner avec le mot "Contact"
                              child: Icon(Icons.location_on, color: Colors.black), // Changer la couleur de l'icône en noir
                            ),
                            SizedBox(width: 2),
                            Text(
                              '${user.address}',
                              style: TextStyle(fontSize: 16, color: Colors.black), // Modifier la couleur du texte en noir
                            ),
                          ],
                        ),
                        SizedBox(height: 16), // Ajouter un espace entre les informations de contact et les compétences
                        // Texte pour les compétences
                        Padding(
                          padding: const EdgeInsets.only(left: 16), // Ajouter un padding pour aligner avec le mot "Contact"
                          child: Text(
                            'Skills:',
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white), // Modifier la couleur du texte en blanc
                          ),
                        ),
                        // Ligne pour afficher les compétences
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Liste des compétences
                            ...user.skills.map((skill) => Padding(
                              padding: const EdgeInsets.only(left: 16), // Ajouter un padding pour aligner avec le mot "Contact"
                              child: Text(
                                '- $skill',
                                style: TextStyle(fontSize: 20, color: Colors.black), // Modifier la couleur du texte en noir
                              ),
                            )).toList(),
                            SizedBox(height: 100), // Ajouter un espace entre les compétences et l'icône de langue

                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  // Partie droite pour les données
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        // Informations de contact
                        Text(
                          user.name,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD7ACAC)),
                        ),
                        Text(
                          '- ${user.summary}',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 60),
                        // Rangée pour les icônes
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // Première icône Instagram
                            GestureDetector(
                              onTap: () {
                                // Rediriger vers le lien Instagram
                                // Mettez votre URL Instagram à la place de 'votre_url_instagram'
                                launch('votre_url_instagram');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: ImageIcon(
                                  AssetImage('images/insta.png'),
                                  size: 40, // Taille plus petite de l'icône
                                  color: Color(0xFF9D7C7C),
                                ),
                              ),
                            ),

                            // Deuxième icône LinkedIn
                            GestureDetector(
                              onTap: () {
                                // Rediriger vers le lien LinkedIn
                                // Mettez votre URL LinkedIn à la place de 'votre_url_linkedin'
                                launch('votre_url_linkedin');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: ImageIcon(
                                  AssetImage('images/link.png'),
                                  size: 40, // Taille plus petite de l'icône
                                  color: Color(0xFF9D7C7C),
                                ),
                              ),
                            ),

                            // Troisième icône Facebook
                            GestureDetector(
                              onTap: () {
                                // Rediriger vers le lien Facebook
                                // Mettez votre URL Facebook à la place de 'votre_url_facebook'
                                launch('votre_url_facebook');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: ImageIcon(
                                  AssetImage('images/fb.png'),
                                  size: 40, // Taille plus petite de l'icône
                                  color: Color(0xFF9D7C7C),
                                ),
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove("user");
                Navigator.pop(context); // Fermer la page actuelle
                Navigator.of(context).pushNamed('/home'); // Naviguer vers la page d'accueil
              },
              child: Icon(Icons.arrow_back),
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
