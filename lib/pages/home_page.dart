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

  //Logout and touch effect For Menu Options
  int? _touchedIndex; // Track the touched item index

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

  //Logout funtion clearing local storage data
  void logout() {
    //Clear the local storage data
    html.window.localStorage.clear();
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          //Tabs buttons
          bottom: const TabBar(
            tabs: [
              Tab(text: "Floor -1"),
              Tab(text: "Floor -2"),
            ],
          ),
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
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/shopRegisterForm');
                },
                child: const DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text(
                    'SVG',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),

              //menu options
              // Profile option with hover effect for laptop and tap effect for mobile
              _buildMenuOption(
                index: 0,
                icon: Icons.person,
                title: 'Profile',
                onTap: () {
                  logger.i("Navigate to profile");
                  Navigator.pushNamed(context, '/register');
                },
              ),

              //Setting option with hover effect and touch effect
              _buildMenuOption(
                index: 1,
                icon: Icons.settings,
                title: "Settings",
                onTap: () {
                  Navigator.pushNamed(context, '/register');
                },
              ),

              //Logout option with hover effct and touch effect
              _buildMenuOption(
                  index: 2, icon: Icons.logout, title: "Logout", onTap: logout),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(8, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            child: SizedBox(
                              width: 170,
                              height: 120,
                              child:
                                  Center(child: Text("Card ${index * 2 + 1}")),
                            ),
                          ),
                          const SizedBox(width: 25), // Space between the cards
                          Card(
                            child: SizedBox(
                              width: 170,
                              height: 120,
                              child:
                                  Center(child: Text("Card ${index * 2 + 2}")),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
             Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(8, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            child: SizedBox(
                              width: 170,
                              height: 120,
                              child:
                                  Center(child: Text("Card ${index * 2 + 1}")),
                            ),
                          ),
                          const SizedBox(width: 25), // Space between the cards
                          Card(
                            child: SizedBox(
                              width: 170,
                              height: 120,
                              child:
                                  Center(child: Text("Card ${index * 2 + 2}")),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),

        // Center(
        //   child: SingleChildScrollView(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: List.generate(8, (index) {
        //         return Padding(
        //           padding: const EdgeInsets.symmetric(vertical: 8.0),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Card(
        //                 child: SizedBox(
        //                   width: 170,
        //                   height: 120,
        //                   child: Center(child: Text("Card ${index * 2 + 1}")),
        //                 ),
        //               ),
        //               const SizedBox(width: 25), // Space between the cards
        //               Card(
        //                 child: SizedBox(
        //                   width: 170,
        //                   height: 120,
        //                   child: Center(child: Text("Card ${index * 2 + 2}")),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         );
        //       }),
        //     ),
        //   ),
        // ),
      ),
    );
  }

  // Method to build menu options with hover and touch effects
  Widget _buildMenuOption({
    required int index,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _touchedIndex = index; // Set the touched index
        });
        onTap();
      },
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            _touchedIndex = index; // Set the touched index when hovered
          });
        },
        onExit: (event) {
          setState(() {
            _touchedIndex = null; // Reset the touched index when hover exits
          });
        },
        child: Container(
          color: _touchedIndex == index ? Colors.blue : null,
          child: ListTile(
            leading: Icon(icon),
            title: Text(title),
          ),
        ),
      ),
    );
  }
}
