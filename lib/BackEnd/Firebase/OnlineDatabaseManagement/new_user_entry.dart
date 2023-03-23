import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudStoreDataManagement{

  final _collectionName = 'smile_users';

  Future<bool> checkThisUserAlreadyPresentOrNot(
      { required String userName}) async{
    try{
      final QuerySnapshot<Map<String,dynamic>>  findResults =
      await FirebaseFirestore.instance
          .collection(_collectionName)
          .where('user_name', isEqualTo:userName)
          .get();

      print('Debug 1: ${findResults.docs.isEmpty}');


      return findResults.docs.isEmpty?true:false;
    }catch(e){
      print('Error in Check This User Already Present or not: ${e.toString()}');
      return false;

    }


  }

  Future<bool> registerNewUser (
      {required String userName,
        required String userAbout,
        required String userEmail}) async{
    try{
      final String _getToken = await FirebaseMessaging.instance.getToken().toString();

      final String currDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

      final String currTime = "${DateFormat('hh:mm a').format(DateTime.now())}";


        FirebaseFirestore.instance.doc('$_collectionName/$userEmail').set({
        "about": userAbout,
        "activity":[],
        "connection_request":[],
        "connections": [],
        "creation_date": currDate,
        "creation_time": currTime,
        "phone_number": "",
        "profile_pic": "",
        "token":_getToken.toString(),
        "total_connections":"",
        "user_name":userName,
        });

        return true;



    }catch(e){
      print('Error in Register ne user :${e.toString()}');
      return false;
    }
  }
  }