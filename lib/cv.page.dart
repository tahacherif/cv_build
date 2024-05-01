import 'package:flutter/material.dart';
import 'package:cv_build/data/user_data_source.dart'; // Import UserDataSource
import 'package:cv_build/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'menu/drawer.widget.dart';
import 'package:url_launcher/url_launcher.dart';

class CvPage extends StatefulWidget {
  CvPage();

  @override
  _CvPageState createState() => _CvPageState();
}

class _CvPageState extends State<CvPage> {
  late bool _isLightMode;
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
        _isLightMode = isLightMode;
      });
    } else {
      setState(() {
        _isLightMode = true; // Default to light mode
      });
    }
  }

  void _toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLightMode = !_isLightMode;
      prefs.setBool("isLightMode", _isLightMode);
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
            drawer: MyDrawer(user: user),
            appBar: AppBar(
              title: Text(
                'Bienvenue dans mon CV',
                style: TextStyle(fontSize: 18),
              ),
              backgroundColor: _isLightMode ? Color(0xFFF5E6E6) : Colors.black, // Adjust background color based on theme
              actions: [
                IconButton(
                  icon: Icon(Icons.language),
                  onPressed: () {
                    // Add language change logic here
                  },
                ),
                IconButton(
                  icon: Icon(_isLightMode ? Icons.light_mode : Icons.dark_mode),
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
                  // Partie gauche pour la photo et les contacts
                  Container(
                    color: _isLightMode ? Color(0xFFF5E6E6) : Colors.black, // Adjust background color based on theme
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
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: _isLightMode ? Colors.black : Colors.white),
                          ),
                        ),
                        SizedBox(height: 1),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Icon(Icons.email, color: _isLightMode ? Colors.black : Colors.white),
                            ),
                            SizedBox(width: 2),
                            Text(
                              '${user.email}',
                              style: TextStyle(fontSize: 13, color: _isLightMode ? Colors.black : Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(height: 1),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Icon(Icons.phone, color: _isLightMode ? Colors.black : Colors.white),
                            ),
                            SizedBox(width: 2),
                            Text(
                              '${user.phone}',
                              style: TextStyle(fontSize: 16, color: _isLightMode ? Colors.black : Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Icon(Icons.location_on, color: _isLightMode ? Colors.black : Colors.white),
                            ),
                            SizedBox(width: 2),
                            Text(
                              '${user.address}',
                              style: TextStyle(fontSize: 16, color: _isLightMode ? Colors.black : Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            'Skills:',
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: _isLightMode ? Colors.black : Colors.white),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...user.skills.map((skill) => Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                '- $skill',
                                style: TextStyle(fontSize: 20, color: _isLightMode ? Colors.black : Colors.white),
                              ),
                            )).toList(),
                            SizedBox(height: 100),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      color: _isLightMode ? Colors.white : Colors.grey[800], // Adjust background color based on theme
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Text(
                            user.name,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _isLightMode ? Color(0xFFD7ACAC) : Colors.white),
                          ),
                          Text(
                            '- ${user.summary}',
                            style: TextStyle(fontSize: 18, color: _isLightMode ? Colors.black : Colors.white),
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
                                    size: 40,
                                    color: _isLightMode ? Color(0xFF9D7C7C) : Colors.white,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  launch('https://www.linkedin.com/in/taha-cherif-130481207/');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: ImageIcon(
                                    AssetImage('images/link.png'),
                                    size: 40,
                                    color: _isLightMode ? Color(0xFF9D7C7C) : Colors.white,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  launch('https://www.facebook.com/taha.cherif.52');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: ImageIcon(
                                    AssetImage('images/fb.png'),
                                    size: 40,
                                    color: _isLightMode ? Color(0xFF9D7C7C) : Colors.white,
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
