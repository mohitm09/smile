import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:smile/BackEnd/Firebase/Auth/email_and_pwd_auth.dart';
import 'package:smile/FrontEnd/NewUserEntry/new_user_entry.dart';
import 'package:smile/FrontEnd/home_page.dart';
import 'package:smile/Global_Users/enum_generation.dart';

import '../../BackEnd/Firebase/Auth/google_auth.dart';
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

  final EmailAndPasswordAuth _emailAndPasswordAuth = EmailAndPasswordAuth();
  final GoogleAuthentication _googleAuthentication = GoogleAuthentication();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(34, 48, 68, 1),
          body: LoadingOverlay(
            isLoading: this._isLoading,
            color:Colors.black,
            child: Container(
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
                  logInSocialMediaIntegrationButtons(),
                  switchAnotherAuthString(context, "Don't have an account? ", 'Sign-Up')
                ],
              ),
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

            if(mounted){
              setState(() {
                this._isLoading = true;
              });
            }

            final EmailSignInResults emailSignInResults = await _emailAndPasswordAuth.signInWithEmailAndPassword(email: this._email.text, password: this._password.text);

            String msg = '';
            if(emailSignInResults == EmailSignInResults.SignInCompleted){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => TakePrimaryUserData()), (route) => false);
            }
            else if(emailSignInResults == EmailSignInResults.EmailNotVerified){
              msg = 'Email not verified. \nPlease verify your email and then LogIn';
            }
            else if(emailSignInResults == EmailSignInResults.EmailOrPasswordInvalid){
              msg = 'Invalid Email or Password';
            }else{
              msg = 'SignIn not Completed';
            }

            if(msg != ''){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
            }

            if(mounted){
              setState(() {
                this._isLoading = false;
              });
            }
            
          }else{
            print('Not Validated');
          }
        },
      ),
    );
  }
  Widget logInSocialMediaIntegrationButtons() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () async {
                print('Google Pressed');
                if (mounted){
                  setState(() {
                    this._isLoading = true;
                  });
                }

                final GoogleSignInResults _googleSignInResults = await this._googleAuthentication.signInWithGoogle();

                String msg ='';

                if (_googleSignInResults == GoogleSignInResults.SignInCompleted) {
                  msg = 'Sign In Completed';

                }else if(_googleSignInResults==GoogleSignInResults.SignInNotCompleted)
                  msg='Sign In Not Completed';
                else if(_googleSignInResults==GoogleSignInResults.AlreadySignedIn)
                  msg='Already SignedIn';
                else
                  msg ='Unexpected Error Message';

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));


                if (_googleSignInResults == GoogleSignInResults.SignInCompleted)
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => TakePrimaryUserData()),
                          (route) => false);


                if (mounted){
                  setState(() {
                    this._isLoading = false;
                  });
                }

              }, child: Image.asset(
            'assets/images/google.png',width: 50.0,
          )
          ),
          // SizedBox(width: 80.0,),
          // GestureDetector(
          //   onTap: () {
          //     print('Facebook Pressed');
          //   },child: Image.asset('assets/images/fbook.png',width: 50.0,
          // )),
        ],
      ),
    );
  }

}
