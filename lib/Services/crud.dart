import 'dart:developer';
import 'package:medcare/Models/expertModel.dart';

class DatabaseService {
  //---- List of all doctors to be converted into ExpertModel
/*   List<ExpertModel> getExpertModelList(QuerySnapshot snapshot) {
    List<ExpertModel> listOfExperts = [];
    for (var doc in snapshot.docs) {
      ExpertModel currentExpert = ExpertModel.fromJson(doc.data());
      listOfExperts.add(currentExpert);
    }
    return listOfExperts;
  } */

  //---- List of all schedules of a doctor to be converted into ScheduleModel
  /*  List<ScheduleModel> getScheduleModelLists(QuerySnapshot snapshot) {
    List<ScheduleModel> listOfSchedules = [];
    for (var doc in snapshot.docs) {
      ScheduleModel currentSchedule = ScheduleModel.fromJson(doc.data());
      listOfSchedules.add(currentSchedule);
    }
    return listOfSchedules;
  }
 */
  //---- List of sessions of a user
  /* List<SessionModel> getSessionModelLists(QuerySnapshot snapshot) {
    List<SessionModel> listOfSessions = [];

    for (var doc in snapshot.docs) {
      SessionModel currentSession = SessionModel.fromJson(doc.data(), doc.id);
      String uid = doc.id;
      log('Session UID is $uid');
      listOfSessions.add(currentSession);
    }
    return listOfSessions;
  }

  List<List<SessionModel>> getUpcomingSessionLists(
      List<SessionModel> listOfReceivedSessions) {
    List<SessionModel> listOfUpcomingSessions = [];
    List<SessionModel> listOfPreviousSessions = [];
    List<List<SessionModel>> listOfSessions = [];

    
    for (SessionModel session in listOfReceivedSessions) {
      if (session.sessionDate.compareTo(my) >= 0)
        listOfUpcomingSessions.add(session);
      else
        listOfPreviousSessions.add(session);
    }

    listOfSessions = [listOfUpcomingSessions, listOfPreviousSessions];
    return listOfSessions;
  }

  //--- Retrieve a specific expert profile with doctor id
  Future<ExpertModel> getExpertProfile(String expertUID) async {
    DocumentSnapshot expertDoc = await FirebaseFirestore.instance
        .collection('doctors')
        .doc(expertUID)
        .get();
    ExpertModel retrievedExpert = ExpertModel.fromJson(expertDoc.data());
    return retrievedExpert;
  }

  //--- List of all reviews for an expert
  List<ReviewModel> getReviewsList(QuerySnapshot snapshot) {
    List<ReviewModel> listOfReviews = [];

    for (var doc in snapshot.docs) {
      ReviewModel currentReview = ReviewModel.fromJson(doc.data());
      listOfReviews.add(currentReview);
    }
    return listOfReviews;
  }
 */
  /*  //---Create initial User Document
  Future<void> postInitialSignIn(String uid, bool isPhoneVerified,
      bool isEmailVerified, String phoneNumber, String email) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'userID': uid,
      'contactNo': phoneNumber,
      'email': email,
      'isPhoneVerified': isPhoneVerified,
      'isEmailVerified': isEmailVerified,
      'isProfileCompleted': false,
      'name': '',
      'gender': '',
      'dob': '',
      'imgUrl': ''
    });
  } */

  //--Check if user document exists
  /* Future<bool> userDocumentExists(String uid) async {
    var a = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return true;
      } else
        return false;
    });
    return a;
  } */

  //---Submit review and rating for a session
  Future<void> postReviewAndRating(
    int sessionRating,
    String sessionReview,
    String sessionUID,
    String sessionUserName,
    String sessionUserUID,
    String sessionExpertUID,
  ) async {
    if (sessionReview.isEmpty) {
    } else {}
  }

  //-----JOURNAL
  //----- Post Journal

  /* Future postRegistrationToken() async {
    String token;
    String idToken = await AuthServices().getIdToken();
    await FirebaseMessaging.instance.getToken().then((value) {
      token = value;
    });
    log("FCM TOKEN");
    log(idToken);
    try {
      await userCollection
          .doc(AuthServices().returnUserUID())
          .update({'registrationToken': token});
    } catch (e) {
      log("Just beforre homepage");
      log(e.toString());
    }
  }
 */
  /* Future<String> updateUserAccount(UserModel model) async {
    try {
      await userCollection.doc(AuthServices().returnUserUID()).update({
        'name': model.user_name,
        'email': model.user_email,
        'contactNo': model.user_phone,
        'userID': AuthServices().returnUserUID(),
        'profileCompleted': true,
        // 'emailVerified': true,
        // 'phoneVerified': true,
        'dob': model.user_dob,
        'gender': model.user_gender,
        'imgUrl': model.user_imgUrl
      });
      return "passed";
    } on FirebaseException catch (e) {
      log(e.code);
      log(e.message);
      return null;
    }
  }

  Future<String> postUserImage(File image, String uid) async {
    log("Uploading image to $uid");
    log("IMAGE PATH ${image.path}");

    try {
      var myFile = File(image.path);
      log(myFile.toString());
      var snapshot =
          await _firebaseStorage.ref('userimages/$uid').putFile(myFile);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      log("IMAGE URL IS $downloadUrl");
      return downloadUrl;
    } catch (e) {
      log("ERROR IN UPLOADING:: --->>>" + e.toString());
      log(e.code);
      log(e.message);
      return null;
    }
  } */
}
