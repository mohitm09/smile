import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:smile/FrontEnd/AuthUI/common_auth_methods.dart';


class TakePrimaryUserData extends StatefulWidget {
  const TakePrimaryUserData({Key? key}): super(key: key);

  @override
  _TakePrimaryUserDataState createState() => _TakePrimaryUserDataState();
}

class _TakePrimaryUserDataState extends State<TakePrimaryUserData> {

    bool _isLoading = false;

    final GlobalKey<FormState> _takeUserPrimaryInformationKey = GlobalKey<FormState>();
    final TextEditingController _userName = TextEditingController();
    final TextEditingController _userAbout = TextEditingController();

    @override
    Widget build (BuildContext context) {
      return SafeArea(
          child: Scaffold(
            backgroundColor: const Color.fromRGBO(34, 48, 68, 1),
        body: LoadingOverlay(
          isLoading:this._isLoading ,
            child:Container(
              width : MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: this._takeUserPrimaryInformationKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    commonTextFormField(hintText:'User Name', validator: (inputVal){
                      if (inputVal!.length<6)
                        return 'User Name must have 6 characters';
                      return null;

                    }, textEditingController: this._userName),

                    commonTextFormField(hintText:'User About',
                        validator: (inputVal){
                      if (inputVal!.length<6)
                        return 'User About must have 6 characters';
                      return null;

                    }, textEditingController: this._userAbout),

                    _saveUserPrimaryInformation(),



                  ]
                ),
              ),
            )
          ),
      ));
    }
    
    Widget _upperHeading(){
      return Padding(padding: EdgeInsets.only(top: 30.0),
        child :Center(
          child:Text ('Set Up Your Account',style:TextStyle(color:Colors.white,fontSize: 25.0),
          ),
        )
      );
    }

    Widget _saveUserPrimaryInformation() {
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
            'Save',
            style: TextStyle(
                fontSize: 25.0,
                letterSpacing: 1.0,
                fontWeight: FontWeight.w400
            ),
          ),
          onPressed: () async {

            if(this._takeUserPrimaryInformationKey.currentState!.validate()){
              print('Validated');
            }else{
              print('Not Validated');
            }
          },
        ),
      );
    }
}