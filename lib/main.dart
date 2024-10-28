// import 'package:app/pages/login_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/pages/register_page.dart';
import 'package:app/pages/shop_register_form.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:logger/logger.dart';

void main() {
  runApp(const MyApp());
}


//Logger for console data
final Logger logger = Logger();

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
      //Routes setting and validatios
      onGenerateRoute: (RouteSettings settings) {
        
        //Restrict acees to login and register page if authenticated
        if (isAuthenticated() &&
            (settings.name == "/" || settings.name == '/register')) {
          return MaterialPageRoute(builder: (context) => const HomePage());
        }

        // Restrict to acess to home
        if (!isAuthenticated() && settings.name == '/home') {
          //Redirect to login if not authenticated.
          return MaterialPageRoute(builder: (context) => const LoginPage());
        }

        //Return the routes based on settings
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => const LoginPage());
          case '/home':
            return MaterialPageRoute(builder: (context) => const HomePage());
          case '/register':
            return MaterialPageRoute(
                builder: (context) => const RegisterPage());
          case '/shopRegisterForm':
            return MaterialPageRoute(
                builder: (context) => const ShopRegisterForm());
          default:
            return MaterialPageRoute(builder: (context) => const  LoginPage());
        }
      },
      // home: const RegisterPage(),
    );
  }
}
