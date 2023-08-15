
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Utils{


  // static double averageRating(List<int> ratings){
  //   var avgRatings = 0;
  //   for(int i=0; i< ratings.length; i++){
  //     avgRatings= avgRatings + ratings[i];
  //   }
  //   return double.parse((avgRatings/ratings.length).toStringAsFixed(1));
  // }


  static void fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus){
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);

  }

  static toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        // fontSize:
        toastLength: Toast.LENGTH_SHORT,

    );
  }

  static void flushBarErrorMessage(String message, BuildContext context){

    showFlushbar(context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
          titleColor: Colors.white,
          borderRadius: BorderRadius.circular(10),
          reverseAnimationCurve: Curves.easeOut,
          message: message,
          backgroundColor: Colors.red,
          // title: "sad",
          messageColor: Colors.black,
          positionOffset: 20,
          icon: Icon(Icons.error, size: 20, color: Colors.white,),
          flushbarPosition: FlushbarPosition.BOTTOM,
          duration: Duration(seconds: 3),
        )..show(context),

    );
  }

  static snackBar(String message, BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.red,
          content: Text(message)
      ),
    );
  }

}