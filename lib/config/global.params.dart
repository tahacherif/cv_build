import 'package:flutter/material.dart';

class GlobalParams{
  static List<Map<String,dynamic>>menus=[
    {"title":"Acceuil","icon":Icon(Icons.home,color: Color(0xFFA47676),),"route":"/home"},
    {"title":"Academic Formation","icon":Icon(Icons.school,color: Color(0xFFA47676),),"route":"/formation"},
    {"title":"Professional Experience","icon":Icon(Icons.work,color: Color(0xFFA47676),),"route":"/exp"},
    {"title":"Technical Skills","icon":Icon(Icons.computer,color: Color(0xFFA47676),),"route":"/skills"},
    {"title":"Language","icon":Icon(Icons.language,color: Color(0xFFA47676),),"route":"/langue"},
    {"title":"Logout","icon":Icon(Icons.exit_to_app,color: Color(0xFFA47676),),"route":"/home"},
  ];
}
