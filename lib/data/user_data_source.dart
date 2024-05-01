import 'package:flutter/material.dart';
import 'package:cv_build/model/user.dart';

class UserDataSource {
  static List<User> users = [
    User(
      "Mohamed Taha Cherif",
      "Software Engineer",
      "TahaCherif@gmail.com",
      "+216 28173340",
      "Tunis,Sfax,Route Ain",
      "taha.jpg",
      "En tant qu'étudiant en deuxième année dans le domaine du génie informatique, je suis passionné par le développement web et mobile. Ma polyvalence dans ces domaines me permet d'aborder diverses tâches avec aisance. Doté d'une grande capacité d'adaptation et d'une aptitude avérée au travail en équipe .",
      ["Flutter", "Java", "Python" ,"Anuglar" ],
      [
        Experience("InterShip", "TelNet", "2019", "2020", "Developed new AI features "),
        Experience("InterShip", "AtlasWorld", "2022", "2023", "Worked on frontend and backend development."),
      ],
      [
        Education("Bachelor's in Computer Science", "University of Fseg Sfax", "2019", "2022", "Graduated with honors."),
        Education("High School Diploma", "Hbib Themer", "2015", "2019", "Achieved academic excellence."),
      ],
      ["Music", "Reading", "Travel"],
    ),
    User(
      "Taieb Daoud",
      "Software Engineer",
      "Taiebdaoud3@gmail.com",
      "+216 44134396",
      "Tunis,sfax,route ain",
      "taieb.jpg",
      "En tant qu'étudiant en deuxième année dans le domaine du génie informatique, je suis passionné par le développement web et mobile. Ma polyvalence dans ces domaines me permet d'aborder diverses tâches avec aisance. Doté d'une grande capacité d'adaptation et d'une aptitude avérée au travail en équipe .",
      ["Flutter", "Java", "Python" ,"Anuglar" ],
      [
        Experience("InterShip", "TelNet", "2019", "2020", "Developed new AI features "),
        Experience("InterShip", "AtlasWorld", "2022", "2023", "Worked on frontend and backend development."),
      ],
      [
        Education("Bachelor's in Computer Science", "University of ESPIN Sfax", "2019", "2022", "Graduated with honors."),
        Education("High School Diploma", "ElHay", "2015", "2019", "Achieved academic excellence."),
      ],
      ["Music", "Reading", "Travel"],
    ),
  ];

  static Future<User> getUserByName(String name) async {
    await Future.delayed(Duration(seconds: 1));
    User? user = User.empty();
    user = users.firstWhere((user) => user.name == name);
    return user;
  }
}
