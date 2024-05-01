import 'package:flutter/material.dart';
import 'package:cv_build/model/user.dart';

class UserDataSource {
  static List<User> users = [
    User(
      "Mohamed Taha Cherif",
      "Software Engineer",
      "TahaCherif@gmail.com",
      "+216 44134396",
      "123 Main St, City",
      "taha.jpg",
      "En tant qu'étudiant en deuxième année dans le domaine du génie informatique, je suis passionné par le développement web et mobile. Ma polyvalence dans ces domaines me permet d'aborder diverses tâches avec aisance. Doté d'une grande capacité d'adaptation et d'une aptitude avérée au travail en équipe,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaazzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzaaaaaaaaaaaaaaaaa .",
      ["Flutter", "Java", "Python" ,"Anuglar" ],
      [
        Experience("Senior Developer", "ABC Inc.", "2018", "Present", "Developed new features for XYZ app."),
        Experience("Junior Developer", "XYZ Corp.", "2016", "2018", "Worked on frontend development."),
      ],
      [
        Education("Bachelor's in Computer Science", "University of XYZ", "2015", "2016", "Graduated with honors."),
        Education("High School Diploma", "XYZ High School", "2008", "2012", "Achieved academic excellence."),
      ],
      ["Music", "Reading", "Travel"],
    ),
    User(
      "Taieb Daoud",
      "Marketing Specialist",
      "taiebdaoud3@gmail.com",
      "+21644134396",
      "456 Elm St, Town",
      "taieb.jpg",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      ["Marketing", "Social Media", "Analytics"],
      [
        Experience("aaaaaaaaaa", "XYZ Agency", "2017", "Present", "Led successful campaigns for clients."),
        Experience("Marketing Assistant", "ABC Company", "2015", "2017", "Assisted in content creation and SEO."),
      ],
      [
        Education("Master's in Marketing", "University of ABC", "2013", "2015", "Focused on digital marketing strategies."),
        Education("Bachelor's in Business Administration", "ABC University", "2009", "2013", "Graduated with honors."),
      ],
      ["Yoga", "Cooking", "Hiking"],
    ),
  ];

  static Future<User> getUserByName(String name) async {
    await Future.delayed(Duration(seconds: 1));
    User? user = User.empty();
    user = users.firstWhere((user) => user.name == name);
    return user;
  }
}
