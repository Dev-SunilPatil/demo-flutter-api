
import 'package:api_demo/model/login_submit_username_response.dart';

import 'NetworkException.dart';

class NetworkingResponse {

}

class NetworkingException extends NetworkingResponse {
  NetworkExceptions exceptions;
  NetworkingException(this.exceptions);
}


class LoginSubmitUsernameResponse extends NetworkingResponse{
  LoginSubmitUsernameVo loginSubmitUsernameVo;
  LoginSubmitUsernameResponse(this.loginSubmitUsernameVo);
}


