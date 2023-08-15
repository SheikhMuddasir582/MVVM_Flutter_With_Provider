

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/home_screen.dart';
import 'package:mvvm/view/login_view.dart';
import 'package:mvvm/view/signup_view.dart';
import 'package:mvvm/view/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings){
    final argu= settings.arguments;

    switch(settings.name){
      case RouteName.home:
        return MaterialPageRoute(builder: (BuildContext context) => HomeScreen());
      case RouteName.login:
        return MaterialPageRoute(builder: (BuildContext context) => LoginView());
      case RouteName.signUp:
        return MaterialPageRoute(builder: (BuildContext context) => SignUpView());
      case RouteName.splashView:
        return MaterialPageRoute(builder: (BuildContext context) => SplashView());
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(
              child:Text('No Route Defined'),
            ),
          );
        });
    }
  }
}