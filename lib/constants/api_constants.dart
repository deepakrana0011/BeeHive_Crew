
// client live url = 35.183.39.183:8081
// local live url = 3.235.151.126:8081
class ApiConstantsManager {
  static const String BASEURL = "http://35.183.39.183:8081/Manager/";
  static const String SIGNUP = "managerregister";
  static const String emailExist = "emailExist";

  static const String sendOtpSignupPhoneManager = "sendOtpSignupPhoneManager";
  static const String sendOtpForgotPhoneManager = "sendOtpForgotPhoneManager";
  static const String verifyOtpSignupPhoneManager =
      "verifyOtpSignupPhoneManager";
  static const String verifyOtpForgotPhoneManager =
      "verifyOtpForgotPhoneManager";
  static const String verifyOtpEmailManager = "verifyOtpEmailManager";
  static const String sendOtpForgotEmailManager = "sendOtpForgotEmailManager";
  static const String allProjectsManager = "allProjects";
  static const String singleProjectDetail = "singleProjectDetails";
  static const String updateCrewMember = "updateCrewOnProject";

  static const String MANAGER_LOGIN = "managerlogin";
  static const String CREATE_PROJECT = "newproject";
  static const String GET_CREW_LIST = "gettingallcrew";
  static const String GET_OTP_FOR_PASSWORD = "forgotpassword";

  static const String ASSIGN_PROJECT = "assignproject";
  static const String FORGOT_PASSWORD_BY_PHONE = "forgotPbyphone";
  static const String VERIFY_OTP_BY_PHONE = "verifymanagerbyphone";
  static const String resetPasswordManager = "resetPassword";
  static const String GET_ASSIGNED_CREW_IN_PROJECT = "assignedprojectbyid/";
  static const String SET_RATE_BY_MANAGER = "projectprice";
  static const String PROJECT_SETTINGS = "projectsettings/";
  static const String GET_PROJECT_DETAILS = "projectdetails/";
  static const String ADD_NOTE_MANAGER = "addingnote";
  static const String DASHBOARD_API = "managerdashboard";
  static const String GET_MANAGER_PROFILE = "getManagerProfile";
  static const String UPDATE_MANAGER_PROFILE = "updatemanagerprofile";
  static const String ADD_NEW_CREW_BY_MANAGER = "addingcrew";
  static const String RESEND_OTP = "resend";
  static const String RESEND_OTP_PHONE = "resendtokenonphone";

  static const String managerProjectSchedule = "projectSchedule";
  static const String crewOnThisProject = "crewOnThisProject/";
  static const String managerCertificates = "managerCertificates";
  static const String managerNewPassword = "managerNewPassword";
  static const String removingCrew = "managerRemovingCrew/";
  static const String addingPrivateNote = "addingPrivateNote";
  static const String updateProjectManager = "updateProjectSetting/";
  static const String archiveProject = "archiveProject/";
  static const String deleteProject = "deleteProject/";
  static const String allArchiveProjects = "allArchiveProjects";
}

class ApiConstantsCrew {
  static const String BASEURL = "http://35.183.39.183:8081/Crew/";
  static const String BASE_URL_IMAGE = "http://35.183.39.183:8081/";
  static const String emailExist = "emailExist";
  static const String SIGNUP = "crewsignup";

  static const String sendOtpSignupPhoneCrew = "sendOtpSignupPhoneCrew";
  static const String sendOtpForgotPhoneCrew = "sendOtpForgotPhoneCrew";
  static const String verifyOtpSignupPhoneCrew = "verifyOtpSignupPhoneCrew";
  static const String verifyOtpForgotPhoneCrew = "verifyOtpForgotPhoneCrew";
  static const String verifyOtpEmailCrew = "verifyOtpEmailCrew";
  static const String sendOtpForgotEmailCrew = "sendOtpForgotEmailCrew";
  static const String crewProjectDetail = "singleProjectDetails";

  static const String CREW_LOGIN = "crewlogin";
  static const String resetPasswordCrew = "resetPassword";

  static const String GET_CREW_PROFILE = "getCrewProfile";
  static const String UPDATE_CREW_PROFILE = "updateprofile/";
  static const String GET_OTP_FOR_PASSWORD = "forgotpassword";
  static const String VERIFY_OTP_RESETPASSWORD = "verifyforgot";
  static const String RESET_PASSWORD_BY_PHONE = "forgotbyphone";
  static const String RESET_PASSWORD_BY_PHONE_NUMBER = "resettbyphone";
  static const String DASHBOARD_API = "dashboard";
  static const String crewDashboard = "crewDashboard";
  static const String CHECK_IN_CREW = "checkintime";
  static const String RESEND_OTP_PHONE = "resendtokenonphone";
  static const String RESEND_OTP_EMAIL = "resend";
  static const String CHECK_OUT_API = "checkouttime/";


  static const String getAllCrewProjects = "crewActiveProjects";
  static const String getAllCheckoutCrewProjects = "crewProjectsWithHours";

  static const String crewProjectSchedule = "crewProjectSchedule";
  static const String crewCertificates = "crewCertificates";
  static const String crewNewPassword = "crewNewPassword";
  static const String crewLeavingProject = "crewLeavingProject/";
}
