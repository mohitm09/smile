import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smile/BackEnd/Firebase/Auth/email_and_pwd_auth.dart';
import 'package:smile/BackEnd/Firebase/Auth/google_auth.dart';
import 'package:smile/FrontEnd/AuthUI/log_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GoogleAuthentication _googleAuthentication = GoogleAuthentication();
  final EmailAndPasswordAuth _emailAndPasswordAuth = EmailAndPasswordAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          child: Text('Log Out'),
          onPressed: () async {
           final bool response = await this._googleAuthentication.logOut();

           if(!response){
             await this._emailAndPasswordAuth.logOut();
           }
           Navigator.pushAndRemoveUntil(
               context,
               MaterialPageRoute(builder: (_) => LogInScreen()),
                   (route) => false);


          },
        ),
      ),
    );
  }
}
