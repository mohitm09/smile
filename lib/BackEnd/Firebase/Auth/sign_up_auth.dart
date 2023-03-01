import 'package:firebase_auth/firebase_auth.dart';
import 'package:smile/Global_Users/enum_generation.dart';

class EmailAndPasswordAuth{

  Future<EmailSignUpResults> signUpAuth({required String email, required String password})async{
    try{
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user!.email != null){
        await userCredential.user!.sendEmailVerification();
        return EmailSignUpResults.SignUpCompleted;
      }
      return EmailSignUpResults.SignUpNotCompleted;

    }catch(e){
      print('Error in Email and Password SignUp: ${e.toString()}');
      return EmailSignUpResults.EmailAlreadtExist;
    }
  }
}