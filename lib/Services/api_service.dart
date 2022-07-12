// ignore_for_file: missing_return, non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:medcare/Models/bookingDetail_model.dart';
import 'package:medcare/Services/auth.dart';
import 'package:http/http.dart' as http;

import '../Models/user_account_model.dart';

class ApiService {
  // ignore: todo
  String baseurl = 'suhfuisviusdj'; //TODO:add auth url here for other process

  //Request to send invoice

  Future<String?> resetPassword(String email) async {
    String finalUrl = "$baseurl/users/resetPassword";
    Object apiBody = {"email": "$email"};
    var headers = {'': '', 'Content-Type': 'application/json'};
    var res = await http.post(
      Uri.parse(finalUrl),
      body: jsonEncode(apiBody),
      headers: headers,
    );

    log(res.body.toString());

    if (res.statusCode == 200) {
      return res.body;
    } else {
      return null;
    }
  }

  //Request to send verification email to user
  Future<http.Response> sendVerificationEmail(
    String userID,
    String email,
  ) async {
    String finalUrl = "$baseurl/users/verifyEmail";
    String idToken = AuthServices().idToken;
    Object apiBody = {"userID": "$userID", "email": "$email"};
    var headers = {
      '': '',
      'Authorization': 'Bearer $idToken',
      'Content-Type': 'application/json'
    };

    var res = await http.post(
      Uri.parse(finalUrl),
      body: jsonEncode(apiBody),
      headers: headers,
    );
    log("USERID $userID");
    log(res.body.toString());
    log(res.statusCode.toString());
    return res;
  }

  Future<UserModel> getUserDetails(String userid) async {
    try {
      String finalUrl = "$baseurl/users/$userid";
      String idToken = AuthServices().idToken;
      log("IN API--");
      log(idToken.toString());
      var headers = {
        '': '',
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json'
      };
      var res = await http.get(
        Uri.parse(finalUrl),
        headers: headers,
      );
      log(finalUrl.toString());
      log(res.statusCode.toString());
      //log(res.body.toString());
      return UserModel.fromJson(jsonDecode(res.body));
    } catch (e) {
      log("Error on API --->>>>>  ");
      log(e.toString());
      rethrow;
    }
  }

  Future<int> postJournals(
    String userId,
    String title,
    String body,
    String myDate,
    int color,
  ) async {
    try {
      String finalUrl = "$baseurl/journals";
      String idToken = await AuthServices().idToken;
      log("IN API--");
      log(idToken.toString());
      var headers = {
        '': '',
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json'
      };
      Object apiBody = {
        "userID": userId,
        "title": title,
        "body": body,
        "date": myDate,
        "color": color,
      };
      var res = await http.post(
        Uri.parse(finalUrl),
        headers: headers,
        body: jsonEncode(apiBody),
      );
      log(finalUrl.toString());
      log(res.statusCode.toString());
      log(res.body.toString());
      return res.statusCode;
    } catch (e) {
      log("Error on API --->>>>>  ");
      log(e.toString());
      rethrow;
    }
  }

  Future<int> sendSignUpInfo(
    String userName,
    String userUid,
    String dob,
    String email,
    String gender,
    String country,
    String contactNo,
    bool phoneVerified,
    bool emailVerified,
    String imgUrl,
    bool isProfileCompleted,
  ) async {
    try {
      String finalUrl = "$baseurl/users/register";
      String idToken = await AuthServices().idToken;
      log("IN API--");
      log(idToken.toString());
      var headers = {
        '': '',
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json'
      };
      Object apiBody = {
        "userID": "$userUid",
        "name": "$userName",
        "dob": "$dob",
        "email": "$email",
        "emailVerified": emailVerified,
        "gender": "$gender",
        "contactNo": "$contactNo",
        "contactNoVerified": phoneVerified,
        "imgUrl": "$imgUrl",
        "profileCompleted": isProfileCompleted,
      };
      var res = await http.post(
        Uri.parse(finalUrl),
        headers: headers,
        body: jsonEncode(apiBody),
      );
      log(finalUrl.toString());
      log(res.statusCode.toString());
      log(res.body.toString());
      return res.statusCode;
    } catch (e) {
      log("Error on API --->>>>>  ");
      log(e.toString());
      rethrow;
    }
  }

  Future<int> updateUser(
    String userName,
    String userUid,
    String dob,
    String email,
    String gender,
    String country,
    String contactNo,
    bool phoneVerified,
    bool emailVerified,
    String imgUrl,
    bool isProfileCompleted,
  ) async {
    try {
      String finalUrl = "$baseurl/users/$userUid";
      String idToken = await AuthServices().idToken;
      log("IN API--");
      log(idToken.toString());
      var headers = {
        '': '',
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json'
      };
      Object apiBody = {
        "userID": "$userUid",
        "name": "$userName",
        "dob": "$dob",
        "email": "$email",
        "emailVerified": emailVerified,
        "gender": "$gender",
        "contactNo": "$contactNo",
        "contactNoVerified": phoneVerified,
        "imgUrl": "$imgUrl",
        "profileCompleted": isProfileCompleted,
      };
      var res = await http.patch(
        Uri.parse(finalUrl),
        headers: headers,
        body: jsonEncode(apiBody),
      );
      log(finalUrl.toString());
      log(res.statusCode.toString());
      log(res.body.toString());
      return res.statusCode;
    } catch (e) {
      log("Error on API --->>>>>  ");
      log(e.toString());
      rethrow;
    }
  }

  Future<int> markPhoneTrue(
    String userUid,
    bool phoneVerified,
  ) async {
    try {
      String finalUrl = "$baseurl/users/$userUid";
      String idToken = await AuthServices().idToken;
      log("IN API--");
      //log(idToken.toString());
      var headers = {
        '': '',
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json'
      };
      Object apiBody = {
        "userID": "$userUid",
        "contactNoVerified": phoneVerified,
      };
      var res = await http.patch(
        Uri.parse(finalUrl),
        headers: headers,
        body: jsonEncode(apiBody),
      );

      log(finalUrl.toString());
      log(res.statusCode.toString());
      log(res.body.toString());
      return res.statusCode;
    } catch (e) {
      log("Error on API --->>>>>  ");
      log(e.toString());
      rethrow;
    }
  }

  Future<int> UpdateUserEmail(
    String userUid,
    String email,
  ) async {
    try {
      String finalUrl = "$baseurl/users/$userUid";
      String idToken = AuthServices().idToken;
      log("IN API--");
      //log(idToken.toString());

      var headers = {
        '': '',
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json'
      };
      Object apiBody = {
        "userID": "$userUid",
        "email": "$email",
      };

      log(apiBody.toString());
      var res = await http.patch(
        Uri.parse(finalUrl),
        headers: headers,
        body: jsonEncode(apiBody),
      );

      log(finalUrl.toString());
      log(res.statusCode.toString());
      log(res.body.toString());
      return res.statusCode;
    } catch (e) {
      log("Error on API MERGE EMAIL --->>>>>  ");
      log(e.toString());
      rethrow;
    }
  }

  //------------BOOKING APIS---------------------------------------------------------------------

  //Booking Summary Initiate API------------------------------------------------
  Future<http.Response> bookingInitiate(BookingDetail bookingDetail) async {
    String idToken = await AuthServices().idToken;
    var headers = {
      '': '',
      'Authorization': 'Bearer $idToken',
      'Content-Type': 'application/json'
    };
    Object apiBody = {
      "userID": "${bookingDetail.bookingUserUID}",
      "doctorID": "${bookingDetail.bookingExpertUID}",
      "slotDate": "${bookingDetail.bookingSlotDate}",
      "slotTime": "${bookingDetail.bookingSlotTime}",
      "therapy": "${bookingDetail.bookingTherapyName}",
      "bookingType": "personal"
    };

    String finalUrl = '$baseurl/booking/sessions';
    var res = await http.post(
      Uri.parse(finalUrl),
      headers: headers,
      body: jsonEncode(apiBody),
    );

    log(finalUrl);
    log(res.statusCode.toString());
    log(res.body);
    log('within api service signup func');
    return res;
  }

  // Agora APP Token------------------------------------------------------------
  Future<List<String>> getAgoraToken(String userID, String sessonID) async {
    String finalUrl = "$baseurl/sessions/$sessonID/agora?uid=$userID";
    var res = await http.get(
      Uri.parse(finalUrl),
    );

    List<String> myAns = [];
    myAns.add(jsonDecode(res.body)['token']);
    myAns.add(jsonDecode(res.body)['channel']);
    return myAns;
  }

  // GUARDIAN CONSENT REQUEST
  Future<int> sendConsentRequest(String email) async {
    var idToken = await AuthServices().idToken;
    String finalUrl = "$baseurl/get_parents_mail?mail=$email";
    var res = await http.get(
      Uri.parse(finalUrl),
      headers: {HttpHeaders.authorizationHeader: idToken},
    );

    log(res.statusCode.toString());
    log(res.body.toString());
    return res.statusCode;
  }

  Future<int> checkUserEmailVerified(String userID, String email) async {
    String finalUrl = "$baseurl/users/checkEmailVerified";
    String idToken = await AuthServices().idToken;
    Object apiBody = {"userID": userID, "email": email};
    var headers = {
      '': '',
      'Authorization': 'Bearer $idToken',
      'Content-Type': 'application/json'
    };

    log("IN EMAIL VERIFY");

    var res = await http.post(
      Uri.parse(finalUrl),
      body: jsonEncode(apiBody),
      headers: headers,
    );

    return res.statusCode;
  }
}
