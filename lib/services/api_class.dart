import 'dart:convert';
import 'dart:io';
import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/locator.dart';
import 'package:beehive/model/add_certificate_response.dart';
import 'package:beehive/model/add_crew_by_manager_response.dart';
import 'package:beehive/model/add_crew_response_manager.dart';
import 'package:beehive/model/add_note_manager_response.dart';
import 'package:beehive/model/all_archive_projects_response.dart';
import 'package:beehive/model/all_projects_manager_response.dart';
import 'package:beehive/model/assign_project_response_manager.dart';
import 'package:beehive/model/change_password_response.dart';
import 'package:beehive/model/check_in_response_crew.dart';
import 'package:beehive/model/create_project_request.dart';
import 'package:beehive/model/create_project_response.dart';
import 'package:beehive/model/crew_on_this_project_response.dart';
import 'package:beehive/model/manager_dashboard_response.dart';
import 'package:beehive/model/email_verification_response_manager.dart';
import 'package:beehive/model/email_verified_response_manager.dart';
import 'package:beehive/model/get_assinged_crew_manager.dart';
import 'package:beehive/model/get_crew_profile_response.dart';
import 'package:beehive/model/get_otp_fro_password.dart';
import 'package:beehive/model/login_response_manager.dart';
import 'package:beehive/model/phone_otp_response_manager.dart';
import 'package:beehive/model/private_note_response_manager.dart';
import 'package:beehive/model/project_detail_crew_response.dart';
import 'package:beehive/model/project_detail_manager_response.dart';
import 'package:beehive/model/project_schduele_manager_crew.dart';
import 'package:beehive/model/project_settings_break_request_manager.dart';
import 'package:beehive/model/project_settings_response_manager.dart';
import 'package:beehive/model/project_timesheet_response.dart';
import 'package:beehive/model/resend_otp_response.dart';
import 'package:beehive/model/resend_top_by_phone_crew_response.dart';
import 'package:beehive/model/reset_password_by_phone_response.dart';
import 'package:beehive/model/reset_password_response_crew.dart';
import 'package:beehive/model/set_crew_rate_Manger_response.dart';
import 'package:beehive/model/set_project_rate_request.dart';
import 'package:beehive/model/update_crew_profile_response.dart';
import 'package:beehive/model/update_crew_request.dart';
import 'package:beehive/model/update_project_request.dart';
import 'package:beehive/model/update_project_response.dart';
import 'package:beehive/model/weekly_check_in_Response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../constants/api_constants.dart';
import '../model/allProjectCrewResponse.dart';
import '../model/all_checkout_projects_crew.dart';
import '../model/create_project_response_manager.dart';
import '../model/crew_dashboard_response.dart';
import '../model/dash_board_page_response_crew.dart';
import '../model/edit_profile_response_manager.dart';
import '../model/get_otp_response_manager.dart';
import '../model/get_profile_response_manager.dart';
import '../model/sign_up_manager_response.dart';
import '../model/verify_otp_response_manager.dart';
import 'fetch_data_expection.dart';

class Api {
  var profileImage;
  var companyLogo;
  Dio dio = locator<Dio>();

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

  Future<bool> isEmailExistManager(
    String email,
  ) async {
    try {
      var map = {"email": email};
      var response = await dio.post(
          ApiConstantsManager.BASEURL + ApiConstantsManager.emailExist,
          data: map);
      var data = json.decode(response.toString());
      var status = data["success"];
      return status;
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

  Future<bool> isEmailExistCrew(String email) async {
    try {
      var map = {"email": email};
      var response = await dio.post(
          ApiConstantsCrew.BASEURL + ApiConstantsCrew.emailExist,
          data: map);
      var data = json.decode(response.toString());
      var status = data["success"];
      return status;
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

  Future<PhoneOtpResponseManager> sendOtpSignupPhoneManager(
    BuildContext context,
    String countryCode,
    String phoneNumber,
  ) async {
    try {
      var map = {
        "countryCode": countryCode,
        "phoneNumber": phoneNumber,
      };
      var response = await dio.post(
          ApiConstantsManager.BASEURL +
              ApiConstantsManager.sendOtpSignupPhoneManager,
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

  Future<PhoneOtpResponseManager> sendOtpForgotPhoneManager(
    BuildContext context,
    String countryCode,
    String phoneNumber,
  ) async {
    try {
      var map = {
        "countryCode": countryCode,
        "phoneNumber": phoneNumber,
      };
      var response = await dio.post(
          ApiConstantsManager.BASEURL +
              ApiConstantsManager.sendOtpForgotPhoneManager,
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

  Future<OtpVerificationResponse> verifyOtpSignupPhoneManager(
    BuildContext context,
    String phoneNumber,
    String otp,
    String countryCode,
  ) async {
    try {
      var map = {
        "verifyCode": otp,
        "phoneNumber": phoneNumber,
        "countryCode": countryCode
      };
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.post(
          ApiConstantsManager.BASEURL +
              ApiConstantsManager.verifyOtpSignupPhoneManager,
          data: map);
      return OtpVerificationResponse.fromJson(json.decode(response.toString()));
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

  Future<OtpVerificationResponse> verifyOtpForgotPhoneManager(
    BuildContext context,
    String phoneNumber,
    String otp,
    String countryCode,
  ) async {
    try {
      var map = {
        "forgotOTP": otp,
        "phoneNumber": phoneNumber,
        "countryCode": countryCode
      };
      //dio.options.headers["authorization"] = SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.post(
          ApiConstantsManager.BASEURL +
              ApiConstantsManager.verifyOtpForgotPhoneManager,
          data: map);
      return OtpVerificationResponse.fromJson(json.decode(response.toString()));
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

  Future<EmailVerificationResponseManager> sendOtpForgotEmailManager(
    BuildContext context,
    String email,
  ) async {
    try {
      var map = {
        "email": email,
      };
      var response = await dio.post(
          ApiConstantsManager.BASEURL +
              ApiConstantsManager.sendOtpForgotEmailManager,
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

  Future<OtpVerificationResponse> verifyOtpEmailManager(
      BuildContext context, String email, String otp) async {
    try {
      var map = {"email": email, "forgotOTP": otp};
      var response = await dio.post(
          ApiConstantsManager.BASEURL +
              ApiConstantsManager.verifyOtpEmailManager,
          data: map);
      return OtpVerificationResponse.fromJson(json.decode(response.toString()));
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

  Future<OtpVerificationResponse> verifyOtpEmailCrew(
      BuildContext context, String email, String otp) async {
    try {
      var map = {"email": email, "forgotOTP": otp};
      var response = await dio.post(
          ApiConstantsCrew.BASEURL + ApiConstantsCrew.verifyOtpEmailCrew,
          data: map);
      return OtpVerificationResponse.fromJson(json.decode(response.toString()));
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
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var map = {
        "projectName": projectName,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "locationRadius": locationRadius
      };
      var response = await dio.post(
          ApiConstantsManager.BASEURL + ApiConstantsManager.CREATE_PROJECT,
          data: map);
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
      dio.options.headers["authorization"] =
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

  Future<OtpVerificationResponse> resetPasswordManager(
      BuildContext context, String token,
      {required String password}) async {
    try {
      var map = {"password": password};
      dio.options.headers["authorization"] = token;
      var response = await dio.put(
          ApiConstantsManager.BASEURL +
              ApiConstantsManager.resetPasswordManager,
          data: map);
      return OtpVerificationResponse.fromJson(json.decode(response.toString()));
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
        selectedList.add(selectedCrew[i].id);
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
      dio.options.headers["authorization"] =
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
      dio.options.headers["authorization"] =
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
      List<ProjectSettingsBreakRequestManager> breaks = [];
      var breakRequest = ProjectSettingsBreakRequestManager();
      for (int i = 0; i < breakFrom.length; i++) {
        breakRequest.from = breakFrom[i];
        breakRequest.to = breakTo[i];
        breaks.add(breakRequest);
      }
      var map = {
        "workDays": workdays,
        "hoursTo": hoursStarting,
        "hoursFrom": endingHours,
        "afterHoursRate": afterHourRate,
        "break": breaks,
        "roundTimesheets": roundTimeSheetValue
      };
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.post(
          ApiConstantsManager.BASEURL +
              ApiConstantsManager.PROJECT_SETTINGS +
              projectId,
          data: map);
      return ProjectSettingsResponseManager.fromJson(
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
      {required String assignProjectId,
      required String title,
      required String note,
      required List<String> image}) async {
    try {
      List<MultipartFile> imageToUpload = [];
      for (int i = 0; i < image.length; i++) {
        imageToUpload
            .add(MultipartFile.fromFileSync(image[i], filename: "image.jpg"));
      }
      var map = {
        "assignProjectId": assignProjectId,
        "title": title,
        "note": note,
        "image": imageToUpload,
      };
      var response = await dio.post(
          ApiConstantsManager.BASEURL + ApiConstantsManager.ADD_NOTE_MANAGER,
          data: FormData.fromMap(map));
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

  Future<ManagerDashboardResponse> dashBoardApiManager(
      BuildContext context, String startDate, String endDate) async {
    var map = {"firstDate": startDate, "secondDate": endDate};
    try {
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.post(
          ApiConstantsManager.BASEURL + ApiConstantsManager.DASHBOARD_API,
          data: map);
      return ManagerDashboardResponse.fromJson(json.decode(response.toString()));
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

  Future<GetManagerProfileResponse> getManagerProfile(
    BuildContext context,
  ) async {
    try {
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.get(
        ApiConstantsManager.BASEURL + ApiConstantsManager.GET_MANAGER_PROFILE,
      );
      return GetManagerProfileResponse.fromJson(
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
    required String color,
    required bool imageChanged,
    required bool companyChanged,
  }) async {
    try {
      profileImage = imageChanged == true
          ? MultipartFile.fromFileSync(profile, filename: "image.jpg")
          : null;
      companyLogo = companyChanged == true
          ? MultipartFile.fromFileSync(companyLogoChanged,
              filename: "logo.jpg")
          : null;
      var map = (imageChanged == true || companyChanged == true)
          ? {
              "companyLogo": companyLogo,
              "profileImage": profileImage,
              "address": address,
              "title": title,
              "company": company,
              "name": name,
              "phoneNumber": phone,
              "email": email,
              "customColor": color
            }
          : {
              "address": address,
              "title": title,
              "company": company,
              "name": name,
              "phoneNumber": phone,
              "email": email,
              "customColor": color
            };
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.post(ApiConstantsManager.BASEURL + ApiConstantsManager.UPDATE_MANAGER_PROFILE, data: FormData.fromMap(map));
      return EditProfileManagerResponse.fromJson(
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
      profileImage = imageChanged == true
          ? MultipartFile.fromFileSync(profile, filename: "image.jpg")
          : null;
      var map = imageChanged == true
          ? {
              "profileImage": profileImage,
              "address": address,
              "projectId": projectId,
              "position": title,
              "speciality": speciality,
              "company": company,
              "name": name,
              "phoneNumber": phone,
              "email": email,
            }
          : {
              "address": address,
              "position": title,
              "speciality": speciality,
              "projectId": projectId,
              "company": company,
              "name": name,
              "phoneNumber": phone,
              "email": email,
            };
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.post(
          ApiConstantsManager.BASEURL +
              ApiConstantsManager.ADD_NEW_CREW_BY_MANAGER,
          data: FormData.fromMap(map));
      return AddCrewByManagerResponse.fromJson(
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

  Future<ResendOtpResponse> resendOtpApiEmail(
      BuildContext context, String email) async {
    try {
      var map = {
        "email": email,
      };
      var response = await dio.post(
          ApiConstantsManager.BASEURL + ApiConstantsManager.RESEND_OTP,
          data: map);
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

  Future<ResendOtpByPhoneResponseCrew> resendOtpByPhoneApi(
    BuildContext context,
    String phoneNumber,
  ) async {
    try {
      var map = {
        "phoneNumber": phoneNumber,
      };
      var response = await dio.post(
          ApiConstantsManager.BASEURL + ApiConstantsManager.RESEND_OTP_PHONE,
          data: map);
      return ResendOtpByPhoneResponseCrew.fromJson(
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

  Future<SignUpResponse> signUpCrew(
    BuildContext context,
    String name,
    String email,
    password,
  ) async {
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

  Future<PhoneOtpResponseManager> sendOtpForgotPhoneCrew(
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
          ApiConstantsCrew.BASEURL + ApiConstantsCrew.sendOtpForgotPhoneCrew,
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

  Future<PhoneOtpResponseManager> sendOtpSignupPhoneCrew(
    BuildContext context,
    String countryCode,
    String phoneNumber,
  ) async {
    try {
      // dio.options.headers["authorization"] =
      //     SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var map = {
        "countryCode": countryCode,
        "phoneNumber": phoneNumber,
      };
      var response = await dio.post(
          ApiConstantsCrew.BASEURL + ApiConstantsCrew.sendOtpSignupPhoneCrew,
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

  Future<OtpVerificationResponse> verifyOtpSignupPhoneCrew(
    BuildContext context,
    String phoneNumber,
    String otp,
    String countryCode,
  ) async {
    try {
      var map = {
        "verifyCode": otp,
        "phoneNumber": phoneNumber,
        "countryCode": countryCode,
      };
      var value = SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      dio.options.headers["authorization"] = value;
      var response = await dio.post(
          ApiConstantsCrew.BASEURL + ApiConstantsCrew.verifyOtpSignupPhoneCrew,
          data: map);
      return OtpVerificationResponse.fromJson(json.decode(response.toString()));
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

  Future<OtpVerificationResponse> verifyOtpForgotPhoneCrew(
    BuildContext context,
    String phoneNumber,
    String otp,
    String countryCode,
  ) async {
    try {
      /*dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);*/
      var map = {
        "forgotOTP": otp,
        "phoneNumber": phoneNumber,
        "countryCode": countryCode
      };
      var response = await dio.post(
          ApiConstantsCrew.BASEURL + ApiConstantsCrew.verifyOtpForgotPhoneCrew,
          data: map);
      return OtpVerificationResponse.fromJson(json.decode(response.toString()));
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
      BuildContext context, String password, String token) async {
    try {
      dio.options.headers["authorization"] = token;
      var map = {"password": password};
      var response = await dio.put(
          ApiConstantsCrew.BASEURL + ApiConstantsCrew.resetPasswordCrew,
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

  Future<EmailVerificationResponseManager> sendOtpEmailCrew(
    BuildContext context,
    String email,
  ) async {
    try {
      var map = {
        "email": email,
      };
      var response = await dio.post(
          ApiConstantsCrew.BASEURL + ApiConstantsCrew.sendOtpForgotEmailCrew,
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

  Future<GetCrewProfileResponse> getCrewProfile(
    BuildContext context,
  ) async {
    try {
      dio.options.headers["authorization"] =
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
      profileImage = imageChanged == true
          ? MultipartFile.fromFileSync(profile, filename: "image.jpg")
          : null;
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
              "phoneNumber": phone,
              "email": email
            };
      var response = await dio.put(
          ApiConstantsCrew.BASEURL + ApiConstantsCrew.UPDATE_CREW_PROFILE + SharedPreference.prefs!.getString(SharedPreference.USER_ID)!,
          data: FormData.fromMap(map));
      return UpdateCrewProfileResponse.fromJson(
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

  Future<CrewDashboardResponse> dashBoardApi(
      BuildContext context, String startDate, String endDate) async {
    try {
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var map = {"firstDate": startDate, "secondDate": endDate};
      var response = await dio.post(
          ApiConstantsCrew.BASEURL + ApiConstantsCrew.crewDashboard,
          data: map);
      var responseString = response.toString();
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

  Future<CheckInResponseCrew> checkInApi(
      BuildContext context, String assignProjectId, String checkInTime) async {
    try {
      var map = {
        "assignProjectId": assignProjectId,
        "checkInTime": checkInTime
      };
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
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

  Future<ResendOtpResponse> resendOtpEmailApi(
    BuildContext context,
    String email,
  ) async {
    try {
      var map = {
        "email": email,
      };
      var response = await dio.post(
          ApiConstantsCrew.BASEURL + ApiConstantsCrew.RESEND_OTP_EMAIL,
          data: map);
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

  Future<CheckInResponseCrew> checkOutApiCrew(
      BuildContext context, String assignProjectId, String checkOutTime) async {
    try {
      var map = {
        "checkOutTime": checkOutTime,
      };
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.put(
          ApiConstantsCrew.BASEURL +
              ApiConstantsCrew.CHECK_OUT_API +
              assignProjectId,
          data: map);
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

  Future<CreateProjectResponse> createProject(
      BuildContext context, CreateProjectRequest request) async {
    var requestToServer = request.toJson();
    try {
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.post(ApiConstantsManager.BASEURL + "newproject",
          data: requestToServer);
      return CreateProjectResponse.fromJson(json.decode(response.toString()));
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

  Future<AllProjectCrewResponse> getAllProjectsCrew(
      BuildContext context) async {
    try {
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.get(
        ApiConstantsCrew.BASEURL + ApiConstantsCrew.getAllCrewProjects,
      );
      var responseString = response.toString();
      print("response string ${responseString}");
      return AllProjectCrewResponse.fromJson(json.decode(response.toString()));
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

  Future<AllProjectsManagerResponse> getAllProjectsManager(
      BuildContext context) async {
    try {
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.get(
        ApiConstantsManager.BASEURL + ApiConstantsManager.allProjectsManager,
      );
      var responseString = response.toString();
      print("responseString ${responseString}");
      return AllProjectsManagerResponse.fromJson(json.decode(response.toString()));
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

  Future<AllCheckoutProjectCrewResponse> getAllCheckoutOutCrewProjects(
      BuildContext context) async {
    try {
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.get(
        ApiConstantsCrew.BASEURL + ApiConstantsCrew.getAllCheckoutCrewProjects,
      );
      return AllCheckoutProjectCrewResponse.fromJson(json.decode(response.toString()));
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

  Future<ProjectDetailResponseManager> getProjectDetail(
    BuildContext context,
    String projectId,
    String startDate,
    String endDate,
  ) async {
    try {
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);

      var map = {"firstDate": startDate, "secondDate": endDate};
      var response = await dio.post("${ApiConstantsManager.BASEURL}${ApiConstantsManager.singleProjectDetail}/$projectId", data: map);
      var value=response.toString();
      print("response string $value");
      return ProjectDetailResponseManager.fromJson(json.decode(response.toString()));
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

  Future<Response> updateCrewList(BuildContext context, String projectId,
      UpdateCrewMemberRequest request) async {
    try {
      var requestToServer = request.toJson();
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.put(
          "${ApiConstantsManager.BASEURL}${ApiConstantsManager.updateCrewMember}/$projectId",
          data: requestToServer);
      print("response string ${response.toString()}");
      return response;
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

  Future<ProjectDetailCrewResponse> getProjectDetailCrew(
    BuildContext context,
    String projectId,
    String startDate,
    String endDate,
  ) async {
    try {
      dio.options.headers["authorization"] = SharedPreference.prefs!.getString(SharedPreference.TOKEN);

      var map = {"firstDate": startDate, "secondDate": endDate};
      var response = await dio.post("${ApiConstantsCrew.BASEURL}${ApiConstantsCrew.crewProjectDetail}/$projectId", data: map);
      var responseString = response.toString();
      print("response string ${responseString}");
      return ProjectDetailCrewResponse.fromJson(json.decode(response.toString()));
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

  Future<ProjectScheduleManagerCrew> getProjectSchedulesManagerCrew(
      BuildContext context, String api) async {
    try {
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.post(api);
      return ProjectScheduleManagerCrew.fromJson(json.decode(response.toString()));
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

  Future<CrewOnThisProjectResponse> crewOnThisProject(
      BuildContext context, String id) async {
    try {
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.get(ApiConstantsManager.BASEURL + ApiConstantsManager.crewOnThisProject + id);
      return CrewOnThisProjectResponse.fromJson(json.decode(response.toString()));
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

  Future<AddCertificateResponse> addCertificate(
      BuildContext context, String api, String certImage, String certName) async {
    try {
      var map = <String, dynamic>{"certName": certName};
      var image = MultipartFile.fromFileSync(certImage, filename: "cert_image.jpg");
      var imageMap = {
        'certImage': image,
      };
      map.addAll(imageMap);

      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var response = await dio.post(api, data: FormData.fromMap(map));
      return AddCertificateResponse.fromJson(json.decode(response.toString()));
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

  Future<ChangePasswordResponse> changePassword(
      BuildContext context, String api, String oldPassword, String newPassword) async {
    try {
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var map = {"oldPassword": oldPassword, "password": newPassword};
      var response = await dio.put(api, data: map);
      return ChangePasswordResponse.fromJson(json.decode(response.toString()));
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

  Future<bool> removingCrewOnThisProject(
      BuildContext context, String crewId, String projectId) async {
    try {
      // dio.options.headers["authorization"] =
      //     SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var map = {"crewId" : crewId};

      await dio.delete(ApiConstantsManager.BASEURL + ApiConstantsManager.removingCrew + projectId, data: map);
      return true;
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


  Future<PrivateNoteResponseManager> addingPrivateNote(
      BuildContext context, String crewId, String title, String note) async {
    try {
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);
      var map = {"crewId" : crewId, "title" : title, "note" : note};

      var response = await dio.post(ApiConstantsManager.BASEURL + ApiConstantsManager.addingPrivateNote, data: map);
      return PrivateNoteResponseManager.fromJson(json.decode(response.toString()));
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


  Future<bool> crewLeavingProject(
      BuildContext context, String projectId) async {
    try {
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);

      await dio.delete(ApiConstantsCrew.BASEURL + ApiConstantsCrew.crewLeavingProject + projectId);
      return true;
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

  Future<UpdateProjectResponse> updateProjectByManager(
      BuildContext context, String projectId, UpdateProjectRequest updateProjectRequest) async {
    try {
     var response = await dio.put(ApiConstantsManager.BASEURL + ApiConstantsManager.updateProjectManager + projectId, data: updateProjectRequest);
     return UpdateProjectResponse.fromJson(json.decode(response.toString()));
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

  Future<CreateProjectResponse> archiveProjectByManager(
      BuildContext context, String projectId) async {
    try {
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);

      var response = await dio.put(ApiConstantsManager.BASEURL + ApiConstantsManager.archiveProject + projectId);
      return CreateProjectResponse.fromJson(json.decode(response.toString()));
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

  Future<CreateProjectResponse> deleteProjectByManager(
      BuildContext context, String projectId) async {
    try {
      var response = await dio.put(ApiConstantsManager.BASEURL + ApiConstantsManager.deleteProject + projectId);
      return CreateProjectResponse.fromJson(json.decode(response.toString()));
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

  Future<AllArchiveProjectsResponse> allArchiveProjects(
      BuildContext context) async {
    try {
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);

      var response = await dio.get(ApiConstantsManager.BASEURL + ApiConstantsManager.allArchiveProjects );
      return AllArchiveProjectsResponse.fromJson(json.decode(response.toString()));
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


  Future<AllArchiveProjectsResponse> archiveProjectsCrew(
      BuildContext context) async {
    try {
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);

      var response = await dio.get(ApiConstantsCrew.BASEURL + ApiConstantsCrew.archiveProjects);
      return AllArchiveProjectsResponse.fromJson(json.decode(response.toString()));
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

  Future<CreateProjectResponse> unArchiveProjectByManager(
      BuildContext context, String projectId) async {
    try {
      var response = await dio.put(ApiConstantsManager.BASEURL + ApiConstantsManager.unArchiveProject + projectId);
      return CreateProjectResponse.fromJson(json.decode(response.toString()));
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

  Future<ProjectTimeSheetResponse> projectTimeSheetManager(BuildContext context, String firstDate, String secondDate) async {
    try {
      dio.options.headers["authorization"] =
          SharedPreference.prefs!.getString(SharedPreference.TOKEN);

      var map = {"firstDate": firstDate, "secondDate": secondDate};
      var response = await dio.post(ApiConstantsManager.BASEURL + ApiConstantsManager.projectTimeSheet, data: map);
      return ProjectTimeSheetResponse.fromJson(json.decode(response.toString()));
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
