import 'package:flutter/material.dart';
import 'package:cv_build/model/user.dart';

class UserDataSource {
  static List<User> users = [
    User(
      "Mohamed Taha Cherif",
      "Software Engineer",
      "john@example.com",
      "+1 555 123 4567",
      "123 Main St, City",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      ["Flutter", "Java", "Python"],
      [
        Experience("Senior Developer", "ABC Inc.", "2018", "Present", "Developed new features for XYZ app."),
        Experience("Junior Developer", "XYZ Corp.", "2016", "2018", "Worked on frontend development."),
      ],
      [
        Education("Bachelor's in Computer Science", "University of XYZ", "2012", "2016", "Graduated with honors."),
        Education("High School Diploma", "XYZ High School", "2008", "2012", "Achieved academic excellence."),
      ],
      ["Music", "Reading", "Travel"],
    ),
    User(
      "Taieb Daoud",
      "Marketing Specialist",
      "alice@example.com",
      "+1 555 987 6543",
      "456 Elm St, Town",
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
