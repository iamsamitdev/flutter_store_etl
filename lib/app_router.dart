import 'package:flutter_store/screens/about.dart';
import 'package:flutter_store/screens/contact.dart';
import 'package:flutter_store/screens/dashboard.dart';
import 'package:flutter_store/screens/login.dart';
import 'package:flutter_store/screens/product/product_detail.dart';
import 'package:flutter_store/screens/register.dart';
import 'package:flutter_store/screens/welcome.dart';

class AppRouter {

  // Router key
  static const String welcome = 'welcome';
  static const String about = 'about';
  static const String contact = 'contact';
  static const String login = 'login';
  static const String register = 'register';
  static const String dashboard = 'dashboard';
  static const String productDetail = 'productDetail';

  // Router Map
  static get routes => {
    welcome: (context) => const Welcome(),
    about: (context) => const About(),
    contact: (context) => const Contact(),
    login: (context) => const Login(),
    register: (context) => const Register(),
    dashboard: (context) => const Dashboard(),
    productDetail: (context) => const ProductDetail(),
  };

}