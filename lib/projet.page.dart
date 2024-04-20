

import 'package:flutter/material.dart';


import '../menu/drawer.widget.dart';

class ProjetPage extends StatelessWidget {
  TextEditingController txt_ville =new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Completed Projects",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey[900],
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFD7ACAC),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildEducationItems(),
        ),
      ),
    );
  }

  List<Widget> _buildEducationItems() {
    return [
      _buildEducationItem('Education Item 1', 'Subtitle for Item 1'),

      // Add more items as needed
    ];
  }

  Widget _buildEducationItem(String title, String subtitle) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // Couleur de fond du cadre
        borderRadius: BorderRadius.circular(10.0), // Bord arrondi du cadre
      ),
      margin: EdgeInsets.only(bottom: 16.0), // Marge inférieure pour l'espacement entre les éléments
      padding: EdgeInsets.all(16.0), // Espacement interne du cadre
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(Icons.school),
        onTap: () {
          // Ajoutez ici la logique pour gérer le tap
        },
      ),
    );
  }
}
