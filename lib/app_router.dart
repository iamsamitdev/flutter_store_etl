import 'package:flutter_store/screens/about.dart';
import 'package:flutter_store/screens/contact.dart';
import 'package:flutter_store/screens/home.dart';
import 'package:flutter_store/screens/login.dart';
import 'package:flutter_store/screens/register.dart';
import 'package:flutter_store/screens/welcome.dart';

class AppRouter {

  // Router key
  static const String welcome = 'welcome';
  static const String home = 'home';
  static const String about = 'about';
  static const String contact = 'contact';
  static const String login = 'login';
  static const String register = 'register';

  // Router Map
  static get routes => {
    welcome: (context) => const Welcome(),
    home: (context) => const Home(),
    about: (context) => const About(),
    contact: (context) => const Contact(),
    login: (context) => const Login(),
    register: (context) => const Register(),
  };

}