// ignore_for_file: non_constant_identifier_names

class UserModel {
  String user_name;
  String user_email;
  String user_gender;
  String user_phone;
  String user_uid;
  String user_imgUrl;
  String user_dob;
  bool isUserPhoneVerified;
  bool isUserEmailVerified;
  bool isProfileCompleted;
  List user_doctor_ids;

  UserModel({
    required this.user_name,
    required this.user_email,
    required this.user_phone,
    required this.user_gender,
    required this.user_uid,
    required this.user_imgUrl,
    required this.user_dob,
    required this.isUserPhoneVerified,
    required this.isUserEmailVerified,
    required this.isProfileCompleted,
    required this.user_doctor_ids,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    //TODO: ADD Verification booleans
    return UserModel(
      user_name: json['name'],
      user_email: json['email'],
      user_phone: json['contactNo'],
      user_dob: json['dob'],
      user_gender: json['gender'],
      user_imgUrl: json['imgUrl'],
      user_uid: json['userID'],
      isUserEmailVerified: json['emailVerified'],
      isUserPhoneVerified: json['contactNoVerified'],
      isProfileCompleted: json['profileCompleted'],
      user_doctor_ids: json['doctorIDs'],
    );
  }
}
