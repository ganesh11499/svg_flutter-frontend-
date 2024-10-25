// import 'package:app/pages/login_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;


void main() {
  runApp(const MyApp());
}

//get localstorage token
bool isAuthenticated() {
  //return if local storage token is exists
  return html.window.localStorage.containsKey('flutter.token');
}

class MyApp extends StatelessWidget {
  //key parameter
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (RouteSettings settings) {
         if (settings.name == '/home') {
          // Check if the user is authenticated
          if (!isAuthenticated()) {
            // If not authenticated, redirect to login
             return  MaterialPageRoute(builder: (context) => const LoginPage());
          }
        }
      
      // Return the appropriate route based on the settings
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => const LoginPage());
          case '/home':
            return MaterialPageRoute(builder: (context) => const HomePage());
          case '/register':
            return MaterialPageRoute(builder: (context) => const RegisterPage());  
          default:
            return MaterialPageRoute(builder: (context) => const LoginPage());
        }
      },
      // home: const RegisterPage(),  
    );
  }
}
