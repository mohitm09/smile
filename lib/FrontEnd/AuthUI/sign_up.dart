import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:smile/BackEnd/Firebase/Auth/sign_up_auth.dart';
import 'package:smile/FrontEnd/AuthUI/log_in.dart';
import 'package:smile/Global_Users/enum_generation.dart';
import 'package:smile/Global_Users/reg_exp.dart';

import 'common_auth_methods.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _conformPassword = TextEditingController();

  final EmailAndPasswordAuth _emailAndPasswordAuth = EmailAndPasswordAuth();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(34, 48, 68, 1),
          body: LoadingOverlay(
            isLoading: this._isLoading,
            child: Container(
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(height: 50.0,),
                  Center(
                    child: Text('Sign-Up', style: TextStyle(fontSize: 28.0, color: Colors.white),),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height/1.65,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
                    child: Form(
                      key: this._signUpKey,
                      child: ListView(
                        children: [
                          commonTextFormField(hintText: 'Email', validator: (String? inputVal){
                            if(!emailRegex.hasMatch(inputVal.toString())) {
                              return 'Email Format not Matching';
                            }
                            return null;
                          }, textEditingController: this._email),
                          commonTextFormField(hintText: 'Password', validator: (String? inputVal) {
                            if(inputVal!.length <6){
                              return 'Password must contain at least 6 characters';
                            }
                            return null;
                          }, textEditingController: this._password),
                          commonTextFormField(hintText: 'Conform Password', validator: (String? inputVal) {
                            if(inputVal!.length <6){
                              return 'Password must contain at least 6 characters';
                            }
                            if(this._password.text != this._conformPassword.text) {
                              return 'Password and Conform Password must be same';
                            }
                            return null;
                          }, textEditingController: this._conformPassword),
                          signUpAuthButton(context, 'Sign-Up'),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Text('Or Continue With',
                      style: TextStyle(color: Colors.white,fontSize: 20.0),
                    ),
                  ),
                  socialMediaIntegrationButtons(),
                  switchAnotherAuthString(context, 'Already have an account? ', 'Log-In')
                ],
              ),
            ),
          ),
        ),
    );
  }

  Widget signUpAuthButton(BuildContext context, String buttonName) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(
                MediaQuery.of(context).size.width -60, 30.0),
            elevation: 5.0,
            primary: Color.fromRGBO(57, 60, 80, 1),
            padding: EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 7.0,
                bottom: 7.0
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            )
        ),
        child: Text(
          buttonName,
          style: TextStyle(
              fontSize: 25.0,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w400
          ),
        ),
        onPressed: () async {
          if(this._signUpKey.currentState!.validate()){
            print('Validated');

            if(mounted){
              setState(() {
                this._isLoading = true;
              });
            }
            SystemChannels.textInput.invokeMethod('TextInput.hide');
            
            final EmailSignUpResults response = await this._emailAndPasswordAuth.signUpAuth(email: this._email.text, password: this._password.text);
            if(response == EmailSignUpResults.SignUpCompleted){
              Navigator.push(context, MaterialPageRoute(builder: (_) => LogInScreen()));
            }else{
              final String msg = response == EmailSignUpResults.EmailAlreadtExist?'Email Already Exist': 'SignUp Not Completed';
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
            }
          }else{
            print('Not Validated');
          }

          if(mounted){
            setState(() {
              this._isLoading = false;
            });
          }
        },
      ),
    );
  }


}
