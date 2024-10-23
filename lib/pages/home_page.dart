import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'dart:html' as html;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

//Logger for console data
final Logger logger = Logger();

class HomePageState extends State<HomePage> {
  String? token;
  String? userName;
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // Scaffold key

  @override
  void initState() {
    super.initState();
    _loadLoginData();
  }

  //get login data in local storage
  Future<void> _loadLoginData() async {
    setState(() {
      userName = html.window.localStorage['flutter.userName'];
      token = html.window.localStorage['flutter.token'];
    });
    logger.i("Saved userName: $userName, token: $token");
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        // title: const Text('Home Page'),

        //Hamburger Icon on the left side
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!
                .openDrawer(); //open the drawer when clicked
            //open the drawer when clicked
          },
        ),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'SVG',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),

            //menu options
            //profile option
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                logger.i("naviaget to profile");
                Navigator.pushNamed(context, '/register');
              },
            ),

            //settings option
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                logger.i('naviagte to settings page');
                Navigator.pushNamed(context, '/register');
              },
            ),

            //logout option
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                logger.i('naviagte to login page and clear token');
                Navigator.pushNamed(context, '/register');
              },
            )
          ],
        ),
      ),
      body: Center(
          child: userName != null && token != null
              ? Text('Welcome, $userName')
              : const Text("Welcome To Homepage")),
    );
  }
}
