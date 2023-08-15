
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:mvvm/repository/auth_repository.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/routes/routes_name.dart';

class AuthViewModel with ChangeNotifier {

  final _myRepo= AuthRepository();
  bool _loading= false;
  bool get loading => _loading;

  bool _signUpLoading= false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value){
    _loading= value;
    notifyListeners();
  }

  setSignUpLoading(bool value){
    _signUpLoading= value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data , BuildContext context) async{
    setLoading(true);
    _myRepo.loginApi(data).then((value){
      setLoading(false);
      //
      final userPreference= Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveUser(
        UserModel(
          token: value['token'].toString(),
        ),
      );
      Utils.flushBarErrorMessage('Login Successfully', context);
      Navigator.pushNamed(context, RouteName.home);
      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error, stackTrace){
      setLoading(false);
      if(kDebugMode){
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<void> signUpApi(dynamic data , BuildContext context) async{
    setSignUpLoading(true);
    _myRepo.registerApi(data).then((value){
      setSignUpLoading(false);
      Utils.flushBarErrorMessage('SignUp Successfully', context);
      Navigator.pushNamed(context, RouteName.home);
      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error, stackTrace){
      setSignUpLoading(false);
      if(kDebugMode){
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }

}