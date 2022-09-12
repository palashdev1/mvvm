import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/repository/auth_repository.dart';
import 'package:mvvm/utils/utils.dart';

class AuthViewModel with ChangeNotifier{
  final _myRepo = AuthRepository();

  Future<void> loginApi(dynamic data, BuildContext context) async{

    _myRepo.loginApi(data).then((value) {
      if(kDebugMode){
        print(value.toString());
      }
      
    }).onError((error, stackTrace) {
      if(kDebugMode){
        print(error.toString());
        Utils.flushBarErrorMessage(error.toString(), context);

      }
    });

  }
}