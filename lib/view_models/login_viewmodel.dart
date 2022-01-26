import 'package:api_demo/repo/data_repository.dart';
import 'package:api_demo/repo/networking_response.dart';
import 'package:api_demo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageViewModel extends ChangeNotifier {
  Future<bool> isShowHomePage() async {
    final prefs = await SharedPreferences.getInstance();
    //await Future.delayed(Duration(seconds: 3));
    return prefs.getBool(prefKeyShowDashboard) ?? false;
  }

  Future<dynamic?> loginSubmitUsernameRequest(String? emailID) async {

      print("EMAIL:" + emailID!);

    NetworkingResponse loginSubmitUsernameResponse =
    await DataRepository().loginSubmitUserName(emailID!);
    if (loginSubmitUsernameResponse is LoginSubmitUsernameResponse) {
      // if (kDebugMode) {
        print(
            'loginSubmitUsernameResponse.loginSubmitUsernameVo.loginCodeIsRequired-->' +
                loginSubmitUsernameResponse
                    .loginSubmitUsernameVo.loginCodeIsRequired
                    .toString());
        print(
            'loginSubmitUsernameResponse.loginSubmitUsernameVo.responseDateTime-->' +
                loginSubmitUsernameResponse
                    .loginSubmitUsernameVo.responseDateTime!);
      // }
      return loginSubmitUsernameResponse.loginSubmitUsernameVo;
    }else if (loginSubmitUsernameResponse is NetworkingException){
      return loginSubmitUsernameResponse.exceptions;
    }else if(loginSubmitUsernameResponse !=null){
      return loginSubmitUsernameResponse;
    }
    return null;

  }


}