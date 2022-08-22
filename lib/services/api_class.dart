import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../constants/api_constants.dart';
import '../model/sign_up_manager_response.dart';
import 'fetch_data_expection.dart';

class Api{
  Dio dio = Dio();
  Future<SignUpResponse> signUp(BuildContext context,String name, String email, password,) async {
    try {
      var map = {"name": name, "email": email, "password": password};
      var response = await dio.post(ApiConstants.BASEURL + ApiConstants.SIGNUP, data: map);
      return SignUpResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw const SocketException("Socket Exception");
      }
    }
  }
















}