import 'dart:convert';

import 'package:api_demo/model/login_submit_username_response.dart';
import 'package:api_demo/repo/service_api_constants.dart';
import 'package:dio/dio.dart';

import 'NetworkException.dart';
import 'Network_helper.dart';
import 'networking_response.dart';

class DataRepository{
  Future<NetworkingResponse> loginSubmitUserName(String userName) async {
    try{

      Map data = {
        'username': userName
      };
      var dio =  await NetworkHelper().getApiClient(false);
      Response response = await dio.post(loginSubmitUsername,data: data);
      var responseData = json.decode(response.data);
      print(responseData);
      return LoginSubmitUsernameResponse(LoginSubmitUsernameVo.fromJson(responseData));
    }catch(exception){
      print(exception.toString());
      // var responseData = json.decode(exception.response.data);
      return NetworkingException(NetworkExceptions.fromDioException(exception));
    }
  }
}