import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../Global_Users/reg_exp.dart';
import 'common_auth_methods.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _logInKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(34, 48, 68, 1),
          body: Container(
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(height: 50.0,),
                Center(
                  child: Text('Log-In', style: TextStyle(fontSize: 28.0, color: Colors.white),),
                ),
                Container(
                  height: MediaQuery.of(context).size.height/2,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 60.0, bottom: 10.0),
                  child: Form(
                    key: this._logInKey,
                    child: ListView(
                      children: [
                        commonTextFormField(hintText: 'Email', validator: (String? inputVal){
                          if(!emailRegex.hasMatch(inputVal.toString())) {
                            return 'Email Format not Matching';
                          }
                          return null;
                        }, textEditingController: this._email),
                        commonTextFormField(hintText: 'Password', validator: (String? inputVal) {
                          if (inputVal!.length < 6) {
                            return 'Password must contain at least 6 characters';
                          }
                          return null;
                        }, textEditingController: this._password),
                        logInAuthButton(context, 'Log-In'),
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
                switchAnotherAuthString(context, "Don't have an account? ", 'Sign-Up')
              ],
            ),
          ),
        ));
  }

  Widget logInAuthButton(BuildContext context, String buttonName) {
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
          if(this._logInKey.currentState!.validate()){
            print('Validated');
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          }else{
            print('Not Validated');
          }
        },
      ),
    );
  }
}
