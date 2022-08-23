import 'dart:convert';
import 'dart:io';

import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/model/add_crew_response_manager.dart';
import 'package:beehive/model/email_verification_response_manager.dart';
import 'package:beehive/model/email_verified_response_manager.dart';
import 'package:beehive/model/login_response_manager.dart';
import 'package:beehive/model/phone_otp_response_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../constants/api_constants.dart';
import '../model/create_project_response_manager.dart';
import '../model/sign_up_manager_response.dart';
import '../model/verify_otp_response_manager.dart';
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

  Future<PhoneOtpResponseManager> phoneNumberVerification(BuildContext context,String countryCode, String phoneNumber, ) async {
    try {
      dio.options.headers["Authorization"] =SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var map = {"countryCode": countryCode, "phoneNumber": phoneNumber,};
      var response = await dio.post(ApiConstants.BASEURL + ApiConstants.PHONE_VERIFICATION, data: map);
      return PhoneOtpResponseManager.fromJson(json.decode(response.toString()));
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

  Future<VerifyOtpResponseManager> verifyOtp(BuildContext context, String phoneNumber,String otp, ) async {
    try {
      var map = {"verifyCode": otp, "phoneNumber": phoneNumber,};
      var response = await dio.post(ApiConstants.BASEURL + ApiConstants.VERIFY_OTP, data: map);
      return VerifyOtpResponseManager.fromJson(json.decode(response.toString()));
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

  Future<LoginResponseManager> loginManager(BuildContext context, String email,String password, ) async {
    try {
      var map = {"email": email, "password": password,};
      var response = await dio.post(ApiConstants.BASEURL + ApiConstants.MANAGER_LOGIN, data: map);
      return LoginResponseManager.fromJson(json.decode(response.toString()));
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



  Future<EmailVerificationResponseManager> verifyManagerEmail(BuildContext context, String email, ) async {
    try {
      var map = {"email": email,};
      var response = await dio.post(ApiConstants.BASEURL + ApiConstants.VERIFY_MANAGER_EMAIL, data: map);
      return EmailVerificationResponseManager.fromJson(json.decode(response.toString()));
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


  Future<EmailVerifiedResponseManager> verifyEmailForOtp(BuildContext context, String email,String otp ) async {
    try {
      var map = {"email": email,"verifyCode":otp};
      var response = await dio.post(ApiConstants.BASEURL + ApiConstants.VERIFY_EMAIL_FOR_OTP, data: map);
      return EmailVerifiedResponseManager.fromJson(json.decode(response.toString()));
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
  Future<CreateProjectResponseManager> createProjectManager(BuildContext context,
      {required String projectName,
      required String address,
      required String latitude,
      required String longitude,
      required String locationRadius}) async {
    try {
      dio.options.headers["Authorization"] = SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var map = {"projectName": projectName,"address":address,"latitude":latitude,"longitude":longitude,"locationRadius":locationRadius};
      var response = await dio.post(ApiConstants.BASEURL + ApiConstants.CREATE_PROJECT, data: map);
      return CreateProjectResponseManager.fromJson(json.decode(response.toString()));
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

  Future<AddCrewResponseManager> getCrewList(BuildContext context,) async {
    try {
      dio.options.headers["Authorization"] = SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.get(ApiConstants.BASEURL + ApiConstants.GET_CREW_LIST,);
      return AddCrewResponseManager.fromJson(json.decode(response.toString()));
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