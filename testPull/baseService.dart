import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:karachi_hills_project/Screen/views/agent/agent_onboarding.dart';
import 'package:karachi_hills_project/Screen/views/customer/onboardingCustomer.dart';
import 'package:karachi_hills_project/model/bankList_Model.dart';
import 'package:karachi_hills_project/model/city_model.dart';
import 'package:karachi_hills_project/model/country_dropdown.dart';
import 'package:karachi_hills_project/model/feeedback_Get_IssueType_Model.dart';
import 'package:karachi_hills_project/model/remaining_form_count_model.dart';
import 'package:karachi_hills_project/model/singleIssueModel.dart';
import 'package:karachi_hills_project/model/issue_list_model.dart';
import 'package:karachi_hills_project/model/staff_profile_model.dart';
import 'package:karachi_hills_project/provider/bankList_provider.dart';
import 'package:karachi_hills_project/provider/city_provider.dart';
import 'package:karachi_hills_project/provider/country_provider.dart';
import 'package:karachi_hills_project/provider/feedback_GetIssueTypes_Provider.dart';
import 'package:karachi_hills_project/provider/getIssuesList_provider.dart';
import 'package:karachi_hills_project/provider/remaining_count_Provider.dart';
import 'package:karachi_hills_project/provider/singleIssueDetail_provider.dart';
import 'package:karachi_hills_project/model/notifications_model.dart';
import 'package:karachi_hills_project/provider/notifications_provider.dart';
import 'package:karachi_hills_project/provider/staffProfile_provider.dart';
import 'package:karachi_hills_project/Screen/views/agent/agent_pay.dart';
import 'package:karachi_hills_project/model/AgentSubmitDetailsViewModel.dart';
import 'package:karachi_hills_project/provider/agentSubmitDetailsView_provider.dart';
import 'package:karachi_hills_project/provider/staff_list_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:karachi_hills_project/Screen/auth/forgotPassword.dart';
import 'package:karachi_hills_project/Screen/auth/login.dart';
import 'package:karachi_hills_project/Screen/auth/otpScreen.dart';
import 'package:karachi_hills_project/Screen/auth/resetPassword.dart';
import 'package:karachi_hills_project/Screen/flow/appliedMembershipFormDetails.dart';
import 'package:karachi_hills_project/Screen/flow/requestDetails.dart';
import 'package:karachi_hills_project/Screen/views/agent/agent_bottombar.dart';
import 'package:karachi_hills_project/Utils/appColors.dart';
import 'package:karachi_hills_project/Utils/bottomBar.dart';
import 'package:karachi_hills_project/model/Profile_Info_Model.dart';
import 'package:karachi_hills_project/model/agent_profile.dart';
import 'package:karachi_hills_project/model/agent_register_model.dart';
import 'package:karachi_hills_project/model/agent_request_list.dart';
import 'package:karachi_hills_project/model/agent_user_model.dart';
import 'package:karachi_hills_project/model/draft_data_model.dart';
import 'package:karachi_hills_project/model/dropdown_membership_model.dart';
import 'package:karachi_hills_project/model/form_info_model.dart';
import 'package:karachi_hills_project/model/getAppliedMembershpDetails_model.dart';
import 'package:karachi_hills_project/model/getMembership_forms_Model.dart';
import 'package:karachi_hills_project/model/getmembershipFormNew_Model.dart';
import 'package:karachi_hills_project/model/request_data_model.dart';
import 'package:karachi_hills_project/model/user_all_requests.dart';
import 'package:karachi_hills_project/model/user_auth_model.dart';
import 'package:karachi_hills_project/model/user_info_Model.dart';
import 'package:karachi_hills_project/model/staff_list.dart';
import 'package:karachi_hills_project/provider/agent_profile_provider.dart';
import 'package:karachi_hills_project/provider/agent_register.dart';
import 'package:karachi_hills_project/provider/agent_request_provider.dart';
import 'package:karachi_hills_project/provider/agent_rl_provider.dart';
import 'package:karachi_hills_project/provider/agent_user_provider.dart';
import 'package:karachi_hills_project/provider/allRequests_provider.dart';
import 'package:karachi_hills_project/provider/appSubmittedOnCnic_Provider.dart';
import 'package:karachi_hills_project/provider/auth_provider.dart';
import 'package:karachi_hills_project/provider/draftDataProvider.dart';
import 'package:karachi_hills_project/provider/dropdown_membershipProvider.dart';
import 'package:karachi_hills_project/provider/form_details.dart';
import 'package:karachi_hills_project/provider/getAppliedMembershpDetails_Provider.dart';
import 'package:karachi_hills_project/provider/getMembershipFormNew_Provider.dart';
import 'package:karachi_hills_project/provider/get_Membership_Forms_provider.dart';
import 'package:karachi_hills_project/provider/profileInfo_Provider.dart';
import 'package:karachi_hills_project/provider/request_data_provider.dart';
import 'package:karachi_hills_project/provider/userInfo_Provider.dart';
import 'package:karachi_hills_project/model/agent_request_model.dart';
import 'package:karachi_hills_project/provider/utilProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../Screen/views/selectedView/listOfPlots_provider.dart';
import '../Screen/views/selectedView/listViewSelected.dart';

class BaseService {
   String BASE_URL = "https://backend.khybergolfcity.com/";

  //String BASE_URL = "http://192.168.18.245:3000/";

  //4String BASE_URL = "https://presentatiobackend.khybergolfcity.com/";

  //String BASE_URL = "https://a421-2400-adc1-1d0-cc00-68db-4b23-122f-7791.ngrok.io/";

  String AGENT_SIGNUP = 'real-estate/agent-signup';
  String SIGNUP_URL = 'auth/user/signup';
  String SIGNIN_URL = 'auth/user/login';

  String VERIFY_ACCOUNT_URL = 'auth/account-verify';
  String VERIFY_CODE_URL = 'auth/account-code-verify';
  String RESET_PASS_URL = 'auth/reset-password';

  String FORGET_PASS_URL = 'auth/forgot-password';
  String FORGET_CODE_URL = 'auth/fp-code-verify';
  String CHANGE_PASS_URL = 'auth/change-password';

  String FORM_NO_POST = 'application-request/reqeust-application';
  String FORM_COUNTER = 'application-request/my-applications/count';
  String ALL_REQUESTS = 'application-request/my-applications?page=1&limit=30';

  String CNIC_CHECK = 'application-request/check-unpaid-application-request/';
  String AGENT_FORMPOST = 'real-estate/create-application-request';
  String STAFF_ADD = 'real-estate/agent-create-agentStaff-form';

  String AGENT_REGISTRATIONS =
      'real-estate/application/for-real-estate-search?';
  String AGENT_REQUEST_LIST =
      'application-request/list-for-agent-or-staff-search?';
  String AGENT_FORMSUBMIT = 'real-estate/submit-application/single/for-agent/';

  String RESIDENTIAL_DROPDOWN = 'residental';
  String USER_MEMBERSHIP_DRAFT = 'application/for-user-form-submit-as-draft';
  String USER_MEMBERSHIP_PAY = 'application/for-user-pay';

  String GET_USER_MEMBERSHIP_FORMS =
      'application/get-for-customer?page=1&limit=30';
  String GET_USER_MEMBERSHIP_DRAFT = "application/draft-data/";

  String SAVE_MEMBERSHIPFORM_AS_DRAFT =
      "application/for-user-form-submit-as-draft";
  String UPDATE_MEMBERSHIPFORM_AS_DRAFT = "application/update-draft-data/";

  String SUBMIT_FORMS = 'application/for-user-form-submit';
  String SUBMIT_DRAFTED_FORMS = 'application/';

  String AppFormSubmitted = "application/form-submit-count-check-by-cnic";
  String GET_APPLIED_MEMBERSHIP_FORM_DETAILS =
      "application/view-member-ship-detail/";
  String FORM_PRICE = "pricing/get-form-price";

  String STAFF_PROFILE = "real-estate/agent-staff-profile/";
  String AGENT_PROFILE_UPDATE = "real-estate/update-agent-profile";
  String STAFF_PROFILE_UPDATE = "real-estate/estate-staff-profile-self-update";

  String UPDATE_PROFILE = "customs/update/my-profile";
  String PROFILE_INFO = "customs/my-profile/for-all-users";
  String AGENT_STAFF_EDIT =
      "real-estate/agent-staff-profile-for-admin-and-agent/";

  String SUBMIT_AGENT_FORM = "real-estate/submit-application/single/for-agent";
  String STAFF_LIST = "real-estate/agentStaff-list/for-agent?page=1&limit=70";
  String STAFF_DELETE = "real-estate/delete-estate-staff/";
  String AGENT_GET_SUBMIT_DETAILS =
      "real-estate/application/for-real-estate/single/";

  String FeedBackApi_Get_IssueType = "support-system/issue-type";
  String FeedBackApi_Post_Feedback = "support-system/support-request";

  String COUNTRY = "country?";
  String CITY = "city/by-country/";

  String NOTIFICATIONS = "notification?";
  String NOTIFICATIONS_MARKREAD = "notification/mark-read";

  Future<void> showFlushBar(BuildContext context, text) {
    return Flushbar(
      icon: Icon(
        Icons.info,
        color: AppColors.PRIMARY_COLOR,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      barBlur: 20.0,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      borderRadius: BorderRadius.circular(8.0),
      messageText: Text("$text",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: AppColors.SCAFFOLD_COLOR,
          )),
      backgroundColor: AppColors.PRIMARY_COLOR,
      // blockBackgroundInteraction: true,
      duration: Duration(seconds: 4),
    ).show(context);
  }

  Future getMathod(dataUrl, context) async {
    var url = Uri.parse(dataUrl);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bearer = prefs.getString('bearer');
    try {
      var response = await http.get(url, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $bearer',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        return;
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy or check your internet connection");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out LogIn Again");
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => Login()),
        // );
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future agentSignUp(BuildContext context, fullName, cnic, email, phone,
      password, shopName, shopAddr, yoe, whatsAppNo, cityId, countryId) async {
    var url = Uri.parse(BASE_URL + AGENT_SIGNUP);
    print(countryId.runtimeType);
    print(cityId);
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = AppColors.PRIMARY_COLOR
      ..indicatorColor = AppColors.SCAFFOLD_COLOR
      ..textColor = AppColors.SCAFFOLD_COLOR
      ..indicatorSize = 35.0
      ..radius = 10.0
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = false
      ..dismissOnTap = false;
    EasyLoading.show(
        status: "Please Wait", maskType: EasyLoadingMaskType.custom);

    var map = jsonEncode({
      "cityId": cityId,
      "countryId": countryId,
      "fullName": fullName,
      "cnic": cnic,
      "email": email,
      "phone": '$phone',
      "whatsAppNo": '$whatsAppNo',
      "password": password,
      "estateName": shopName,
      "address": shopAddr,
      "yearsOfExperience": '$yoe'
    });
    print(map);
    try {
      var response = await http.post(url,
          headers: {
            'accept': '*/*',
            'Content-Type': 'application/json',
          },
          body: map);
      var jsonData = jsonDecode(response.body);
      if (response.statusCode == 201) {
       // showFlushBar(context, "${jsonData['message']}");
        EasyLoading.dismiss();
        print("here is agent response  $jsonData");

        showDialog<
            String>(
          context:
          context,
          builder: (BuildContext
          context) =>
              AlertDialog(
                title: const Text(
                    'Wait for Confirmation'),
                content:
                Text('${jsonData['message']}'),
                actions: <
                    Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Login()));
                    },
                    child:
                    const Text('OK'),
                  ),
                ],
              ),
        );

        /* Navigator.push(context, MaterialPageRoute(builder: (context) =>
                OtpScreen(signupBehave: true,forgotBehave: false,verifyAccount: false,)));*/
        return jsonData;
      } else {
        EasyLoading.dismiss();
        showFlushBar(context, "${jsonData['message']}");
        print("something went wrong ${jsonData['message']}");
        return jsonData;
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future signUp(
      BuildContext context, fullName, cnic, email, phone, whatsApp, password,
      {loading = true}) async {
    var url = Uri.parse(BASE_URL + SIGNUP_URL);
    if (loading) {
      EasyLoading.instance
        ..indicatorType = EasyLoadingIndicatorType.dualRing
        ..loadingStyle = EasyLoadingStyle.custom
        ..backgroundColor = AppColors.PRIMARY_COLOR
        ..indicatorColor = AppColors.SCAFFOLD_COLOR
        ..textColor = AppColors.SCAFFOLD_COLOR
        ..indicatorSize = 35.0
        ..radius = 10.0
        ..maskColor = Colors.black.withOpacity(0.6)
        ..userInteractions = false
        ..dismissOnTap = false;
      EasyLoading.show(
          status: "Please Wait", maskType: EasyLoadingMaskType.custom);
    }

    var response = await http.post(url, body: {
      "fullName": fullName,
      "cnic": cnic,
      "email": email,
      "phone": '$phone',
      "whatsAppNo": "$whatsApp",
      "password": password
    }).timeout(Duration(seconds: 10));

    var jsonData = jsonDecode(response.body);
    try {
      if (response.statusCode == 201) {
        print(
            "typed Data is here: $fullName + $cnic + $email + $phone + $password");
        print("Data:" + jsonData.toString());

        EasyLoading.dismiss();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpScreen(
                signupBehave: true,
                forgotBehave: false,
                verifyAccount: false,
                email: email,
              )),
        );
        return jsonData;
      } else {
        EasyLoading.dismiss();

        showFlushBar(context, "${jsonData['message']}");
        print("something went wrong");
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future agentFormPost(BuildContext context, fullName, cnic, email, phone,
      whatsApp, photo, applications, bool isLoading) async {
    EasyLoading.instance
      ..backgroundColor = AppColors.PRIMARY_COLOR
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = AppColors.PRIMARY_COLOR
      ..indicatorColor = AppColors.SCAFFOLD_COLOR
      ..textColor = AppColors.SCAFFOLD_COLOR
      ..indicatorSize = 35.0
      ..radius = 10.0
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = false
      ..dismissOnTap = false;
    EasyLoading.show(
        status: "Please Wait", maskType: EasyLoadingMaskType.custom);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bearer = prefs.getString('bearer');
    var url = Uri.parse(BASE_URL + AGENT_FORMPOST);
    try {
      var response = await http.post(url,
          headers: {
            'accept': '*/*',
            'Authorization': 'Bearer $bearer',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "fullName": fullName,
            "cnic": cnic,
            "email": email,
            "phone": phone,
            "whatsAppNo": whatsApp,
            "profilePhoto": "abc",
            "noOfApplication": applications
          }));

      var jsonData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        EasyLoading.dismiss();
        var agentRequestProvider =
        Provider.of<AgentRequestProvider>(context, listen: false);
        print("Data:" + jsonData.toString());
        agentRequestProvider.setUserDetails(AgentRequest.fromJson(jsonData));

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AgentPayRequest(
                  agent: jsonData['createdByUser'],
                )));

        return;
      } else {
        EasyLoading.dismiss();
        showFlushBar(context, "${jsonData['message']}");
        print("something went wrong");
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future formCount(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var utilProvider = Provider.of<UtilProvider>(context, listen: false);
    var bearer = prefs.getString('bearer');
    var url = Uri.parse(BASE_URL + FORM_COUNTER);
    var response = await http.get(url, headers: {
      'accept': '*/*',
      'Authorization': 'Bearer $bearer',
      'Content-Type': 'application/json',
    });

    var jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      String forms = jsonData['data']['total_forms'];
      int formCounter = int.parse(forms);
      utilProvider.setCounter(formCounter);
      return forms;
    } else {
      showFlushBar(context, "${jsonData['message']}");
      print("HereIsResponse: $jsonData");
    }
  }

  Future resendCode(BuildContext context, email) async {
    var url = Uri.parse(BASE_URL + FORGET_PASS_URL);
    try {
      var response = await http.post(url, body: {"email": email});
      var jsonData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        print("Data:" + jsonData.toString());
        showFlushBar(context, "${jsonData['message']}");
        return jsonData;
      } else {
        showFlushBar(context, "${jsonData['message']}");
        print("something went wrong");
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future resendCodeToVerify(BuildContext context, email) async {
    var url = Uri.parse(BASE_URL + VERIFY_ACCOUNT_URL);

    try {
      var response = await http.post(url, body: {"email": email});
      var jsonData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        print("Data:" + jsonData.toString());
        showFlushBar(context, "${jsonData['message']}");
        return jsonData;
      } else {
        showFlushBar(context, "${jsonData['message']}");
        print("something went wrong");
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future cnicCheck(BuildContext context, cnic) async {
    var agentUserProvider =
    Provider.of<AgentUserProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var bearer = prefs.getString('bearer');
    var url = Uri.parse(BASE_URL + CNIC_CHECK + cnic);
    try {
      var response = await http.get(url, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $bearer',
        'Content-Type': 'application/json',
      });

      var jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        agentUserProvider.restUserProvider();
        List sum = jsonData['data']['applicationData'];
        if (sum[0]['sum'] == null) {
          prefs.setString('sum', '0');
        } else {
          await prefs.remove('sum');
          prefs.setString('sum', sum[0]['sum']);
          print(prefs.getString('sum'));
        }

        if (jsonData['data']['userData'] != null) {
          agentUserProvider.restUserProvider();
          agentUserProvider
              .setUserDetails(AgentUser.fromJson(jsonData['data']));
        } else
          return;
      } else {
        showFlushBar(context, "${jsonData['message']}");
        print("HereIsResponse: $jsonData");
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future formPost(BuildContext context, formNumber, loading) async {
    var formDetailsProvider = Provider.of<FormDetails>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bearer = prefs.getString('bearer');
    var url = Uri.parse(BASE_URL + FORM_NO_POST);
    try {
      var response = await http.post(url,
          body: jsonEncode({"NumberOfApplication": formNumber}));

      print('Forms: $formNumber');

      var jsonData = jsonDecode(response.body);
      if (response.statusCode == 201) {
        formDetailsProvider.restFormProvider();
        formDetailsProvider.setFormDetails(FormModel.fromJson(jsonData));

        String date =
        formDetailsProvider.formModel!.data!.createdAt!.split("T")[0];
        DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(date);
        var formattedDate = DateFormat.yMMMEd().format(tempDate);

        prefs.setString('date', '${formattedDate}');
        prefs.setString(
            'OrderId', '${formDetailsProvider.formModel!.data!.id!}');
        prefs.setString('name', '${formDetailsProvider.formModel!.data!.name}');
        prefs.setString('AppNo',
            '${formDetailsProvider.formModel!.data!.numberOfApplication}');
        prefs.setString(
            'amount', '${formDetailsProvider.formModel!.data!.amount}');

        return jsonData;
      } else {
        showFlushBar(context, "${jsonData['message']}");
        print("something went wrong");
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future login(BuildContext context, cnic, password, {loading = true}) async {
    var userInfoProvider =
    Provider.of<UserInfoProvider>(context, listen: false);

    if (loading) {
      EasyLoading.instance
        ..indicatorType = EasyLoadingIndicatorType.dualRing
        ..loadingStyle = EasyLoadingStyle.custom
        ..backgroundColor = AppColors.PRIMARY_COLOR
        ..indicatorColor = AppColors.SCAFFOLD_COLOR
        ..textColor = AppColors.SCAFFOLD_COLOR
        ..indicatorSize = 35.0
        ..radius = 10.0
        ..maskColor = Colors.black.withOpacity(0.6)
        ..userInteractions = false
        ..dismissOnTap = false;

      EasyLoading.show(
          status: "Please Wait", maskType: EasyLoadingMaskType.custom);
    }

    var url = Uri.parse(BASE_URL + SIGNIN_URL);
    try {
      var response = await http
          .post(url, body: {"cnic": cnic, "password": password}).timeout(Duration(seconds: 30),);
      var jsonData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        userInfoProvider.setUserDetails(UserInfoModel.fromJson(jsonData));
        EasyLoading.dismiss();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        for (String key in prefs.getKeys()) {
          if (key != "onboardingWatched") {
            prefs.remove(key);
          }
        }
        prefs.setString(
            'name', '${userInfoProvider.userInfoModel!.data!.user!.fullName}');
        prefs.setString(
            'cnic', '${userInfoProvider.userInfoModel!.data!.user!.cnic}');
        prefs.setString(
            'email', '${userInfoProvider.userInfoModel!.data!.user!.email}');
        prefs.setString(
            'phone', '${userInfoProvider.userInfoModel!.data!.user!.phone}');
        prefs.setString('whatsApp',
            '${userInfoProvider.userInfoModel!.data!.user!.whatsAppNo}');
        prefs.setString(
            'roleId', '${userInfoProvider.userInfoModel!.data!.user!.roleId}');
        prefs.setString(
            'bearer', '${userInfoProvider.userInfoModel!.data!.token}');
        prefs.setString(
            'userID', '${userInfoProvider.userInfoModel!.data!.user!.id}');
        prefs.setString('pass', '$password');

        var token = prefs.getString('bearer');
        try {
          var url =
              'https://backend.khybergolfcity.com/realtime?token=Bearer $token';
          // var url =
          //     'https://presentatiobackend.khybergolfcity.com/realtime?token=Bearer $token';
          IO.Socket socket = IO.io(
              url,
              IO.OptionBuilder()
                  .setTransports(['websocket'])
                  .enableAutoConnect()
                  .build());
          print(url);
          socket.onConnect((_) {
            print('connect');
            print('${socket.id}');
            // socket.emit('msg', 'test');
          });
          socket.onDisconnect((_) => print('disconnect'));
          socket.on('fromServer', (_) => print(_));
        } catch (e) {
          print(e.toString());
        }

        print("Token: ${prefs.getString('bearer')}");
        print(prefs.getString('roleId'));
        var roleId = prefs.getString('roleId');

        if (prefs.getBool("onboardingWatched") != true) {
          if (roleId == '1') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Onboarding_Screen_Customer()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Onboarding_Screen_Agent()),
            );
          }

          return jsonData;
        } else if (roleId == '5' || roleId == '6') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AgentBottomBarWidget()),
          );
          return jsonData;
        } else if (roleId == '1') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomBarWidget()),
          );
          return jsonData;
        }
      } else if (jsonData['message'] == "Please verify your account") {
        EasyLoading.dismiss();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ForgotPassword(
                forVerification: true,
              )),
        );
        showFlushBar(context, "${jsonData['message']}");
      } else if (response.statusCode == 500) {
        EasyLoading.dismiss();
        showFlushBar(context, "Internet Problem");
      } else {
        EasyLoading.dismiss();
        showFlushBar(context, "${jsonData['message']}");
        print("something went wrong");
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong ${e.toString()}");
      EasyLoading.dismiss();
    }

// catch(e){
//   EasyLoading.dismiss();
//   showFlushBar(context, "Server is busy");
// }
  }

  Future verifySignupCode(BuildContext context, code) async {
    var url = Uri.parse(BASE_URL + FORGET_PASS_URL);
    try {
      var response = await http.post(url, body: {"code": code});
      var jsonData = jsonDecode(response.body);
      EasyLoading.instance
        ..indicatorType = EasyLoadingIndicatorType.dualRing
        ..loadingStyle = EasyLoadingStyle.custom
        ..backgroundColor = AppColors.PRIMARY_COLOR
        ..indicatorColor = AppColors.SCAFFOLD_COLOR
        ..textColor = AppColors.SCAFFOLD_COLOR
        ..indicatorSize = 35.0
        ..radius = 10.0
        ..maskColor = Colors.black.withOpacity(0.6)
        ..userInteractions = false
        ..dismissOnTap = false;

      EasyLoading.show(
          status: "Please Wait", maskType: EasyLoadingMaskType.custom);

      if (response.statusCode == 201) {
        EasyLoading.dismiss();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
        return jsonData;
      } else {
        EasyLoading.dismiss();
        showFlushBar(context, "${jsonData['message']}");
        print("something went wrong");
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future forgotPass(BuildContext context, email) async {
    var url = Uri.parse(BASE_URL + FORGET_PASS_URL);
    try {
      var response = await http.post(url, body: {"email": email});
      EasyLoading.instance
        ..indicatorType = EasyLoadingIndicatorType.dualRing
        ..loadingStyle = EasyLoadingStyle.custom
        ..backgroundColor = AppColors.PRIMARY_COLOR
        ..indicatorColor = AppColors.SCAFFOLD_COLOR
        ..textColor = AppColors.SCAFFOLD_COLOR
        ..indicatorSize = 35.0
        ..radius = 10.0
        ..maskColor = Colors.black.withOpacity(0.6)
        ..userInteractions = false
        ..dismissOnTap = false;

      EasyLoading.show(
          status: "Please Wait", maskType: EasyLoadingMaskType.custom);
      var jsonData = jsonDecode(response.body);
      if (response.statusCode == 201) {
        EasyLoading.dismiss();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpScreen(
                  forgotBehave: true,
                  signupBehave: false,
                  verifyAccount: false,
                  email: email)),
        );
        return jsonData;
      } else {
        EasyLoading.dismiss();
        showFlushBar(context, "${jsonData['message']}");
        print("something went wrong");
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future forgotVerifyCode(BuildContext context, code) async {
    var url = Uri.parse(BASE_URL + FORGET_CODE_URL);
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      var response = await http.post(url, body: {"code": code});
      EasyLoading.instance
        ..indicatorType = EasyLoadingIndicatorType.dualRing
        ..loadingStyle = EasyLoadingStyle.custom
        ..backgroundColor = AppColors.PRIMARY_COLOR
        ..indicatorColor = AppColors.SCAFFOLD_COLOR
        ..textColor = AppColors.SCAFFOLD_COLOR
        ..indicatorSize = 35.0
        ..radius = 10.0
        ..maskColor = Colors.black.withOpacity(0.6)
        ..userInteractions = false
        ..dismissOnTap = false;

      EasyLoading.show(
          status: "Please Wait", maskType: EasyLoadingMaskType.custom)
          .timeout(Duration(seconds: 10));
      var jsonData = jsonDecode(response.body);
      if (response.statusCode == 201) {
        EasyLoading.dismiss();
        userProvider.setUserDetails(UserAuth.fromJson(jsonData));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        for (String key in prefs.getKeys()) {
          if (key != "onboardingWatched") {
            prefs.remove(key);
          }
        }
        // prefs.setString('email', '$uEmail');
        // prefs.setString('pass', '$uPassword');
        prefs.setString('bearer', '${userProvider.userModel!.data!.token}');
        print("Bearer:${userProvider.userModel!.data!.token}");

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResetPassword()),
        );
      } else {
        EasyLoading.dismiss();
        showFlushBar(context, "${jsonData['message']}");
        print("something went wrong");
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future changePassword(context, oldPass, newPass, confirmPass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = AppColors.PRIMARY_COLOR
      ..indicatorColor = AppColors.SCAFFOLD_COLOR
      ..textColor = AppColors.SCAFFOLD_COLOR
      ..indicatorSize = 35.0
      ..radius = 10.0
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = false
      ..dismissOnTap = false;

    EasyLoading.show(
        status: "Please Wait", maskType: EasyLoadingMaskType.custom);
    var bearer = prefs.getString('bearer');
    var url = Uri.parse(BASE_URL + CHANGE_PASS_URL);
    try {
      var response = await http.patch(url,
          body: jsonEncode({
            "password": "$newPass",
          }),
          headers: {
            'accept': '*/*',
            'Authorization': 'Bearer $bearer',
            'Content-Type': 'application/json',
          });

      var jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        print("Data:" + jsonData.toString());
        showFlushBar(context, "${jsonData['message']}");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
        return jsonData;
      } else {
        EasyLoading.dismiss();
        showFlushBar(context, "${jsonData['message']}");
        print("something went wrong");
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future resetPassword(context, oldPass, newPass, confirmPass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bearer = prefs.getString('bearer');
    var url = Uri.parse(BASE_URL + RESET_PASS_URL);
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = AppColors.PRIMARY_COLOR
      ..indicatorColor = AppColors.SCAFFOLD_COLOR
      ..textColor = AppColors.SCAFFOLD_COLOR
      ..indicatorSize = 35.0
      ..radius = 10.0
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = false
      ..dismissOnTap = false;

    EasyLoading.show(
        status: "Please Wait", maskType: EasyLoadingMaskType.custom);
    var response = await http.post(url,
        body: jsonEncode({
          "oldPassword": "$oldPass",
          "newPassword": "$newPass",
          "confirmPassword": "$confirmPass"
        }),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $bearer',
          'Content-Type': 'application/json',
        });

    print('Response status: ${response.statusCode}');
    var jsonData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      EasyLoading.dismiss();
      print("Data:" + jsonData.toString());

      showFlushBar(context, "${jsonData['message']}");
      return jsonData;
    } else {
      EasyLoading.dismiss();
      showFlushBar(context, "${jsonData['message']}");
      print("something went wrong");
    }
  }

  Future staffAdd(context, name, cnic, email, number, whatsapp, {image}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = AppColors.PRIMARY_COLOR
      ..indicatorColor = AppColors.SCAFFOLD_COLOR
      ..textColor = AppColors.SCAFFOLD_COLOR
      ..indicatorSize = 35.0
      ..radius = 10.0
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = false
      ..dismissOnTap = false;

    EasyLoading.show(
        status: "Please Wait", maskType: EasyLoadingMaskType.custom);
    var bearer = prefs.getString('bearer');
    print(prefs.getString('bearer'));
    Map<String, String> headers = {"Authorization": "Bearer $bearer"};

    var url = Uri.parse(BASE_URL + STAFF_ADD);
    try {
      var req = http.MultipartRequest('POST', url);
      req.headers.addAll(headers);

      if (image != null) {
        req.files.add(await http.MultipartFile.fromPath('file', image));
      }

      req.fields['fullName'] = name;
      req.fields['cnic'] = cnic;
      req.fields['email'] = email;
      req.fields['phone'] = "$number";
      req.fields['whatsAppNo'] = "$whatsapp";

      print(name);
      print(cnic);
      print(email);
      print(number);
      print(whatsapp);

      var res = await req.send();
      print(res.reasonPhrase);

      var responseData = await res.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print("Staff Creation $responseString");

      var d = jsonDecode(responseString);
      if (d['message'] == "Successfully created") {
        EasyLoading.dismiss();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AgentBottomBarWidget()),
        );
        showFlushBar(context, "${d['message']}");
      } else {
        EasyLoading.dismiss();
        showFlushBar(context, "${d['message']}");
      }

      return d['data'];
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future agentEditProfile(context, name, number, whatsapp, estate,
      {image}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = AppColors.PRIMARY_COLOR
      ..indicatorColor = AppColors.SCAFFOLD_COLOR
      ..textColor = AppColors.SCAFFOLD_COLOR
      ..indicatorSize = 35.0
      ..radius = 10.0
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = false
      ..dismissOnTap = false;

    EasyLoading.show(
        status: "Please Wait", maskType: EasyLoadingMaskType.custom);
    var bearer = prefs.getString('bearer');
    print(prefs.getString('bearer'));
    Map<String, String> headers = {"Authorization": "Bearer $bearer"};

    var url = Uri.parse(BASE_URL + AGENT_PROFILE_UPDATE);
    print(url);
    try {
      var req = http.MultipartRequest('POST', url);
      req.headers.addAll(headers);

      if (image != null) {
        req.files.add(await http.MultipartFile.fromPath('file', image));
      }

      req.fields['fullName'] = name;
      req.fields['phone'] = "$number";
      req.fields['whatsAppNo'] = "$whatsapp";
      req.fields['estateName'] = estate;

      var res = await req.send();
      print(res.reasonPhrase);

      var responseData = await res.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print("Here Update response $responseString");

      var d = jsonDecode(responseString);
      if (d['message'] == "Successfully updated") {
        EasyLoading.dismiss();
        showFlushBar(context, "${d['message']}");
      } else {
        EasyLoading.dismiss();
        showFlushBar(context, "${d['message']}");
      }

      return d['data'];
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future staffEditProfile(context, name, number, whatsapp, {image}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = AppColors.PRIMARY_COLOR
      ..indicatorColor = AppColors.SCAFFOLD_COLOR
      ..textColor = AppColors.SCAFFOLD_COLOR
      ..indicatorSize = 35.0
      ..radius = 10.0
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = false
      ..dismissOnTap = false;

    EasyLoading.show(
        status: "Please Wait", maskType: EasyLoadingMaskType.custom);
    var bearer = prefs.getString('bearer');
    print(prefs.getString('bearer'));
    Map<String, String> headers = {"Authorization": "Bearer $bearer"};

    var url = Uri.parse(BASE_URL + STAFF_PROFILE_UPDATE);
    print(url);
    try {
      var req = http.MultipartRequest('POST', url);
      req.headers.addAll(headers);

      if (image != null) {
        req.files.add(await http.MultipartFile.fromPath('file', image));
      }

      req.fields['fullName'] = name;
      req.fields['phone'] = "$number";
      req.fields['whatsAppNo'] = "$whatsapp";

      var res = await req.send();
      print(res.reasonPhrase);

      var responseData = await res.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print("Here Update response $responseString");

      var d = jsonDecode(responseString);
      if (d['message'] == "Successfully updated") {
        EasyLoading.dismiss();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AgentBottomBarWidget()),
        );
        showFlushBar(context, "${d['message']}");
      } else {
        EasyLoading.dismiss();
        showFlushBar(context, "${d['message']}");
      }
      return d['data'];
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future agentAppSubmit(context, id, name, cnic, phone, whatsapp, email,
      depositNo, formFile, depositFile, resId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = AppColors.PRIMARY_COLOR
      ..indicatorColor = AppColors.SCAFFOLD_COLOR
      ..textColor = AppColors.SCAFFOLD_COLOR
      ..indicatorSize = 35.0
      ..radius = 10.0
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = false
      ..dismissOnTap = false;

    EasyLoading.show(
        status: "Please Wait", maskType: EasyLoadingMaskType.custom);
    var bearer = prefs.getString('bearer');
    Map<String, String> headers = {"Authorization": "Bearer $bearer"};

    try {
      var url = Uri.parse(BASE_URL + AGENT_FORMSUBMIT + "$id");
      var req = http.MultipartRequest('POST', url);
      req.headers.addAll(headers);

      print(formFile);
      req.files.add(await http.MultipartFile.fromPath('formFile', formFile));
      req.files.add(
          await http.MultipartFile.fromPath('depositSlipFile', depositFile));
      req.fields['name'] = name;
      req.fields['cnic'] = "$cnic";
      req.fields['phone'] = "$phone";
      req.fields['whatsAppNo'] = "$whatsapp";
      req.fields['email'] = email;
      req.fields['depositSlipNo'] = "$depositNo";
      req.fields['residentalId'] = resId;

      var res = await req.send();
      print("Response phrase: ${res.reasonPhrase}");

      var responseData = await res.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print("Here Update response $responseString");

      var d = jsonDecode(responseString);
      if (d['message'] == "Successfully updated") {
        EasyLoading.dismiss();
        showFlushBar(context, "${d['message']}");
      } else {
        EasyLoading.dismiss();
        showFlushBar(context, "${d['message']}");
      }
      return d['data'];
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future editProfile(context, name, number, whatsapp, {image}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = AppColors.PRIMARY_COLOR
      ..indicatorColor = AppColors.SCAFFOLD_COLOR
      ..textColor = AppColors.SCAFFOLD_COLOR
      ..indicatorSize = 35.0
      ..radius = 10.0
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = false
      ..dismissOnTap = false;

    EasyLoading.show(
        status: "Please Wait", maskType: EasyLoadingMaskType.custom);
    var bearer = prefs.getString('bearer');
    Map<String, String> headers = {"Authorization": "Bearer $bearer"};
    var url = Uri.parse(BASE_URL + UPDATE_PROFILE);

    // var map = new Map<String, dynamic>();
    // map['fullName'] = name;
    // map['phone'] = number;
    // map['whatsAppNo'] = whatsapp;
    // map['file'] = image;

    try {
      var req = http.MultipartRequest('POST', url);
      req.headers.addAll(headers);

      if (image != null) {
        req.files.add(await http.MultipartFile.fromPath('file', image));
      }

      req.fields['fullName'] = name;
      req.fields['phone'] = "$number";
      req.fields['whatsAppNo'] = "$whatsapp";

      var res = await req.send();
      print(res.reasonPhrase);

      var responseData = await res.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print("Here Update response $responseString");

      var d = jsonDecode(responseString);
      if (d['message'] == "Successfully updated") {
        EasyLoading.dismiss();
        showFlushBar(context, "${d['message']}");
      } else {
        EasyLoading.dismiss();
        showFlushBar(context, "Something went wrong");
      }
      return d['data'];
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future agentEditStaff(context, id, name, number, whatsapp, {image}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = AppColors.PRIMARY_COLOR
      ..indicatorColor = AppColors.SCAFFOLD_COLOR
      ..textColor = AppColors.SCAFFOLD_COLOR
      ..indicatorSize = 35.0
      ..radius = 10.0
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = false
      ..dismissOnTap = false;

    EasyLoading.show(
        status: "Please Wait", maskType: EasyLoadingMaskType.custom);
    var bearer = prefs.getString('bearer');
    Map<String, String> headers = {"Authorization": "Bearer $bearer"};
    var url = Uri.parse(BASE_URL + AGENT_STAFF_EDIT + "$id");

    try {
      var req = http.MultipartRequest('POST', url);
      req.headers.addAll(headers);

      if (image != null) {
        req.files.add(await http.MultipartFile.fromPath('file', image));
      }

      req.fields['fullName'] = name;
      req.fields['phone'] = "$number";
      req.fields['whatsAppNo'] = "$whatsapp";

      var res = await req.send();
      print(res.reasonPhrase);

      var responseData = await res.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print("Here Update response $responseString");

      var d = jsonDecode(responseString);
      if (d['message'] == "Successfully updated") {
        EasyLoading.dismiss();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AgentBottomBarWidget()),
        );
        showFlushBar(context, "${d['message']}");
      } else {
        EasyLoading.dismiss();
        showFlushBar(context, "Something went wrong");
      }
      return d['data'];
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future verifyAccount(BuildContext context, email) async {
    var url = Uri.parse(BASE_URL + VERIFY_ACCOUNT_URL);
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = AppColors.PRIMARY_COLOR
      ..indicatorColor = AppColors.SCAFFOLD_COLOR
      ..textColor = AppColors.SCAFFOLD_COLOR
      ..indicatorSize = 35.0
      ..radius = 10.0
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = false
      ..dismissOnTap = false;

    EasyLoading.show(
        status: "Please Wait", maskType: EasyLoadingMaskType.custom);

    try {
      var response = await http.post(url, body: {"email": email});

      var jsonData = jsonDecode(response.body);
      if (response.statusCode == 201) {
        EasyLoading.dismiss();
        print(email);

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpScreen(
                forgotBehave: false,
                signupBehave: false,
                verifyAccount: true,
                email: email,
              )),
        );
        return jsonData;
      } else {
        EasyLoading.dismiss();
        showFlushBar(context, "${jsonData['message']}");
        print("something went wrong");
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future verifyAccountCode(BuildContext context, code) async {
    var url = Uri.parse(BASE_URL + VERIFY_CODE_URL);
    try {
      var response = await http.post(url, body: {"code": code});
      var jsonData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        showFlushBar(context, "${jsonData['message']}");
        print(response.body);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      } else {
        showFlushBar(context, "${jsonData['message']}");
        print("something went wrong");
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future LogOut(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (String key in prefs.getKeys()) {
      if (key != "onboardingWatched") {
        prefs.remove(key);
      }
    }
    // prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  Future getAllRequest(context) async {
    var allRequestsProvider =
    Provider.of<UserAllRequestsProvider>(context, listen: false);
    var requestDataProvider =
    Provider.of<RequestDataProvider>(context, listen: false);

    getMathod(BASE_URL + ALL_REQUESTS, context).then((value) {
      // requestDataProvider.setRequestDetails(RequestDataModel.fromJson(value));
      allRequestsProvider.setUserRequests(AllRequests.fromJson(value));
      //print("Costumer list data $value");
    });
  }

  ///------request_Form_Data-----///

  Future userRequestData(BuildContext context, number, loading) async {
    EasyLoading.instance..backgroundColor = AppColors.PRIMARY_COLOR;
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = AppColors.PRIMARY_COLOR
      ..indicatorColor = AppColors.SCAFFOLD_COLOR
      ..textColor = AppColors.SCAFFOLD_COLOR
      ..indicatorSize = 35.0
      ..radius = 10.0
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = false
      ..dismissOnTap = false;
    EasyLoading.show(
        status: "Please Wait", maskType: EasyLoadingMaskType.custom);

    var url = Uri.parse(BASE_URL + FORM_NO_POST);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var bearer = prefs.getString('bearer');
    print("Bearer Token: $bearer");
    try {
      var response = await http.post(url,
          headers: {
            'accept': '*/*',
            'Authorization': 'Bearer $bearer',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({"NumberOfApplication": number}));

      var jsonData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        var requestDataProvider =
        Provider.of<RequestDataProvider>(context, listen: false);
        print("Data:" + jsonData.toString());
        requestDataProvider
            .setRequestDetails(RequestDataModel.fromJson(jsonData));
        EasyLoading.dismiss();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RequestDetails()),
        );
        return jsonData;
      } else {
        EasyLoading.dismiss();
        showFlushBar(context, "${jsonData['message']}");
        print("something went wrong");
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Internet Not Working");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
      }
    }
  }

  ///------------ GET-DROPDOWN-VALUES ----------------///

  Future getDropdownValues(context) async {
    var dropdownProvider =
    Provider.of<DropdownProvider>(context, listen: false);
    getMathod(BASE_URL + RESIDENTIAL_DROPDOWN, context).then((value) {
      print(value);
      dropdownProvider.setDropdownModel(DropdownModel.fromJson(value));
      dropdownProvider.setListDropDrown();
      print("${dropdownProvider.dropdownList}");
    });
  }

  ///------------ POST-Membership Payment ----------------///
  Future membershipPayment(BuildContext context, {applicationId}) async {
    var url = Uri.parse(BASE_URL + USER_MEMBERSHIP_PAY);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bearer = prefs.getString('bearer');
    try {
      var response = await http.post(url, headers: {
        'Authorization': 'Bearer $bearer',
      }, body: {
        "applicationRequestId": "$applicationId",
      });

      print('Response status: ${response.body}');
      print('Response status: ${response.statusCode}');

      var jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
        return jsonData;
      } else {
        showFlushBar(context, "${jsonData['message']}");
        print("something went wrong");
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  ///------------ GET-USER-MEMBERSHIP-FORMS ----------------///

  Future getMembershipForms(context) async {
    var getMembershipFormsProvider =
    Provider.of<GetMembershipFormsProvider>(context, listen: false);
    getMathod(BASE_URL + GET_USER_MEMBERSHIP_FORMS, context).then((value) {
      getMembershipFormsProvider
          .setMembershipForms(GetMembeshipFormModel.fromJson(value));
    });
  }


  Future agentRegisterForms(context, page, search) async {

    const limit = 15;
    var agentRegisterProvider =
    Provider.of<GetRegistrationProvider>(context, listen: false);
    agentRegisterProvider.restRegisterFormsProvider();
    var url = BASE_URL +
        AGENT_REGISTRATIONS +
        'page=$page&limit=$limit&search=$search';
    // var url = BASE_URL +
    //     AGENT_REGISTRATIONS +
    //     'page=1&limit=2000&search=$search';
    if(search != ""){
      print("search is not empty: $search  ");
    await agentRegisterProvider.restRegisterFormsProvider();
   await  agentRegisterProvider.resetAgentRegistrationList();
      await getMathod(url, context).then((value) {
        agentRegisterProvider.setRegisterForms(AgentRegister.fromJson(value));

      });
      for (var i = 0; i < agentRegisterProvider.registerFormModel!.data!.items!.length; i++) {
        // TO DO
        agentRegisterProvider.setAgentRegistrationList(agentRegisterProvider.registerFormModel!.data!.items![i]);
      }
      print("Registration list   ${agentRegisterProvider.agentRegistrationList.length}  page $page");

    }else{
      await getMathod(url, context).then((value) {
        agentRegisterProvider.setRegisterForms(AgentRegister.fromJson(value));
       // print("   ${agentRegisterProvider.registerFormModel!.data!.items![0].status}");
      });

      for (var i = 0; i < agentRegisterProvider.registerFormModel!.data!.items!.length; i++) {
        // TO DO
        agentRegisterProvider.setAgentRegistrationList(agentRegisterProvider.registerFormModel!.data!.items![i]);
      }

      print("Registration list   ${agentRegisterProvider.agentRegistrationList.length}  page $page");

    }

  }

  ///------------ POST-DRAFT-USER-MEMBERSHIP-FORMS ----------------///
  Future membershipFormSaveAsDraft(
      BuildContext context, {
        applicationId,
        email,
        phone,
        tel,
        whatsApp,
        cnic,
        name,
        fatherName,
        passport,
        dob,
        address,
        age,
        profession,
        organization,
        residentalId,
      }) async {
    try {
      var url = Uri.parse(BASE_URL + USER_MEMBERSHIP_DRAFT);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var bearer = prefs.getString('bearer');
      var response = await http.post(url, headers: {
        'Authorization': 'Bearer $bearer'
      }, body: {
        "applicationId": "$applicationId",
        "email": email,
        "phone": phone,
        "tel": tel,
        "whatsAppNo": "$whatsApp",
        "cnic": cnic,
        "name": name,
        "fatherName": fatherName,
        "passport": passport,
        "dob": dob,
        "address": address,
        "age": age,
        "profession": profession,
        "organization": organization,
        "residentalId": "$residentalId",
      });

      var jsonData = jsonDecode(response.body);
      if (response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomBarWidget()),
        );
        showFlushBar(context, "${jsonData['message']}");
        print("DRAFT_API_RESPONSE $jsonData");
      } else {
        showFlushBar(context, "${jsonData['message']}");
        print("something went wrong");
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future agentRequests(context, page, query) async {
    const limit = 15;
    var url =
        BASE_URL + AGENT_REQUEST_LIST + 'page=$page&limit=$limit&search=$query';
    var agentReqListProvider =
    Provider.of<AgentReqListProvider>(context, listen: false);
    var agentRequestProvider =
    Provider.of<AgentRequestProvider>(context, listen: false);
    var utilProvider = Provider.of<UtilProvider>(context, listen: false);
    await getMathod(url, context).then((value) {
      agentRequestProvider.setUserDetails(AgentRequest.fromJson(value));
      agentReqListProvider.setListDetails(AgentRequestList.fromJson(value));
      print("Value is here meta  ${value["meta"]}");
      // utilProvider.setStaffApplicationRequests(value);
      //print(agentReqListProvider.agentRequestList!.data!.items![0].name);
    });
  }

  Future staffDelete(context, id) async {
    var url = Uri.parse(BASE_URL + STAFF_DELETE + '$id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bearer = prefs.getString('bearer');
    try {
      var response =
      await http.delete(url, headers: {'Authorization': 'Bearer $bearer'});

      var jsonData = jsonDecode(response.body);
      showFlushBar(context, "${jsonData['message']}");
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future agentStaff(context) async {
    var agentStaff =
    Provider.of<AgentStaffListProvider>(context, listen: false);
    getMathod(BASE_URL + STAFF_LIST, context).then((value) {
      agentStaff.setListDetails(StaffList.fromJson(value));
      // print(agentStaff.agentStaffList!.data!.items![0].fullName);
    });
  }

/*    Future getAllRequest(context) async {
    var allRequestsProvider =
    Provider.of<UserAllRequestsProvider>(context, listen: false);
    getMathod(BASE_URL + ALL_REQUESTS, context).then((value) {
    print(value);
    allRequestsProvider.setUserRequests(AllRequests.fromJson(value));
    });
    }*/

  ///------------ GET-USER-DRAFTED-MEMBERSHIP-FORMS (application/draft-data/)----------------///

  Future getDraftMembershipForms(context, id) async {
    var draftDataProvider =
    Provider.of<DraftDataProvider>(context, listen: false);
    getMathod(BASE_URL + GET_USER_MEMBERSHIP_DRAFT + "$id", context)
        .then((value) {
      print(value.length);
      print("Value of getData" + value.toString());
      draftDataProvider
          .setDraftDetails(GetMembershipDraftDetailsModel.fromJson(value));
    });
  }

  ///------------------Update_Membership_form_Draft(application/update-draft-data/)------------------///

  Future updateDraftMembershipForm(
      context,
      Id, {
        applicationId,
        email,
        phone,
        tel,
        whatsApp,
        cnic,
        name,
        fatherName,
        passport,
        dob,
        address,
        age,
        profession,
        organization,
        residentalId,
      }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bearer = prefs.getString('bearer');
    var url = Uri.parse(BASE_URL + UPDATE_MEMBERSHIPFORM_AS_DRAFT + "$Id");
    try {
      var response = await http.patch(url, body: {
        "applicationId": "$applicationId",
        "email": email,
        "phone": phone,
        "tel": tel,
        "whatsAppNo": "$whatsApp",
        "cnic": cnic,
        "name": name,
        "fatherName": fatherName,
        "passport": passport,
        "dob": dob,
        "address": address,
        "age": age,
        "profession": profession,
        "organization": organization,
        "residentalId": "$residentalId",
      }, headers: {
        'Authorization': 'Bearer $bearer',
      });
      print('Response status: ${response.body}');
      print('Response status: ${response.statusCode}');
      var jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("Data:" + jsonData.toString());

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomBarWidget()),
        );
        showFlushBar(context, "${jsonData['message']}");
        return jsonData;
      } else {
        showFlushBar(context, "${jsonData['message']}");
        print("something went wrong");
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  ///------------------Save_Membership_form_Draft(application/for-user-form-submit-as-draft)------------------///

  Future saveAsDraftMembershipForm(
      context, {
        applicationId,
        email,
        phone,
        tel,
        cnic,
        name,
        fatherName,
        passport,
        dob,
        whatsApp,
        address,
        age,
        profession,
        organization,
        residentalId,
      }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bearer = prefs.getString('bearer');
    var url = Uri.parse(BASE_URL + SAVE_MEMBERSHIPFORM_AS_DRAFT);
    var response = await http.post(url,
        body: jsonEncode({
          {
            "applicationId": "$applicationId",
            "email": email,
            "phone": phone,
            "tel": tel,
            "whatsAppNo": "$whatsApp",
            "cnic": cnic,
            "name": name,
            "fatherName": fatherName,
            "passport": passport,
            "dob": dob,
            "address": address,
            "age": age,
            "profession": profession,
            "organization": organization,
            "residentalId": "$residentalId",
          }
        }),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $bearer',
          'Content-Type': 'application/json',
        });

    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 201) {
      print("Data:" + jsonData.toString());

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomBarWidget()),
      );
      return jsonData;
    } else {
      showFlushBar(context, "${jsonData['message']}");
      print("something went wrong");
    }
  }

  Future membershipFormDraftFunc(BuildContext context,
      {applicationId,
        email,
        phone,
        tel,
        whatsApp,
        cnic,
        name,
        fatherName,
        passport,
        dob,
        address,
        age,
        profession,
        organization,
        residentalId}) async {
    print("Pressed");
    getMathod(BASE_URL + GET_USER_MEMBERSHIP_DRAFT + "$applicationId", context)
        .then((value) {
      // var draftDataProvider =
      //     Provider.of<DraftDataProvider>(context, listen: false);
      // draftDataProvider
      //     .setDraftDetails(GetMembershipDraftDetailsModel.fromJson(value));

      if (value.length == 1) {
        print("value is-- null");
        membershipFormSaveAsDraft(
          context,
          applicationId: applicationId,
          email: email,
          phone: phone,
          tel: tel,
          whatsApp: whatsApp,
          cnic: cnic,
          name: name,
          fatherName: fatherName,
          passport: passport,
          dob: dob,
          address: address,
          age: age,
          profession: profession,
          organization: organization,
          residentalId: residentalId,
        );
      } else {
        updateDraftMembershipForm(
          context,
          value["data"]["id"],
          applicationId: applicationId,
          email: email,
          phone: phone,
          tel: tel,
          whatsApp: whatsApp,
          cnic: cnic,
          name: name,
          fatherName: fatherName,
          passport: passport,
          dob: dob,
          address: address,
          age: age,
          profession: profession,
          organization: organization,
          residentalId: residentalId,
        );
        print("value is not null  ${value["data"]["id"]}   $applicationId");
      }
    });
  }

  ///------------------Submit_Membership_form------------------///

/*  Future membershipFormSubmit(BuildContext context, {
    applicationId,
    email,
    phone,
    tel,
    whatsApp,
    cnic,
    name,
    fatherName,
    passport,
    dob,
    address,
    age,
    profession,
    organization,
    residentalId,
  }) async {
    var url = Uri.parse(BASE_URL + SUBMIT_FORMS);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bearer = prefs.getString('bearer');
    var response = await http.post(url, headers: {
      'Authorization': 'Bearer $bearer',
    }, body: {
      "applicationId": "$applicationId",
      "email": email,
      "phone": phone,
      "tel": tel,
      "whatsAppNo": "$whatsApp",
      "cnic": cnic,
      "name": name,
      "fatherName": fatherName,
      "passport": passport,
      "dob": dob,
      "address": address,
      "age": age,
      "profession": profession,
      "organization": organization,
      "residentalId": "$residentalId",
    });
    print('Response status: ${response.body}');
    print('Response status: ${response.statusCode}');
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 201) {
      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => RegistrationList()),
      );
      print("SUBMIT_API_RESPONSE $jsonData");
    } else {
      showFlushBar(context, "${jsonData['message']}");
      print("something went wrong");
    }
  }*/

  ///------------------Submit_Drafted_Membership_form------------------///
  Future DraftedMembershipFormSubmit(
      BuildContext context,
      Id, {
        applicationId,
        email,
        phone,
        tel,
        whatsApp,
        cnic,
        name,
        fatherName,
        passport,
        dob,
        address,
        age,
        profession,
        organization,
        residentalId,
      }) async {
    var url = Uri.parse(BASE_URL + SUBMIT_DRAFTED_FORMS + "$Id");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bearer = prefs.getString('bearer');
    var response = await http.patch(url, headers: {
      'Authorization': 'Bearer $bearer',
    }, body: {
      "applicationId": "$applicationId",
      "email": email,
      "phone": phone,
      "tel": tel,
      "whatsAppNo": "$whatsApp",
      "cnic": cnic,
      "name": name,
      "fatherName": fatherName,
      "passport": passport,
      "dob": dob,
      "address": address,
      "age": age,
      "profession": profession,
      "organization": organization,
      "residentalId": "$residentalId",
    });

    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomBarWidget()),
      );
      print("SUBMIT_DRAFT_API_RESPONSE $jsonData");
    } else {
      showFlushBar(context, "${jsonData['message']}");
      print("something went wrong");
    }
  }

  ///------------------Submit_Membership_form------------------///

  Future membershipFormSubmit(
      BuildContext context, {
        applicationId,
        email,
        phone,
        tel,
        whatsApp,
        cnic,
        name,
        fatherName,
        passport,
        dob,
        address,
        age,
        profession,
        organization,
        residentalId,
      }) async {
    var url = Uri.parse(BASE_URL + SUBMIT_FORMS);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bearer = prefs.getString('bearer');
    var response = await http.post(url, headers: {
      'Authorization': 'Bearer $bearer',
    }, body: {
      "applicationId": "$applicationId",
      "email": email,
      "phone": phone,
      "tel": tel,
      "whatsAppNo": "$whatsApp",
      "cnic": cnic,
      "name": name,
      "fatherName": fatherName,
      "passport": passport,
      "dob": dob,
      "address": address,
      "age": age,
      "profession": profession,
      "organization": organization,
      "residentalId": "$residentalId",
    });

    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 201) {
      var blinqInvoice = jsonData['data']['blinqInvoice'];
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomBarWidget()),
      );
      print(blinqInvoice);
      return blinqInvoice;
    } else {
      showFlushBar(context, "${jsonData['message']}");
      print("something went wrong");
    }
  }

  Future SubmitMembershipFormFunc(BuildContext context,
      {applicationId,
        email,
        phone,
        tel,
        cnic,
        name,
        fatherName,
        passport,
        dob,
        address,
        age,
        whatsApp,
        profession,
        organization,
        residentalId}) async {
    // late var invoice;

    late var invoice;

    getMathod(BASE_URL + GET_USER_MEMBERSHIP_DRAFT + "$applicationId", context)
        .then((value) async {
      var draftDataProvider =
      Provider.of<DraftDataProvider>(context, listen: false);
      draftDataProvider.resttDraftDetailsProvider();
      draftDataProvider
          .setDraftDetails(GetMembershipDraftDetailsModel.fromJson(value));

      // if (value["data"]["userId"] != null) {
      //   DraftedMembershipFormSubmit(
      //       context, draftDataProvider.draftDataModel!.data!.id,
      //       applicationId: applicationId,
      //       email: email,
      //       phone: phone,
      //       tel: tel,
      //       whatsApp: whatsApp,
      //       cnic: cnic,
      //       name: name,
      //       fatherName: fatherName,
      //       passport: passport,
      //       dob: dob,
      //       address: address,
      //       age: age,
      //       profession: profession,
      //       organization: organization,
      //       residentalId: residentalId);
      // } else {

      invoice = await membershipFormSubmit(context,
          applicationId: applicationId,
          email: email,
          phone: phone,
          tel: tel,
          cnic: cnic,
          name: name,
          fatherName: fatherName,
          passport: passport,
          dob: dob,
          address: address,
          age: age,
          profession: profession,
          organization: organization,
          residentalId: residentalId);
    });
    print("Invoice inside another function ${invoice}");
    return invoice;
  }

  ///------------------Checking_Count_Of_Submited_Membership_form------------------///
  Future checkingCountOfSubmitedForm(context, String cnicText) async {
    var appFormSubmittedOnCnicProvider =
    Provider.of<AppFormSubmittedOnCnicProvider>(context, listen: false);
    // var url = Uri.parse(BASE_URL + AppFormSubmitted);
    getMathod(BASE_URL + "application-v2/booking-count/$cnicText", context)
        .then((value) {
      appFormSubmittedOnCnicProvider
          .fetchappFormSubmittedOnCnicListData(value['data']);
      print("Data List ${value}");
    });
    // var response = await http.post(url, body: {"cnic": "$cnicText"});
    // var jsonData = jsonDecode(response.body);
    // if (response.statusCode == 201) {
    //   appFormSubmittedOnCnicProvider
    //       .fetchappFormSubmittedOnCnicListData(jsonData);
    //   print("providerData" +
    //       appFormSubmittedOnCnicProvider.appFormSubmittedOnCnicList[0].title
    //           .toString());
    //
    //   return jsonData;
    // } else {
    //   showFlushBar(context, "something went wrong");
    //   print("something went wrong");
    // }
  }

  Future checkingRemainingCountOfSubmitedForm(context, String cnicText) async {
    var remainingFormSubmittedOnCnicProvider =
    Provider.of<RemainingFormSubmittedOnCnicProvider>(context,
        listen: false);
    // var url = Uri.parse(BASE_URL + AppFormSubmitted);
    getMathod(BASE_URL + "application-v2/booking-count/remaining/$cnicText",
        context)
        .then((value) {
      remainingFormSubmittedOnCnicProvider
          .setRemainigFormCount(RemainigFormCountModel.fromJson(value));
      print("Data remaining List ${value}");
    });
  }

  ///------------------Getting_form_price------------------///
  Future getFormPrice(context) async {
    var utilProvider = Provider.of<UtilProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse(BASE_URL + FORM_PRICE);

    var response = await http.get(url, headers: {
      "accept": "/",
      "Content-Type": "application/json",
    });

    var jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      int formPrice = jsonData["data"]["price"];
      print("Form Price Api" + formPrice.toString());
      prefs.setString("price", "$formPrice");

      utilProvider.setFormPrice(formPrice);
      return formPrice;
    } else {
      print(response.statusCode);
    }
  }

  ///--Get-Applied-MembershipForm-Detail--///
  Future getAppliedMembershipFormDetail(context, formId) async {
    var getAppliedMembershipFormDetailProvider =
    Provider.of<GetAppliedMembershpDetailsProvider>(context, listen: false);
    //getAppliedMembershipFormDetailProvider.restMembershipFormsProvider();
    getMathod(BASE_URL + "application-v2/$formId", context).then((value) {
      print("Here is AppliedValue $value");
      getAppliedMembershipFormDetailProvider.setAppliedMembershipForms(
          GetAppliedMembershipDetail.fromJson(value));
    });
  }

  ///--Get-Profile-Info--///
  Future getStaffProfileInfo(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var roleID = prefs.getString('roleId');
    print(roleID);
    var profileInfoProvider =
    Provider.of<ProfileInfoProvider>(context, listen: false);
    var agentProfileProvider =
    Provider.of<AgentProfileProvider>(context, listen: false);

    getMathod(BASE_URL + PROFILE_INFO, context).then((value) {
      print("ProfileData" + value.toString());
      if (roleID == '1') {
        profileInfoProvider.setProfileInfo(ProfileInfoModel.fromJson(value));
      } else if (roleID == '5' || roleID == '6') {
        agentProfileProvider.setProfileInfo(AgentProfile.fromJson(value));
        print(agentProfileProvider.agentProfileModel!.data!.realEstate);
      }
    });
  }

  Future getProfileInfo(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var roleID = prefs.getString('roleId');
    print(roleID);
    var profileInfoProvider =
    Provider.of<ProfileInfoProvider>(context, listen: false);
    var agentProfileProvider =
    Provider.of<AgentProfileProvider>(context, listen: false);
    var staffProfileProvider =
    Provider.of<StaffProfileProvider>(context, listen: false);

    try {
      getMathod(BASE_URL + PROFILE_INFO, context).then((value) {
        if (roleID == '1') {
          profileInfoProvider.setProfileInfo(ProfileInfoModel.fromJson(value));
        } else if (roleID == '5') {
          agentProfileProvider.setProfileInfo(AgentProfile.fromJson(value));
        } else if (roleID == '6') {
          staffProfileProvider
              .setUserDetails(StaffProfileModel.fromJson(value));
        }
      });
    } catch (e) {
      BaseService().showFlushBar(context, "Server Issue Please Try ");
    }
  }

  Future staffProfileForAgent(context, id) async {
    var agentProfileProvider =
    Provider.of<StaffProfileProvider>(context, listen: false);
    getMathod(BASE_URL + STAFF_PROFILE + "$id", context).then((value) {
      print("Data: $value");
      agentProfileProvider.setUserDetails(StaffProfileModel.fromJson(value));
    });
  }

  ///------ Submit and Draft according to new Api ------///
  Future submitAndDraftFuncNew(
      BuildContext context,
      id, {
        name,
        fatherName,
        email,
        cnic,
        dob,
        age,
        passport,
        address,
        profession,
        organization,
        whatsAppNo,
        mobile,
        telephone,
        status,
        residentalId,
      }) async {
    print("Function run");
    try {
      var url = Uri.parse(BASE_URL + "application-v2/$id");
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var map = new Map<String, dynamic>();

      if (name == "") {
      } else {
        map['name'] = '$name';
      }
      if (fatherName == "") {
      } else {
        map['fatherName'] = '$fatherName';
      }
      if (email == "") {
      } else {
        map['email'] = '$email';
      }

      if (cnic == "") {
      } else {
        map['cnic'] = cnic;
      }

      if (dob == "") {
      } else {
        map['dob'] = dob;
      }

      if (age == "") {
      } else {
        map['age'] = age;
      }

      if (passport == "") {
      } else {
        map['passport'] = passport;
      }

      if (address == "") {
      } else {
        map['address'] = address;
      }

      if (profession == "") {
      } else {
        map['profession'] = profession;
      }

      if (organization == "") {
      } else {
        map['organization'] = organization;
      }

      if (whatsAppNo == "") {
      } else {
        map['whatsAppNo'] = whatsAppNo;
      }

      if (mobile == "") {
      } else {
        map['mobile'] = mobile;
      }

      if (telephone == "") {
      } else {
        map['telephone'] = telephone;
      }

      map['status'] = status;

      if (residentalId == 0) {
      } else {
        map['residentalId'] = residentalId;
      }

      var bearer = prefs.getString('bearer');
      var response = await http.post(url,
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $bearer',
          },
          body: jsonEncode(map));

      print(jsonEncode(map));

      var jsonData = jsonDecode(response.body);
      if (response.statusCode == 201) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomBarWidget()));
      } else {
        showFlushBar(context, "${jsonData['message']}");
        print("something went wrong ${jsonData['message']}");
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future submitRegFuncNew(
      BuildContext context,
      id,
      name,
      fatherName,
      email,
      cnic,
      dob,
      passport,
      address,
      profession,
      organization,
      whatsAppNo,
      mobile,
      telephone,
      status,
      residentalId,
      ) async {
    print("Function run");
    var url = Uri.parse(BASE_URL + "application-v2/$id");
    EasyLoading.instance..backgroundColor = AppColors.PRIMARY_COLOR;
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = AppColors.PRIMARY_COLOR
      ..indicatorColor = AppColors.SCAFFOLD_COLOR
      ..textColor = AppColors.SCAFFOLD_COLOR
      ..indicatorSize = 35.0
      ..radius = 10.0
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = false
      ..dismissOnTap = false;
    EasyLoading.show(
        status: "Please Wait", maskType: EasyLoadingMaskType.custom);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var map = new Map<String, dynamic>();

    map['name'] = '$name';
    map['fatherName'] = '$fatherName';
    map['email'] = '$email';
    map['cnic'] = cnic;
    map['dob'] = dob;

    if (passport == "") {
    } else {
      map['passport'] = passport;
    }

    map['address'] = address;

    if (profession == "") {
    } else {
      map['profession'] = profession;
    }
    if (organization == "") {
    } else {
      map['organization'] = organization;
    }
    map['whatsAppNo'] = whatsAppNo;
    map['mobile'] = mobile;
    if (telephone == "") {
    } else {
      map['telephone'] = telephone;
    }
    map['status'] = status;
    map['residentalId'] = residentalId;

    var bearer = prefs.getString('bearer');
    try {
      var response = await http.post(url,
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $bearer',
          },
          body: jsonEncode(map));
      print(jsonEncode(map));

      var jsonData = jsonDecode(response.body);
      if (response.statusCode == 201) {
        EasyLoading.dismiss();
        //var blinqInvoice = jsonData['data']['blinqInvoice'];
        // Navigator.pushReplacement( context,
        //  MaterialPageRoute(builder: (context) => BottomBarWidget()),
        //  );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AppliedMembershipFormDetails(appId: id)));
        showFlushBar(context, "${jsonData['message']}");
      } else {
        EasyLoading.dismiss();
        showFlushBar(context, "${jsonData['message']}");
        print("${jsonData['message']}");
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  /// ------ Get-Registration-Form-list-New-Api-----///

  Future getMembershipFormsNewApi(context) async {
    var getMembershipFormsProvider =
    Provider.of<GetMembershipFormsNewProvider>(context, listen: false);
    getMathod(BASE_URL + "application-v2?page=1&limit=50", context)
        .then((value) {
      getMembershipFormsProvider
          .setMembershipForms(GetMembeshipFormModelNew.fromJson(value));
      print("Data Here Get Registeration List ${value}  ");
    });
  }

  Future getDraftMembershipFormsNewApi(context, id) async {
    var draftDataProvider =
    Provider.of<DraftDataProvider>(context, listen: false);
    getMathod(BASE_URL + "application-v2/$id", context).then((value) {

      print("Value of getData" + value.toString());
      draftDataProvider
          .setDraftDetails(GetMembershipDraftDetailsModel.fromJson(value));
    });
  }

  /// ----- Agent download PDF Form ----- ///
  Future getDownloadPdfFormAgent(context, id) async {
    EasyLoading.instance..backgroundColor = AppColors.PRIMARY_COLOR;
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = AppColors.PRIMARY_COLOR
      ..indicatorColor = AppColors.SCAFFOLD_COLOR
      ..textColor = AppColors.SCAFFOLD_COLOR
      ..indicatorSize = 35.0
      ..radius = 10.0
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = false
      ..dismissOnTap = false;
    EasyLoading.show(
        status: "Please Wait", maskType: EasyLoadingMaskType.custom)
        .timeout(Duration(seconds: 2));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('bearer');
    try {
      String pdfUrl = "${BASE_URL}real-estate/download-application/$id/$token";
      File? file;
      if (Platform.isAndroid) {
        Directory appStorage = (await getExternalStorageDirectory())!;
        String fullPath = "${appStorage.path}/Registration_Form_$id.pdf";
        file = File(fullPath);

      } else if (Platform.isIOS) {
        Directory appStorage = (await getApplicationDocumentsDirectory())!;
        String fullPath = "${appStorage.path}/Registration_Form_$id.pdf";
        file = File(fullPath);
      }


      final dio = Dio();
      dio.download(pdfUrl, file!.path);
      var statusGot = await getPermission();
      print(" Permision status $statusGot");

      if (await Permission.storage.request().isGranted) {
        await dio
            .download(pdfUrl, file!.path)
            .then((value) => EasyLoading.dismiss());

        // final raf = file.openSync(mode: FileMode.write);
        // raf.writeFromSync(response.data);
        // await raf.close();

        print("Path : ${file!.path}");

        OpenFile.open(file!.path).then((value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AgentBottomBarWidget(
                  getIndex: 2,
                ))));
        return true;
      } else {
        EasyLoading.dismiss();
        print(" Permission not granted");
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future getPermission() async {
    var status = await Permission.storage;
    return status;
  }

  Future submitApplicationAgent(context,
      { id,
        formFile,
        depositSlip,
        name,
        cnic,
        number,
        whatsapp,
        email,
        depositSlipNo,
        residential,
        bankId
      }) async {
    EasyLoading.instance..backgroundColor = AppColors.PRIMARY_COLOR;
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = AppColors.PRIMARY_COLOR
      ..indicatorColor = AppColors.SCAFFOLD_COLOR
      ..textColor = AppColors.SCAFFOLD_COLOR
      ..indicatorSize = 35.0
      ..radius = 10.0
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = false
      ..dismissOnTap = false;
    EasyLoading.show(
        status: "Please Wait", maskType: EasyLoadingMaskType.custom);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bearer = prefs.getString('bearer');
    print(prefs.getString('bearer'));
    Map<String, String> headers = {"Authorization": "Bearer $bearer"};

    var url = Uri.parse(BASE_URL + SUBMIT_AGENT_FORM + "/$id");
    print(url);
    try {
      var req = http.MultipartRequest('POST', url);
      req.headers.addAll(headers);

      if (formFile != null && depositSlip != null) {
        req.files.add(await http.MultipartFile.fromPath('formFile', formFile));
     //   req.files.add(
     //       await http.MultipartFile.fromPath('depositSlipFile', depositSlip));
      }

      req.fields['name'] = "$name";
      req.fields['cnic'] = "$cnic";
      req.fields['phone'] = "$number";
      req.fields['whatsAppNo'] = "$whatsapp";
      req.fields['email'] = "$email";
      //req.fields['depositSlipNo'] = "$depositSlipNo";
      req.fields['residentalId'] = "$residential";
      //req.fields['bankId'] = "$bankId";

      var res = await req.send();
      print(res.reasonPhrase);

      var responseData = await res.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print("Here Update response $responseString");

      var d = jsonDecode(responseString);

      if (res.statusCode == 201) {
        print("data here Applied Success $d ");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => AgentBottomBarWidget()));
        showFlushBar(context, "${d['message']}");
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        print("data here Applied $d ");
        showFlushBar(context, "Error: ${d['message']}");
      }
      return d['data'];
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  /// ------ Get-Detail-View-Api-agent-----///

  Future<AgentSubmitDetailsViewModel> getSubmitDetailsVeiwSingle(context, id) async {
    // print("Single $id");
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var bearer = prefs.getString('bearer');
    // final url = Uri.parse(BASE_URL + AGENT_GET_SUBMIT_DETAILS);
    // var response = await http.get(url, headers: {
    //   'accept': '*/*',
    //   'Authorization': 'Bearer $bearer',
    //   'Content-Type': 'application/json',
    // });
    // final body = jsonDecode(response.body.toString());
    // print("Status code ${response.statusCode}");
    //
    var body;
    var getSubmitDetailsVeiwSingleProvider =
    Provider.of<AgentSubmitDetailsViewProvider>(context, listen: false);
      await  getMathod(BASE_URL + AGENT_GET_SUBMIT_DETAILS + "$id", context)
        .then((value) {
      body = value;
      getSubmitDetailsVeiwSingleProvider.setagentSubmitDetailsView(
          AgentSubmitDetailsViewModel.fromJson(value));
      print(
          "Data Here Get submit view ${getSubmitDetailsVeiwSingleProvider.agentSubmitDetailsViewModel!.data!.name!}  ");
      print("body data:  $body");
    });

    return AgentSubmitDetailsViewModel.fromJson(body);
  }

  Future countForRealEstateAgent(context) async {
    var utilProvider = Provider.of<UtilProvider>(context, listen: false);
    getMathod(
        BASE_URL + "real-estate/application/count/for-real-estate", context)
        .then((value) {
      utilProvider.setAgentApplicationCount(value['data']['count']);
      print("Value from func ${utilProvider.agentApplicationCount}");
    });
  }

  Future countForRealEstateStaff(context) async {
    var utilProvider = Provider.of<UtilProvider>(context, listen: false);
    await getMathod(
        BASE_URL + "real-estate/estateStaff-count/for-agent", context)
        .then((value) {
      utilProvider.setStaffCount(value['data']['count']);
    });
  }
  ///---------Staff-Application-count---------///
  Future countForResgisteredFormStaff(context) async {
    var utilProvider = Provider.of<UtilProvider>(context, listen: false);
    getMathod(
        BASE_URL + "real-estate/application/count/for-real-estate", context)
        .then((value) {
      utilProvider.setStaffRegisteredFormCount(value['data']['count']);
      print("staff from func ${utilProvider.staffRegisteredForms}");
    });
  }


  Future countForApplicationFormStaff(context) async {
    var utilProvider = Provider.of<UtilProvider>(context, listen: false);
    getMathod(
        BASE_URL + "application-request/count/for-real-estate-search", context)
        .then((value) {
      utilProvider.setStaffApplicationRequests(value['data']['sum']);
      print("staff from func ${utilProvider.staffApplicationRequests}");
    });
  }

  ///---------FeedBack Apis----------///
  Future FeedbackGetIssueType(context) async {
    var dropdownIssueProvider =
    Provider.of<FeedBackGetIssueTypesProvider>(context, listen: false);
    getMathod(BASE_URL + FeedBackApi_Get_IssueType, context).then((value) {
      dropdownIssueProvider
          .setDropdownModel(FeedbackGetIssueTypeModel.fromJson(value));
      dropdownIssueProvider.setListDropDrown();
      print(
          "Here Dropdown Value initial  ${dropdownIssueProvider.dropdownIssueList}");
    });
    //  print("Here Dropdown Value initial  ${dropdownIssueProvider.dropdownIssueList}");
  }

  Future submitFeedback(context, {formFile, message, issueTypeId}) async {
    EasyLoading.instance..backgroundColor = AppColors.PRIMARY_COLOR;
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = AppColors.PRIMARY_COLOR
      ..indicatorColor = AppColors.SCAFFOLD_COLOR
      ..textColor = AppColors.SCAFFOLD_COLOR
      ..indicatorSize = 35.0
      ..radius = 10.0
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = false
      ..dismissOnTap = false;
    EasyLoading.show(
        status: "Please Wait", maskType: EasyLoadingMaskType.custom)
        .timeout(Duration(seconds: 10));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bearer = prefs.getString('bearer');
    print(prefs.getString('bearer'));
    Map<String, String> headers = {"Authorization": "Bearer $bearer"};

    var url = Uri.parse(BASE_URL + FeedBackApi_Post_Feedback);
    print(url);
    try {
      var req = http.MultipartRequest('POST', url);
      req.headers.addAll(headers);

      if (formFile != null) {
        formFile.forEach((item) async {
          req.files.add(await http.MultipartFile.fromPath('files', item.path));
        });
        // req.files.add(await http.MultipartFile.fromPath('files', formFile));
      }

      req.fields['issueTypeId'] = "$issueTypeId";
      req.fields['query'] = "$message";

      var res = await req.send();
      print(res.reasonPhrase);

      var responseData = await res.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print("Here Update response $responseString");

      var d = jsonDecode(responseString);

      if (res.statusCode == 201) {
        EasyLoading.dismiss();
        print("data here Applied Success $d ");
        Navigator.pop(context);
        showFlushBar(context, "${d['message']}");
      } else {
        EasyLoading.dismiss();
        print("data here Applied $d ");
        showFlushBar(context, "Error: ${d['message']}");
      }
      return d['data'];
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future getIssueList(context) async {
    var issuesProvider = Provider.of<GetIssueProvider>(context, listen: false);
    getMathod(BASE_URL + "support-system/my-support-requests?page=1&limit=500",
        context)
        .then((value) {
      issuesProvider.setIssuesListProvider(IssuesListModel.fromJson(value));
    });
  }

  Future getSingleIssueDetail(context, id) async {
    var singleIssueProvider =
    Provider.of<SingleIssueDetailProvider>(context, listen: false);
    getMathod(BASE_URL + "support-system/$id", context).then((value) {
      singleIssueProvider
          .setSingleIssueDetailProvider(singleIssueDetailModel.fromJson(value));
    });
  }

  Future markAsResolved(context, id) async {
    EasyLoading.instance..backgroundColor = AppColors.PRIMARY_COLOR;
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = AppColors.PRIMARY_COLOR
      ..indicatorColor = AppColors.SCAFFOLD_COLOR
      ..textColor = AppColors.SCAFFOLD_COLOR
      ..indicatorSize = 35.0
      ..radius = 10.0
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = false
      ..dismissOnTap = false;
    EasyLoading.show(
        status: "Please Wait", maskType: EasyLoadingMaskType.custom)
        .timeout(Duration(seconds: 10));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bearer = prefs.getString('bearer');
    var url = Uri.parse(BASE_URL + "support-system/resolve/$id");
    try {
      var response = await http.patch(url, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $bearer',
        'Content-Type': 'application/json',
      });

      var jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        print("Data Is Patched:" + jsonData.toString());
        Navigator.pop(context);
        showFlushBar(context, "${jsonData['message']}");
        return jsonData;
      } else {
        EasyLoading.dismiss();
        showFlushBar(context, "${jsonData['message']}");
        print("something went wrong");
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }

  Future notifications(context, page) async {
    int limit = 15;
    var notificationProvider =
    Provider.of<NotificationsProvider>(context, listen: false);
    await getMathod(
        BASE_URL + NOTIFICATIONS + 'page=$page&limit=$limit', context)
        .then((value) {
      notificationProvider.setNotifications(Notifications.fromJson(value));
      print(
          "Unread Notifications ${notificationProvider.notificationsModel!.data!.unreadcount}");
    });
  }

  Future country(context, query) async {
    var countryProvider = Provider.of<CountryProvider>(context, listen: false);
    getMathod(BASE_URL + COUNTRY + 'search=$query', context).then((value) {
      countryProvider.setDropdownModel(CountryModel.fromJson(value));
      countryProvider.setListDropDrown();
      print(countryProvider.dropdownCountryModel!.data![0].title);
    });
  }

  Future city(context, id) async {
    var cityProvider = Provider.of<CityProvider>(context, listen: false);
    getMathod(BASE_URL + CITY + '$id', context).then((value) {
      cityProvider.setDropdownModel(CityModel.fromJson(value));
      cityProvider.setListDropDrown();
      print(cityProvider.dropdownCityModel!.data![0].title);
    });
  }

  Future markNotifications(BuildContext context, readCount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bearer = prefs.getString('bearer');
    var url = Uri.parse(BASE_URL + NOTIFICATIONS_MARKREAD);
    var response = await http.patch(url,
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $bearer',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"notificationIds": readCount}));

    print("Read Count from API call: $readCount");

    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // notifications(context);
      return jsonData['data'];
    } else {
      showFlushBar(context, "${jsonData['message']}");
      print("something went wrong");
    }
  }

  Future getBankList(context) async {
    var bankListProvider =
    Provider.of<BankListProvider>(context, listen: false);
    getMathod(BASE_URL + "bank?page=1&limit=50", context).then((value) {
      bankListProvider.setBankList(BankListModel.fromJson(value));
    });
  }



  ///-----application-v2/multi/form/submission-----///

  Future submitRegFuncNewMultiformCostumer(
      BuildContext context,
      mapIds,
      name,
      fatherName,
      email,
      cnic,
      dob,
      passport,
      address,
      profession,
      organization,
      whatsAppNo,
      mobile,
      telephone,
      status,
      ) async {
    print("Function run");
    var url = Uri.parse(BASE_URL + "application-v2/multi/form/submission");
    EasyLoading.instance..backgroundColor = AppColors.PRIMARY_COLOR;
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = AppColors.PRIMARY_COLOR
      ..indicatorColor = AppColors.SCAFFOLD_COLOR
      ..textColor = AppColors.SCAFFOLD_COLOR
      ..indicatorSize = 35.0
      ..radius = 10.0
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = false
      ..dismissOnTap = false;
    EasyLoading.show(
        status: "Please Wait", maskType: EasyLoadingMaskType.custom);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var remainingFormSubmittedOnCnicProvider =
    Provider.of<RemainingFormSubmittedOnCnicProvider>(context,
        listen: false);
    var listOfPlotsProvider =  Provider.of<ListOfPlotsProvider>(context, listen: false);
    var map = new Map<String, dynamic>();

    map["applicationV2Ids"] = mapIds;

    if(name == ""){}else{
      map['name'] = '$name';
    }

    if(fatherName == ""){}else{
      map['fatherName'] = '$fatherName';
    }

    if (email == "") {
    }else{
      map['email'] = '$email';
    }
    if(cnic == ""){}else{
      map['cnic'] = cnic;
    }


    if(dob == ""){}else{
      map['dob'] = dob;
    }


    if (passport == "") {
    } else {
      map['passport'] = passport;
    }

    if(address == ""){
    }else{
      map['address'] = address;
    }


    if (profession == "") {
    } else {
      map['profession'] = profession;
    }
    if (organization == "") {
    } else {
      map['organization'] = organization;
    }

    if(whatsAppNo == ""){

    }else{
      map['whatsAppNo'] = whatsAppNo;
    }

    if(mobile == ""){

    }else{
      map['mobile'] = mobile;
    }

    if (telephone == "") {
    } else {
      map['telephone'] = telephone;
    }
    map['status'] = status;


    var bearer = prefs.getString('bearer');
    try {
      var response = await http.post(url,
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $bearer',
          },
          body: jsonEncode(map));
      print(jsonEncode(map));


      var jsonData = jsonDecode(response.body);
      if (response.statusCode == 201) {
        EasyLoading.dismiss();
        //var blinqInvoice = jsonData['data']['blinqInvoice'];
        // Navigator.pushReplacement( context,
        //  MaterialPageRoute(builder: (context) => BottomBarWidget()),
        //  );

        ///---///

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomBarWidget(getIndex: 1,)));
        listOfPlotsProvider.resetListOfPlotIds();
    //    utilProvider.resetListOfPlotIds();
        remainingFormSubmittedOnCnicProvider.restRemainigFormCount();

          if(status == 'DRAFT'){
            showFlushBar(context, "Form submitted to Draft");
          }else{
            showFlushBar(context, "${jsonData['message']}");
          }

      } else {
        EasyLoading.dismiss();
        showFlushBar(context, "${jsonData['message']}");
        print("${jsonData['message']}");
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }





  ///-----real-estate/submit-multi-application-request-----///

  Future submitRegFuncNewMultiformAgent(
      BuildContext context,
      {mapIds,
        name,
        email,
        cnic,
        whatsAppNo,
        phone}
      ) async {
    print("Function run");
    var url = Uri.parse(BASE_URL + "real-estate/submit-multi-application-request");
    EasyLoading.instance..backgroundColor = AppColors.PRIMARY_COLOR;
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = AppColors.PRIMARY_COLOR
      ..indicatorColor = AppColors.SCAFFOLD_COLOR
      ..textColor = AppColors.SCAFFOLD_COLOR
      ..indicatorSize = 35.0
      ..radius = 10.0
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = false
      ..dismissOnTap = false;
    EasyLoading.show(
        status: "Please Wait", maskType: EasyLoadingMaskType.custom);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var remainingFormSubmittedOnCnicProvider =
    Provider.of<RemainingFormSubmittedOnCnicProvider>(context,
        listen: false);
    var listOfPlotsProvider =  Provider.of<ListOfPlotsProvider>(context, listen: false);
    var map = new Map<String, dynamic>();

    map["realEstateApplicationIds"] = mapIds;


      map['name'] = '$name';


      map['cnic'] = cnic;


    map['phone'] = phone;
    if(whatsAppNo == ""){}else{
      map['whatsAppNo'] = whatsAppNo;
    }

      map['email'] = '$email';



    var bearer = prefs.getString('bearer');
    try {
      var response = await http.post(url,
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $bearer',
          },
          body: jsonEncode(map));
      print(jsonEncode(map));


      var jsonData = jsonDecode(response.body);
      if (response.statusCode == 201) {
        EasyLoading.dismiss();
        print("Data response: ${jsonData["message"]}");
        print("mapped Data  $mapIds"  );
        ///---///

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AgentBottomBarWidget(getIndex: 1,)));

        BaseService().showFlushBar(context, "${jsonData["message"]}");

        listOfPlotsProvider.resetListOfPlotIds();
        //    utilProvider.resetListOfPlotIds();
        remainingFormSubmittedOnCnicProvider.restRemainigFormCount();

      } else {
        EasyLoading.dismiss();
        showFlushBar(context, "${jsonData['message']}");
        print("${jsonData['message']}");
      }
    } catch (e) {
      if (e is SocketException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Server is busy , Try Later");
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        EasyLoading.dismiss();
        showFlushBar(context, "Session out Try Again");
        //treat TimeoutException
        print("Timeout exception: Please try later");
      } else
        print("Something went wrong");
    }
  }




              ///----Notification----///

  Future<NotificationModel> getNotification(context) async {
    final url = Uri.parse(BaseUrl + "v1/agent-notification?page=1&limit=100");
    var response = await http.get(url, headers: {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });
    final body = jsonDecode(response.body.toString());
    print("Status code ${response.statusCode}");

    return NotificationModel.fromJson(body);
  }
}




}



