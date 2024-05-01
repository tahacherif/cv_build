import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'LanguageProvider.dart';
import 'main.dart';

class LanguePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEnglishOn ? "langue" : "Language",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isLightMode ? Colors.grey[900] : Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: isLightMode ? Color(0xFFD7ACAC) : Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildLanguageButton(context, 'English', Icons.language, Locale('en')),
            SizedBox(height: 12.0),
            _buildLanguageButton(context, 'Français', Icons.language, Locale('fr')),
            SizedBox(height: 12.0),
            _buildLanguageButton(context, 'العربية', Icons.language, Locale('ar')),
          ],
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
                Navigator.pushNamed(context, '/skills');
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
          ],
        ),
      ),
      backgroundColor: isLightMode ? Colors.white : Colors.black, // Set background color based on mode
    );
  }

  Widget _buildLanguageButton(BuildContext context, String language, IconData icon, Locale locale) {
    return ElevatedButton.icon(
      onPressed: () {
        Provider.of<LanguageProvider>(context, listen: false).changeLanguage(locale);
        print(locale);
        Navigator.pop(context); // Navigate back after changing the language
      },

      icon: Icon(icon),
      label: Text(language),
      style: ElevatedButton.styleFrom(
        elevation: 3, // Elevation of the button
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0), // Button padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
        ),
      ),
    );
  }
}
