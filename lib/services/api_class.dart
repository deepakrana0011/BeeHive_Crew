import 'dart:convert';
import 'dart:io';
import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/model/add_crew_by_manager_response.dart';
import 'package:beehive/model/add_crew_response_manager.dart';
import 'package:beehive/model/add_note_manager_response.dart';
import 'package:beehive/model/assign_project_response_manager.dart';
import 'package:beehive/model/check_in_response_crew.dart';
import 'package:beehive/model/dashboard_manager_response.dart';
import 'package:beehive/model/email_verification_response_manager.dart';
import 'package:beehive/model/email_verified_response_manager.dart';
import 'package:beehive/model/get_assinged_crew_manager.dart';
import 'package:beehive/model/get_crew_profile_response.dart';
import 'package:beehive/model/get_otp_fro_password.dart';
import 'package:beehive/model/login_response_manager.dart';
import 'package:beehive/model/phone_otp_response_manager.dart';
import 'package:beehive/model/project_details_response_manager.dart';
import 'package:beehive/model/project_settings_break_request_manager.dart';
import 'package:beehive/model/project_settings_response_manager.dart';
import 'package:beehive/model/resend_otp_response.dart';
import 'package:beehive/model/resend_top_by_phone_crew_response.dart';
import 'package:beehive/model/reset_password_by_phone_response.dart';
import 'package:beehive/model/reset_password_response_crew.dart';
import 'package:beehive/model/set_crew_rate_Manger_response.dart';
import 'package:beehive/model/set_project_rate_request.dart';
import 'package:beehive/model/update_crew_profile_response.dart';
import 'package:beehive/model/weekly_check_in_Response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../constants/api_constants.dart';
import '../model/create_project_response_manager.dart';
import '../model/crew_dashboard_response.dart';
import '../model/dash_board_page_response_crew.dart';
import '../model/edit_profile_response_manager.dart';
import '../model/get_otp_response_manager.dart';
import '../model/get_profile_response_manager.dart';
import '../model/sign_up_manager_response.dart';
import '../model/verify_otp_response_manager.dart';
import 'fetch_data_expection.dart';

class ApiManager {

  var profileImage;
  var companyLogo;
  Dio dio = Dio();
  Future<SignUpResponse> signUp(
    BuildContext context,
    String name,
    String email,
    password,
  ) async {
    try {
      var map = {"name": name, "email": email, "password": password};
      var response = await dio.post(
          ApiConstantsManager.BASEURL + ApiConstantsManager.SIGNUP,
          data: map);
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

  Future<PhoneOtpResponseManager> phoneNumberVerification(
    BuildContext context,
    String countryCode,
    String phoneNumber,
  ) async {
    try {
      dio.options.headers["Authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var map = {
        "countryCode": countryCode,
        "phoneNumber": phoneNumber,
      };
      var response = await dio.post(
          ApiConstantsManager.BASEURL + ApiConstantsManager.PHONE_VERIFICATION,
          data: map);
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

  Future<VerifyOtpResponseManager> verifyOtp(
    BuildContext context,
    String phoneNumber,
    String otp,
  ) async {
    try {
      var map = {
        "verifyCode": otp,
        "phoneNumber": phoneNumber,
      };
      var response = await dio.post(
          ApiConstantsManager.BASEURL + ApiConstantsManager.VERIFY_OTP,
          data: map);
      return VerifyOtpResponseManager.fromJson(
          json.decode(response.toString()));
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

  Future<LoginResponseManager> loginManager(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      var map = {
        "email": email,
        "password": password,
      };
      var response = await dio.post(
          ApiConstantsManager.BASEURL + ApiConstantsManager.MANAGER_LOGIN,
          data: map);
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

  Future<EmailVerificationResponseManager> verifyManagerEmail(
    BuildContext context,
    String email,
  ) async {
    try {
      var map = {
        "email": email,
      };
      var response = await dio.post(
          ApiConstantsManager.BASEURL +
              ApiConstantsManager.VERIFY_MANAGER_EMAIL,
          data: map);
      return EmailVerificationResponseManager.fromJson(
          json.decode(response.toString()));
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

  Future<EmailVerifiedResponseManager> verifyEmailForOtp(
      BuildContext context, String email, String otp) async {
    try {
      var map = {"email": email, "verifyCode": otp};
      var response = await dio.post(
          ApiConstantsManager.BASEURL +
              ApiConstantsManager.VERIFY_EMAIL_FOR_OTP,
          data: map);
      return EmailVerifiedResponseManager.fromJson(
          json.decode(response.toString()));
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

  Future<CreateProjectResponseManager> createProjectManager(
      BuildContext context,
      {required String projectName,
      required String address,
      required String latitude,
      required String longitude,
      required String locationRadius}) async {
    try {
      dio.options.headers["Authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var map = {
        "projectName": projectName,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "locationRadius": locationRadius
      };
      var response = await dio.post(ApiConstantsManager.BASEURL + ApiConstantsManager.CREATE_PROJECT, data: map);
      return CreateProjectResponseManager.fromJson(
          json.decode(response.toString()));
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

  Future<AddCrewResponseManager> getCrewList(
    BuildContext context,
  ) async {
    try {
      dio.options.headers["Authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.get(
        ApiConstantsManager.BASEURL + ApiConstantsManager.GET_CREW_LIST,
      );
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

  Future<GetOtpForResetPasswordResponse> getOtpForPasswordReset(
    BuildContext context,
    String email,
  ) async {
    try {
      var map = {
        "email": email,
      };
      var response = await dio.post(
          ApiConstantsManager.BASEURL +
              ApiConstantsManager.GET_OTP_FOR_PASSWORD,
          data: map);
      return GetOtpForResetPasswordResponse.fromJson(
          json.decode(response.toString()));
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

  Future<GetOtpResponseManager> verifyEmailForResetPassword(
      BuildContext context, String email, String otp) async {
    try {
      var map = {"email": email, "forgotOTP": otp};
      var response = await dio.post(
          ApiConstantsManager.BASEURL +
              ApiConstantsManager.VERIFY_OTP_RESETPASSWORD,
          data: map);
      return GetOtpResponseManager.fromJson(json.decode(response.toString()));
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

  Future<GetOtpResponseManager> resetPasswordManager(
      BuildContext context, String password, String email) async {
    try {
      var map = {"password": password, "email": email};
      var response = await dio.put(
          ApiConstantsManager.BASEURL + ApiConstantsManager.RESET_PASSWORD,
          data: map);
      return GetOtpResponseManager.fromJson(json.decode(response.toString()));
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

  Future<ResetPasswordByPhoneResponse> resetPasswordByPhone(
    BuildContext context,
    String phoneNumber,
  ) async {
    try {
      var map = {
        "phoneNumber": phoneNumber,
      };
      var response = await dio.post(
          ApiConstantsManager.BASEURL +
              ApiConstantsManager.FORGOT_PASSWORD_BY_PHONE,
          data: map);
      return ResetPasswordByPhoneResponse.fromJson(
          json.decode(response.toString()));
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

  Future<EmailVerifiedResponseManager> verifyingOtpByPhone(
      BuildContext context, String phoneNumber, String otp) async {
    try {
      var map = {"phoneNumber": phoneNumber, "forgotOTP": otp};
      var response = await dio.post(
          ApiConstantsManager.BASEURL + ApiConstantsManager.VERIFY_OTP_BY_PHONE,
          data: map);
      return EmailVerifiedResponseManager.fromJson(
          json.decode(response.toString()));
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

  Future<EmailVerifiedResponseManager> resetPasswordByPhoneNumber(
      BuildContext context,
      {required String phoneNumber,
      required String password}) async {
    try {
      var map = {"phoneNumber": phoneNumber, "password": password};
      var response = await dio.post(
          ApiConstantsManager.BASEURL +
              ApiConstantsManager.RESET_PASSWORD_BY_PHONE,
          data: map);
      return EmailVerifiedResponseManager.fromJson(
          json.decode(response.toString()));
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

  Future<AssignProjectResponse> assignProject(
    BuildContext context,
    List<AddCrewData> selectedCrew,
    String projectId,
  ) async {
    try {
      List selectedList = [];
      for (int i = 0; i < selectedCrew.length; i++) {
        selectedList.add(selectedCrew[i].sId);
      }
      var map = {
        "projectId": projectId,
        "crewId": selectedList,
      };
      var response = await dio.post(
          ApiConstantsManager.BASEURL + ApiConstantsManager.ASSIGN_PROJECT,
          data: map);
      return AssignProjectResponse.fromJson(json.decode(response.toString()));
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

  Future<GetAssignedCrewInProject> getAssignedVCrewInProject(
      BuildContext context, String projectId) async {
    try {
      dio.options.headers["Authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.get(
        ApiConstantsManager.BASEURL +
            ApiConstantsManager.GET_ASSIGNED_CREW_IN_PROJECT +
            projectId,
      );
      return GetAssignedCrewInProject.fromJson(
          json.decode(response.toString()));
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

  Future<SetRateForCrewResponse> setProjectRate(
      BuildContext context,
      List<CrewId> selectedCrew,
      String projectId,
      List<TextEditingController> rateList,
      String sameRate,
      bool sameRateOrPerCrew) async {
    try {
      List<SetProjectRateCrew> selectedList = [];
      for (int i = 0; i < selectedCrew.length; i++) {
        var setRate = SetProjectRateCrew();
        setRate.crewId = selectedCrew[i].sId;
        setRate.price = rateList[i].text;
        selectedList.add(setRate);
      }
      var map = sameRateOrPerCrew == true
          ? {
              "assignProjectId": projectId,
              "sameRate": sameRate,
            }
          : {
              "assignProjectId": projectId,
              "projetRate": selectedList,
            };
      dio.options.headers["Authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.post(
          ApiConstantsManager.BASEURL + ApiConstantsManager.SET_RATE_BY_MANAGER,
          data: map);
      return SetRateForCrewResponse.fromJson(json.decode(response.toString()));
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

  Future<ProjectSettingsResponseManager> projectSettingsApi(
      BuildContext context,
      {required List<String> workdays,
      required String projectId,
      required String hoursStarting,
      required String endingHours,
      required String afterHourRate,
        required List<String> breakFrom,
        required List<String> breakTo,
     /* required String breakFrom,
      required String breakTo,*/
      required String roundTimeSheetValue}) async {
    try {
      List<ProjectSettingsBreakRequestManager> breaks=[];
      var breakRequest = ProjectSettingsBreakRequestManager();
      for(int i=0; i<breakFrom.length; i++) {
        breakRequest.from = breakFrom[i];
       breakRequest.to = breakTo[i];
        breaks.add(breakRequest);
      }
      var map = {

        "workDays": workdays,
        "hoursTo":hoursStarting,
        "hoursFrom": endingHours,
        "afterHoursRate": afterHourRate,
        "break": breaks,
        "roundTimesheets": roundTimeSheetValue
      };
      dio.options.headers["Authorization"] = SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.post(ApiConstantsManager.BASEURL + ApiConstantsManager.PROJECT_SETTINGS+projectId, data: map);
      return ProjectSettingsResponseManager.fromJson(json.decode(response.toString()));
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

  Future<ProjectDetailsResponseManager> getCreatedProjectDetails(
      BuildContext context, String projectId) async {
    try {
      dio.options.headers["Authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.get(
        ApiConstantsManager.BASEURL +
            ApiConstantsManager.GET_PROJECT_DETAILS +
            projectId,
      );
      return ProjectDetailsResponseManager.fromJson(
          json.decode(response.toString()));
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

  Future<AddNoteManagerResponse> addNoteApi(BuildContext context,
      {
      required String assignProjectId,
      required String title,
      required String note,
      required List<String> image}) async {
    try {
      List<MultipartFile> imageToUpload =[];
      for(int i =0; i < image.length;i++){
      imageToUpload.add(MultipartFile.fromFileSync(image[i], filename: "image.jpg"));
      }
      var map = {
        "assignProjectId": assignProjectId,
        "title": title,
        "note": note,
        "image": imageToUpload,
      };
      var response = await dio.post(ApiConstantsManager.BASEURL + ApiConstantsManager.ADD_NOTE_MANAGER, data: FormData.fromMap(map));
      return AddNoteManagerResponse.fromJson(json.decode(response.toString()));
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


  Future<DashBoardResponseManager> dashBoardApi(BuildContext context, ) async {
    try {
      dio.options.headers["Authorization"] = SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.get(ApiConstantsManager.BASEURL + ApiConstantsManager.DASHBOARD_API ,);
      return DashBoardResponseManager.fromJson(json.decode(response.toString()));
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

  Future<GetManagerProfileResponse> getManagerProfile(BuildContext context,) async {
    try {
      dio.options.headers["Authorization"] = SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.get(ApiConstantsManager.BASEURL + ApiConstantsManager.GET_MANAGER_PROFILE,);
      return GetManagerProfileResponse.fromJson(json.decode(response.toString()));
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

  Future<EditProfileManagerResponse> updateManagerProfile(
      BuildContext context, {
        required String companyLogoChanged,
        required String profile,
        required String address,
        required String title,
        required String company,
        required String name,
        required String phone,
        required String email,
        required HSVColor color,
        required bool imageChanged,
        required bool companyChanged,
      }) async {
    try {
      profileImage = imageChanged == true ? MultipartFile.fromFileSync(profile, filename: "image.jpg") : null;
      companyLogo = companyChanged == true ? MultipartFile.fromFileSync(companyLogoChanged, filename: "image.jpg") : null;
      var map = imageChanged == true
          ? {
        "companyLogo":companyLogo,
        "profileImage": profileImage,
        "address": address,
        "position": title,
        "company": company,
        "name": name,
        "phoneNumber": phone,
        "email": email,
        "customColor":color
      } : {
        "address": address,
        "position": title,
        "company": company,
        "name": name,
        "phoneNumber": phone,
        "email": email,
        "customColor":color
      };
      dio.options.headers["Authorization"] = SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.post(ApiConstantsManager.BASEURL + ApiConstantsManager.UPDATE_MANAGER_PROFILE ,data: FormData.fromMap(map));
      return EditProfileManagerResponse.fromJson(json.decode(response.toString()));
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
  Future<AddCrewByManagerResponse> addNewCrew(
      BuildContext context, {
        required String profile,
        required String address,
        required String title,
        required String company,
        required String name,
        required String phone,
        required String speciality,
        required String email,
        required String projectId,
        required bool imageChanged,
      }) async {
    try {
      profileImage = imageChanged == true ? MultipartFile.fromFileSync(profile, filename: "image.jpg") : null;
      var map = imageChanged == true
          ? {
        "profileImage": profileImage,
        "address": address,
        "projectId":projectId,
        "position": title,
        "speciality":speciality,
        "company": company,
        "name": name,
        "phoneNumber": phone,
        "email": email,

      } : {
        "address": address,
        "position": title,
        "speciality":speciality,
        "projectId":projectId,
        "company": company,
        "name": name,
        "phoneNumber": phone,
        "email": email,

      };
      dio.options.headers["Authorization"] = SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.post(ApiConstantsManager.BASEURL + ApiConstantsManager.ADD_NEW_CREW_BY_MANAGER ,data: FormData.fromMap(map));
      return AddCrewByManagerResponse.fromJson(json.decode(response.toString()));
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
  Future<ResendOtpResponse> resendOtpApiEmail(BuildContext context, String email) async {
    try {
      var map ={"email": email,};
      var response = await dio.post(ApiConstantsManager.BASEURL + ApiConstantsManager.RESEND_OTP, data: map);
      return ResendOtpResponse.fromJson(json.decode(response.toString()));
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
  Future<ResendOtpByPhoneResponseCrew> resendOtpByPhoneApi(BuildContext context, String phoneNumber, ) async {
    try {
      var map ={"phoneNumber": phoneNumber, };
      var response = await dio.post(ApiConstantsManager.BASEURL + ApiConstantsManager.RESEND_OTP_PHONE, data: map);
      return ResendOtpByPhoneResponseCrew.fromJson(json.decode(response.toString()));
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

class ApiCrew {
  var profileImage;
  Dio dio = Dio();
  Future<SignUpResponse> signUpCrew(BuildContext context, String name, String email, password,) async {
    try {
      var map = {"name": name, "email": email, "password": password};
      var response = await dio
          .post(ApiConstantsCrew.BASEURL + ApiConstantsCrew.SIGNUP, data: map);
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

  Future<PhoneOtpResponseManager> phoneNumberVerificationCrew(
    BuildContext context,
    String countryCode,
    String phoneNumber,
  ) async {
    try {
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var map = {
        "countryCode": countryCode,
        "phoneNumber": phoneNumber,
      };
      var response = await dio.post(
          ApiConstantsCrew.BASEURL + ApiConstantsCrew.PHONE_VERIFICATION,
          data: map);
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

  Future<VerifyOtpResponseManager> verifyOtpCrewPhone(
    BuildContext context,
    String phoneNumber,
    String otp,
  ) async {
    try {
      var map = {
        "verifyCode": otp,
        "phoneNumber": phoneNumber,
      };
      var response = await dio.post(
          ApiConstantsCrew.BASEURL + ApiConstantsCrew.VERIFY_OTP,
          data: map);
      return VerifyOtpResponseManager.fromJson(
          json.decode(response.toString()));
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

  Future<LoginResponseManager> loginCrew(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      var map = {
        "email": email,
        "password": password,
      };
      var response = await dio.post(
          ApiConstantsCrew.BASEURL + ApiConstantsCrew.CREW_LOGIN,
          data: map);
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

  Future<ResetPasswordResponseCrew> resetPasswordCrew(
      BuildContext context, String password, String email) async {
    try {
      var map = {"password": password, "email": email};
      var response = await dio.put(
          ApiConstantsCrew.BASEURL + ApiConstantsCrew.RESET_PASSWORD,
          data: map);
      return ResetPasswordResponseCrew.fromJson(
          json.decode(response.toString()));
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

  Future<EmailVerificationResponseManager> verifyCrewEmail(
    BuildContext context,
    String email,
  ) async {
    try {
      var map = {
        "email": email,
      };
      var response = await dio.post(
          ApiConstantsCrew.BASEURL + ApiConstantsCrew.VERIFY_CREW_EMAIL,
          data: map);
      return EmailVerificationResponseManager.fromJson(
          json.decode(response.toString()));
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

  Future<EmailVerifiedResponseManager> verifyEmailForOtp(
      BuildContext context, String email, String otp) async {
    try {
      var map = {"email": email, "verifyCode": otp};
      var response = await dio.post(
          ApiConstantsCrew.BASEURL + ApiConstantsCrew.VERIFY_EMAIL_OTP,
          data: map);
      return EmailVerifiedResponseManager.fromJson(
          json.decode(response.toString()));
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

  Future<GetCrewProfileResponse> getCrewProfile(BuildContext context,) async {
    try {
      dio.options.headers["Authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.get(
        ApiConstantsCrew.BASEURL + ApiConstantsCrew.GET_CREW_PROFILE,
      );
      return GetCrewProfileResponse.fromJson(json.decode(response.toString()));
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

  Future<UpdateCrewProfileResponse> updateCrewProfile(
    BuildContext context, {
    required String profile,
    required String address,
    required String title,
    required String speciality,
    required String company,
    required String name,
    required String phone,
    required String email,
    required bool imageChanged,
  }) async {
    try {
      profileImage = imageChanged == true ? MultipartFile.fromFileSync(profile, filename: "image.jpg") : null;
      var map = imageChanged == true
          ? {
              "profileImage": profileImage,
              "address": address,
              "position": title,
              "speciality": speciality,
              "company": company,
              "name": name,
              "phoneNumber": phone,
              "email": email
            }
          : {
              "address": address,
              "position": title,
              "speciality": speciality,
              "company": company,
              "name": name,
              "phone": phone,
              "email": email
            };
      var response = await dio.put(ApiConstantsCrew.BASEURL + ApiConstantsCrew.UPDATE_CREW_PROFILE + SharedPreference.prefs!.getString(SharedPreference.USER_ID)!,data: FormData.fromMap(map));
      return UpdateCrewProfileResponse.fromJson(json.decode(response.toString()));
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

  Future<GetOtpForResetPasswordResponse> getOtpForPasswordResetCrew(
    BuildContext context,
    String email,
  ) async {
    try {
      var map = {
        "email": email,
      };
      var response = await dio.post(
          ApiConstantsCrew.BASEURL + ApiConstantsCrew.GET_OTP_FOR_PASSWORD,
          data: map);
      return GetOtpForResetPasswordResponse.fromJson(
          json.decode(response.toString()));
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

  Future<GetOtpResponseManager> verifyEmailForResetPassword(
      BuildContext context, String email, String otp) async {
    try {
      var map = {"email": email, "forgotOTP": otp};
      var response = await dio.post(
          ApiConstantsCrew.BASEURL + ApiConstantsCrew.VERIFY_OTP_RESETPASSWORD,
          data: map);
      return GetOtpResponseManager.fromJson(json.decode(response.toString()));
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

  Future<ResetPasswordByPhoneResponse> resetPasswordByPhone(
    BuildContext context,
    String phoneNumber,
  ) async {
    try {
      var map = {
        "phoneNumber": phoneNumber,
      };
      var response = await dio.post(
          ApiConstantsCrew.BASEURL + ApiConstantsCrew.RESET_PASSWORD_BY_PHONE,
          data: map);
      return ResetPasswordByPhoneResponse.fromJson(
          json.decode(response.toString()));
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

  Future<EmailVerifiedResponseManager> verifyingOtpByPhone(
      BuildContext context, String phoneNumber, String otp) async {
    try {
      var map = {"phoneNumber": phoneNumber, "forgotOTP": otp};
      var response = await dio.post(
          ApiConstantsCrew.BASEURL + ApiConstantsCrew.VERIFYINNG_BY_PHONE,
          data: map);
      return EmailVerifiedResponseManager.fromJson(
          json.decode(response.toString()));
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

  Future<EmailVerifiedResponseManager> resetPasswordByPhoneNumber(
      BuildContext context, String phoneNumber, String password) async {
    try {
      var map = {"phoneNumber": phoneNumber, "password": password};
      var response = await dio.post(ApiConstantsCrew.BASEURL + ApiConstantsCrew.RESET_PASSWORD_BY_PHONE_NUMBER, data: map);
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
  Future<CrewDashboardResponse> dashBoardApi(BuildContext context, ) async {
    try {
      dio.options.headers["Authorization"] = SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.post(ApiConstantsCrew.BASEURL + ApiConstantsCrew.DASHBOARD_API);
      var responseString=response.toString();
      print("response string is ${responseString}");
      return CrewDashboardResponse.fromJson(json.decode(response.toString()));
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
  Future<WeeklyCheckInResponse> weeklyChekIn(BuildContext context, String weekTo, String weekFrom) async {
    try {
      var map = {
        "firstDate":weekTo,
        "secondDate":weekFrom
      } ;
      dio.options.headers["Authorization"] = SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.post(ApiConstantsCrew.BASEURL + ApiConstantsCrew.WEEKLY_CHECKIN, data: map);
      return WeeklyCheckInResponse.fromJson(json.decode(response.toString()));
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

  Future<CheckInResponseCrew> checkInApi(BuildContext context, String assignProjectId, String checkInTime) async {
    try {
      var map = {"assignProjectId": assignProjectId, "checkInTime": checkInTime};
      dio.options.headers["Authorization"] = SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.post(ApiConstantsCrew.BASEURL + ApiConstantsCrew.CHECK_IN_CREW, data: map);
      return CheckInResponseCrew.fromJson(json.decode(response.toString()));
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
  Future<ResendOtpResponse> resendOtpEmailApi(BuildContext context, String email,) async {
    try {
      var map = {"email": email, };
      var response = await dio.post(ApiConstantsCrew.BASEURL + ApiConstantsCrew.RESEND_OTP_EMAIL, data: map);
      return ResendOtpResponse.fromJson(json.decode(response.toString()));
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
  Future<ResendOtpByPhoneResponseCrew> resendOtpByPhoneApi(BuildContext context, String phoneNumber, ) async {
    try {
      var map ={"phoneNumber": phoneNumber, };
      var response = await dio.post(ApiConstantsCrew.BASEURL + ApiConstantsCrew.RESEND_OTP_PHONE, data: map);
      return ResendOtpByPhoneResponseCrew.fromJson(json.decode(response.toString()));
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
  Future<CheckInResponseCrew> checkOutApiCrew(BuildContext context, String assignProjectId, String checkOutTime) async {
    try {
      var map = {"checkOutTime": checkOutTime, };
      dio.options.headers["Authorization"] = SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.put(ApiConstantsCrew.BASEURL + ApiConstantsCrew.CHECK_OUT_API+assignProjectId, data: map);
      return CheckInResponseCrew.fromJson(json.decode(response.toString()));
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
