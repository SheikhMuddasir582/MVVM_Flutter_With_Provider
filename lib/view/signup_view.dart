import 'package:flutter/material.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  TextEditingController emailControl= TextEditingController();
  TextEditingController passwordControl= TextEditingController();
  FocusNode emailFocusNode= FocusNode();
  FocusNode passwordFocusNode= FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailControl.dispose();
    passwordControl.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _obsecurePassword.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final authViewModel= Provider.of<AuthViewModel>(context);
    final height= MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailControl,
              focusNode: emailFocusNode,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email',
                labelText: 'Email',
                prefixIcon: Icon(Icons.alternate_email),
              ),
              onFieldSubmitted: (value){
                // FocusScope.of(context).requestFocus(passwordFocusNode);
                Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
              },
            ),

            ValueListenableBuilder(
                valueListenable: _obsecurePassword,
                builder: (context, value, child){
                  return  TextFormField(
                    controller: passwordControl,
                    obscureText: _obsecurePassword.value,
                    focusNode: passwordFocusNode,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_open_rounded),
                      suffixIcon: InkWell(
                          onTap: (){
                            _obsecurePassword.value= !_obsecurePassword.value;

                          },
                          child: Icon(_obsecurePassword.value ? Icons.visibility_off_outlined : Icons.visibility_outlined)),
                      // suffixIcon: ValueListenableBuilder(
                      //   valueListenable: _obsecurePassword,
                      // )
                    ),
                  );
                }),
            SizedBox(height: height * .085,),
            RoundButton(
              title: 'Sign Up',
              loading: authViewModel.signUpLoading,
              onPress: (){

                // if(isEmailValid(emailControl.text.toString())){
                //   Utils.flushBarErrorMessage("plz enter valid email", context);
                // }

                if(emailControl.text.isEmpty){
                  Utils.flushBarErrorMessage("plz enter email", context);
                }
                else if(passwordControl.text.isEmpty){
                  Utils.flushBarErrorMessage("plz enter password", context);
                }
                else if(passwordControl.text.length < 6){
                  Utils.flushBarErrorMessage("password is short", context);
                }
                else{
                  Map data= {
                    'email' : emailControl.text.toString(),
                    'password' : passwordControl.text.toString(),
                  };
                  authViewModel.signUpApi(data, context);
                  print('api hit');
                }
              },
            ),
            SizedBox(height: height * .02,),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, RouteName.login);
              },
                child: Text("Already have an account? Login")),

          ],
        ),
      ),
    );
  }
}

