
import 'package:flutter/foundation.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:flutter/widgets.dart';
class SplashServices {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication (BuildContext context) async{
    getUserData().then((value) async{
      if(value.token.toString() == 'null' || value.token.toString() == ''){
       await Future.delayed(Duration(seconds: 3));
       Navigator.pushNamed(context, RouteName.login);
      }
      else{
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RouteName.home);
      }
    }).onError((error, stackTrace){
     if(kDebugMode){
       print(error.toString());
     }
    });
  }





}