import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/screens/authScreens/forgot_password.dart';
import 'package:projects/screens/authScreens/login.dart';
import 'package:projects/screens/authScreens/reset_password.dart';
import 'package:projects/screens/authScreens/signup.dart';
import 'package:projects/screens/homeScreens/home_page.dart';
import 'package:projects/utils/routes.dart';

import '../screens/authScreens/welcome.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    Widget widgetScreen;
    final args = settings.arguments;

    switch (settings.name){
      case Routes.welcome:
        widgetScreen = Welcome();
        break;
      case Routes.loginRoute:
        widgetScreen = Login();
        break;
      case Routes.signupRoute:
        widgetScreen = Signup();
        break;
      case Routes.forgetPasswordRoute:
        widgetScreen = ForgotPassword();
        break;
      case Routes.resetPasswordRoute:
        widgetScreen = ResetPassword();
        break;
      case Routes.homeRoute:
        widgetScreen = HomePage();
        break;
      default:
        widgetScreen = _errorRoute();

    }
    return GetPageRoute(
        routeName: settings.name,
        page: () => widgetScreen,
        settings: settings,
        transition: Transition.rightToLeft
    );
  }
  static Widget _errorRoute() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('No Such screen found'),
      ),
    );
  }
}