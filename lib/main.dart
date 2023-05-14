import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smile/Backend/firebase/OnlineDatabaseManagement/cloud_data_management.dart';
import 'package:smile/FrontEnd/AuthUI/log_in.dart';
import 'package:smile/FrontEnd/MainScreens/main_screen.dart';
import 'package:smile/FrontEnd/NewUserEntry/new_user_entry.dart';
import 'FrontEnd/AuthUI/sign_up.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    title: 'smile',
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.dark,
    home: await differentContextDecisionTake(),
  ));
}

Future<Widget> differentContextDecisionTake() async {
  if (FirebaseAuth.instance.currentUser == null) {
    return LogInScreen();
  } else {
    final CloudStoreDataManagement _cloudStoreDataManagement =
        CloudStoreDataManagement();

    final bool _dataPresentResponse =
        await _cloudStoreDataManagement.userRecordPresentOrNot(
            email: FirebaseAuth.instance.currentUser!.email.toString());

    return _dataPresentResponse ? MainScreen() : TakePrimaryUserData();
  }
}
