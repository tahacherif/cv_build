import 'package:flutter/material.dart';
import 'package:cv_build/main.dart';

class GlobalParams {
  static List<Map<String, dynamic>> menus = [
    {"title": isEnglishOn ? "Acceuil" : "Home", "icon": Icon(Icons.home, color: Color(0xFFA47676)), "route": "/home"},
    {"title": isEnglishOn ? "Formation Académique" : "Academic Formation", "icon": Icon(Icons.school, color: Color(0xFFA47676)), "route": "/formation"},
    {"title": isEnglishOn ? "Expérience Professionnelle" : "Professional Experience", "icon": Icon(Icons.work, color: Color(0xFFA47676)), "route": "/exp"},
    {"title": isEnglishOn ? "Compétences Techniques" : "Skills", "icon": Icon(Icons.computer, color: Color(0xFFA47676)), "route": "/skills"},
    {"title": isEnglishOn ? "Langue" : "Language", "icon": Icon(Icons.language, color: Color(0xFFA47676)), "route": "/langue"},
    {"title": isEnglishOn ? "Déconnexion" : "Logout", "icon": Icon(Icons.exit_to_app, color: Color(0xFFA47676)), "route": "/home"},
  ];
}
