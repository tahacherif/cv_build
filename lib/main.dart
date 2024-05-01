import 'package:cv_build/skills.page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'LanguageProvider.dart';
import 'cv.page.dart';
import 'exp.page.dart';
import 'formation.page.dart';
import 'home.page.dart';
import 'langue.page.dart';
import 'map.page.dart';
bool isEnglishOn = true;
bool isLightMode = true;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageProvider>(
      create: (_) => LanguageProvider(), // Create an instance of LanguageProvider
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, _) {
          return MaterialApp(
            // MaterialApp with language switching support
            theme: ThemeData.light(), // Default light mode theme
            darkTheme: ThemeData.dark(), // Dark mode theme
            themeMode: ThemeMode.system, // Set to system to follow system settings
            debugShowCheckedModeBanner: false,
            home: HomePage(),
            routes: {
              '/cvPage': (context) => CvPage(),
              '/home': (context) => HomePage(),
              '/formation': (context) => FormationPage(),
              '/exp': (context) => ExpPage(),
              '/langue': (context) => LanguePage(),
              '/skills': (context) => SkillsPage(),
              '/maps': (context) => MapPage(),



            },
          );
        },
      ),
    );
  }
}
