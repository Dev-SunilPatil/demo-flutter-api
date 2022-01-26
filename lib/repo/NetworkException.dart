import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class NetworkExceptions {
  int? responseCode =0;
  String errorMessage='';
  Object? exception;

  NetworkExceptions.fromDioException(Object error) {
    exception=error ;
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              errorMessage = "Request Cancelled";
              break;
            case DioErrorType.connectTimeout:
              errorMessage = "Connection request timeout";
              break;
            case DioErrorType.receiveTimeout:
              errorMessage = "Send timeout in connection with API server";
              break;
            case DioErrorType.response:
              switch (error.response?.statusCode) {
                case 400:
                case 403:
                case 401:
                  errorMessage = "Unauthorised request";
                  break;
                case 404:
                  errorMessage = "Not found";
                  break;
                case 409:
                  errorMessage = "Error due to a conflict";
                  break;
                case 408:
                  errorMessage = "Connection request timeout";
                  break;
                case 500:
                  errorMessage = "Internal Server Error";
                  break;
                case 503:
                  errorMessage = "Service unavailable";
                  break;
                default:
                  responseCode = error.response?.statusCode!;
                  errorMessage = "Received invalid status code:";
              }
              break;
            case DioErrorType.sendTimeout:
              errorMessage = "Send timeout in connection with API server";
              break;
            case DioErrorType.other:
              errorMessage = "Unexpected error occurred";
              break;
          }
          try {
            Map<String, dynamic> map  = jsonDecode(error.response?.data);
            errorMessage = map['error'];
          } catch (e) {
            print(e.toString());
          }
        } else if (error is SocketException) {
          errorMessage = "No internet connection";
        } else {
          errorMessage = "Unexpected error occurred";
        }
      } catch (e) {
        errorMessage = "Unexpected error occurred";
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        errorMessage = "Unable to process the data";
      } else {
        errorMessage = "Unexpected error occurred";
      }
    }
    print('errorMessage-->' + errorMessage);
  }
}
