import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cv_build/data/user_data_source.dart'; // Import UserDataSource
import 'package:cv_build/model/user.dart';
import 'main.dart';
import 'menu/drawer.widget.dart';
import 'package:url_launcher/url_launcher.dart';

class CvPage extends StatefulWidget {
  CvPage();

  @override
  _CvPageState createState() => _CvPageState();
}

class _CvPageState extends State<CvPage> {
  @override
  void initState() {
    super.initState();
    _getTheme();
  }

  Future<void> _getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLightMode = prefs.getBool("isLightMode");
    if (isLightMode != null) {
      setState(() {
        isLightMode = isLightMode;
      });
    } else {
      setState(() {
        isLightMode = true; // Default to light mode
      });
    }
  }
  void _toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLightMode = !isLightMode;
      prefs.setBool("isLightMode", isLightMode);
    });
  }

  void _toggleLanguage() {
    setState(() {
      isEnglishOn = !isEnglishOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          User user = snapshot.data!;
          return Scaffold(
            drawer: MyDrawer(user: user, isEnglishOn: isEnglishOn),
            appBar: AppBar(
              title: Text(
                isEnglishOn ? 'Bienvenue dans mon CV' : 'Welcome to my CV',
                style: TextStyle(fontSize: 21, color: isLightMode ? Colors.black : Colors.white),
              ),
              backgroundColor: isLightMode ? Color(0xFFF5E6E6) : Colors.black,
              iconTheme: IconThemeData(color: isLightMode ? Colors.black : Colors.white),
              actions: [
                IconButton(
                  icon: Icon(Icons.language, color: isLightMode ? Colors.black : Colors.white),
                  onPressed: () {
                    _toggleLanguage();
                  },
                ),
                IconButton(
                  icon: Icon(isLightMode ? Icons.light_mode : Icons.dark_mode, color: isLightMode ? Colors.black : Colors.white),
                  onPressed: () {
                    _toggleTheme();
                  },
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side for photo and contacts
                  Container(
                    color: isLightMode ? Color(0xFFF5E6E6) : Colors.black,
                    padding: EdgeInsets.all(0),
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 200,
                          height: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/' + user.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 16),
                          child: Text(
                            'Contact:',
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: isLightMode ? Colors.black : Colors.white),
                          ),
                        ),
                        SizedBox(height: 1),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 9),
                              child: Icon(Icons.email, color: isLightMode ? Colors.black : Colors.white),
                            ),
                            SizedBox(width: 2),
                            Text(
                              '${user.email}',
                              style: TextStyle(fontSize: 13, color: isLightMode ? Colors.black : Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(height: 1),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 9),
                              child: Icon(Icons.phone, color: isLightMode ? Colors.black : Colors.white),
                            ),
                            SizedBox(width: 2),
                            Text(
                              '${user.phone}',
                              style: TextStyle(fontSize: 16, color: isLightMode ? Colors.black : Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 9),
                              child: Icon(Icons.location_on, color: isLightMode ? Colors.black : Colors.white),
                            ),
                            SizedBox(width: 2),
                            Text(
                              '${user.address}',
                              style: TextStyle(fontSize: 16, color: isLightMode ? Colors.black : Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            isEnglishOn ? 'Comptetances' : 'Skills:',
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: isLightMode ? Colors.black : Colors.white),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...user.skills.map((skill) => Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                '- $skill',
                                style: TextStyle(fontSize: 20, color: isLightMode ? Colors.black : Colors.white),
                              ),
                            ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: isLightMode ? Colors.white : Colors.grey[800],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.only(left: 9.0),
                            child: Text(
                              user.name,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isLightMode ? Color(0xFFD7ACAC) : Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 9.0),
                            child: Text(
                              isEnglishOn
                                  ? '- ${user.summary}'
                                  : "-As a second-year student in the field of computer engineering, I am passionate about web and mobile development. My versatility in these areas allows me to tackle various tasks with ease. Endowed with great adaptability and a proven ability to work in a team.",
                              style: TextStyle(fontSize: 18, color: isLightMode ? Colors.black : Colors.white),
                            ),
                          ),
                          SizedBox(height: 60),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  launch('https://www.instagram.com/cherif.taha/');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: ImageIcon(
                                    AssetImage('images/insta.png'),
                                    size: 50,
                                    color: isLightMode ? Color(0xFF9D7C7C) : Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  launch('https://www.linkedin.com/in/taha-cherif-130481207/');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: ImageIcon(
                                    AssetImage('images/link.png'),
                                    size: 50,
                                    color: isLightMode ? Color(0xFF9D7C7C) : Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  launch('https://www.facebook.com/taha.cherif.52');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: ImageIcon(
                                    AssetImage('images/fb.png'),
                                    size: 50,
                                    color: isLightMode ? Color(0xFF9D7C7C) : Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove("user");
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/home');
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
