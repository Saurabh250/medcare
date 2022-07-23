// ignore_for_file: missing_return, await_only_futures

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:amigoapp/Models/bookingDetail_model.dart';
import 'package:amigoapp/Models/bookingdata_model.dart';
import 'package:amigoapp/Models/expertModel.dart';
import 'package:amigoapp/Models/reviewModel.dart';
import 'package:amigoapp/Models/scheduleModel.dart';
import 'package:amigoapp/Models/user_account_model.dart';
import 'package:amigoapp/Screens/BookingSummary/booking_summary.dart';
import 'package:amigoapp/Screens/Edit_Account/edit_account.dart';
import 'package:amigoapp/Services/api_service.dart';
import 'package:amigoapp/Services/auth.dart';
import 'package:amigoapp/Services/crud.dart';
import 'package:amigoapp/Utils/color_constants.dart';
import 'package:amigoapp/Utils/constant_components.dart';
import 'package:amigoapp/Utils/loading_screen.dart';
import 'package:amigoapp/Utils/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'components/components.dart';

class ExpertProfile extends StatefulWidget {
  final ExpertModel currentExpert;
  final int indexOfTherapy;
  final String therapyName;

  //-- Getting index of chosen therapy
  ExpertProfile({this.currentExpert, this.indexOfTherapy, this.therapyName});

  @override
  _ExpertProfileState createState() => _ExpertProfileState();
}

class _ExpertProfileState extends State<ExpertProfile> {
  bool isLoading = false;
  bool readMore = false;
  bool readMoreButtonEnabled = false;
  BookingAmountModel _bookingAmountModel;
  ExpertModel _expert;
  BookingDetail _bookingDetail;

  UserModel currentUser;
  bool isEmailVerified = false;
  bool isPhoneVerified = false;
  bool isProfileCompleted = false;
  //----- Today's date needed for sessions

  //----SELECTED DATE and TIME INDEX variables
  int _selectedDateIndex = 0;
  int _selectedTimeIndex = -1;

  //----SELECTED DATE AND TIME
  DateTime _selectedDate;
  String _selectedTime = '';

  //--- List of schedule models to be updated based on Firebase
  List<ScheduleModel> listOfSchedules = [];
  List _selectedTimeSlot = [];
  Map _selectedDateSlotAvailability;

  //--- Availability

  //Storage of listoFSchedules for current doctor

  List<String> weekDay = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

  //REVIEWS
  int numberOfReviews = 0;
  List<ReviewModel> listOfReviews = [];

  void getCurrentUser() async {
    String userID = AuthServices().returnUserUID();
    currentUser = await ApiService().getUserDetails(userID);
    isEmailVerified = currentUser.isUserEmailVerified;
    isPhoneVerified = currentUser.isUserPhoneVerified;
    isProfileCompleted = currentUser.isProfileCompleted;
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getReviews();
  }

  @override
  Widget build(BuildContext context) {
    int expBioLength = widget.currentExpert.expertBio.length;
    if (expBioLength >= 200) readMoreButtonEnabled = true;
    log(widget.currentExpert.expertUID.toString());
    //----- Today's date needed for sessions
    Timestamp oneDayfromPresent =
        Timestamp.fromDate(DateTime.now().add(Duration(days: 1)));
    Timestamp eightDayFromPresent =
        Timestamp.fromDate(DateTime.now().add(Duration(days: 8)));
    //-----Temporary storage of therapy name and price passed from listing page
    String therapyName =
        widget.currentExpert.expertTherapyTypes[widget.indexOfTherapy];
    String therapyPrice =
        widget.currentExpert.expertTherapyPrices[therapyName].toString();
    return isLoading
        ? LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: amigo_white,
              centerTitle: true,
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: SizeConfig.heightMultiplier * 2.5,
                    color: amigo_grey,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              title: Text(
                widget.therapyName,
                style: regulartextstyle(
                  SizeConfig.appBarTextSize,
                  amigo_grey,
                  false,
                ),
              ),
            ),

            //--Booking button attached to bottom nav bar for booking
            bottomSheet: bookingButton(therapyPrice),

            //-- main body of page
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.only(
                  left: SizeConfig.widthMultiplier * 4,
                  right: SizeConfig.widthMultiplier * 4,
                  bottom: SizeConfig.heightMultiplier * 7.5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.widthMultiplier * 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              expertImageCard(
                                  widget.currentExpert.expertImgUrl),
                              expertDetail(
                                widget.currentExpert.expertName,
                                widget.currentExpert.expertReferredAs,
                                widget.currentExpert.expertRating,
                                widget.currentExpert
                                    .expertTherapyPrices[therapyName]
                                    .toString(),
                                widget.currentExpert
                                    .expertTherapyStrikedPrices[therapyName]
                                    .toString(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ExpertDetail(
                      currentExpert: widget.currentExpert,
                    ),
                    SizedBox(height: SizeConfig.regulartextSize),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.widthMultiplier,
                      ),
                      child: Text(
                        'Book a 45 minutes video call', //CHANGED TEXT FOR SLOTS
                        style: regulartextstyle(
                          SizeConfig.regulartextSize,
                          amigo_grey,
                          true,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.regulartextSize / 2,
                    ),
                    slotDateColumn(oneDayfromPresent, eightDayFromPresent),
                    SizedBox(height: SizeConfig.regulartextSize),
                    numberOfReviews == 0
                        ? Center(
                            child: Text(
                              'No reviews for the therapist yet',
                              style: regulartextstyle(
                                SizeConfig.regulartextSize * 0.7,
                                amigo_lightGrey,
                                false,
                              ),
                            ),
                          )
                        : Text(
                            'Reviews',
                            style: regulartextstyle(
                              SizeConfig.regulartextSize,
                              amigo_grey,
                              true,
                            ),
                          ),
                    numberOfReviews != 0
                        ? Column(
                            children: List.generate(
                              numberOfReviews,
                              (index) => reviewBox(index),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          );
  }

  Future<List> getReviews() async {
    QuerySnapshot doc = await FirebaseFirestore.instance
        .collection('doctors')
        .doc(widget.currentExpert.expertUID)
        .collection('reviews')
        .where('reviewPresent', isEqualTo: true)
        .get();
    listOfReviews = DatabaseService().getReviewsList(doc);
    log(listOfReviews.toString());

    if (doc.size != numberOfReviews)
      setState(() {
        numberOfReviews = doc.size;
      });
  }

  Widget reviewBox(int index) {
    log('NUMBER OF REVIEWS $numberOfReviews');
    log('INDEX IS $index');
    log(listOfReviews[index].reviewText);
    return Container(
      //RATING & REVIEW REDEFINED
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.widthMultiplier * 1.5,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: amigo_lightGrey,
                    size: SizeConfig.regulartextSize,
                  ),
                  SizedBox(
                    width: SizeConfig.widthMultiplier / 2,
                  ),
                  Text(
                    // 'check',
                    listOfReviews[index].reviewUserName,
                    style: regulartextstyle(
                      SizeConfig.regulartextSize * 0.6,
                      amigo_lightGrey,
                      false,
                    ),
                  )
                ],
              ),
              Row(
                children: List.generate(
                  listOfReviews[index].reviewRatingValue,
                  (index) => Icon(
                    Icons.star,
                    color: Colors.orangeAccent,
                    size: SizeConfig.regulartextSize,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.widthMultiplier),
          Text(
            // 'check',
            listOfReviews[index].reviewText,
            textAlign: TextAlign.start,
            style: regulartextstyle(
              SizeConfig.regulartextSize * 0.8,
              amigo_grey,
              false,
            ),
          ),
        ],
      ),
    );
  }

  //---SLOT SYSTEM

  StreamBuilder<QuerySnapshot<Object>> slotDateColumn(
      Timestamp initialdate, Timestamp lastDate) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('doctors')
            .doc(widget.currentExpert.expertUID)
            .collection('schedule')
            .orderBy('date')
            .where('date', isGreaterThan: initialdate)
            .where('date', isLessThanOrEqualTo: lastDate)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.hasError ||
              snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null) {
            return Row(
              children: List.generate(
                7,
                (index) => Container(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.widthMultiplier),
                  width: ((SizeConfig.widthMultiplier * 100) -
                          SizeConfig.widthMultiplier * 8) /
                      7,
                  decoration: BoxDecoration(
                      color: _selectedDateIndex == index
                          ? amigo_blue
                          : amigo_white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(width: 0.5)),
                  child: Column(
                    children: [
                      Text(
                        '  ',
                        style: regulartextstyle(
                          SizeConfig.regulartextSize,
                          _selectedDateIndex == index
                              ? amigo_white
                              : amigo_grey,
                          true,
                        ),
                      ),
                      Text(
                        '  ',
                        style: regulartextstyle(
                          SizeConfig.regulartextSize * .8,
                          _selectedDateIndex == index
                              ? amigo_white
                              : amigo_grey,
                          false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.data.size == 0) {
            return Center(
              child: Text(
                'No slots available for the therapist this week',
                style: regulartextstyle(
                  SizeConfig.regulartextSize * 0.7,
                  amigo_lightGrey,
                  false,
                ),
              ),
            );
          } else {
            // Schedule => Date,Slots => Availability
            // List of all schedule models of chosen expert, connected to stream builder
            listOfSchedules =
                DatabaseService().getScheduleModelLists(snapshot.data);
            log("Number of slots ${listOfSchedules.length}");

            _selectedDate =
                listOfSchedules[_selectedDateIndex].expertSlotDate.toDate();
            // Updating Selected Time Slot of the particular day
            // _selectedDateIndex is the selected schedule from listofschedules
            _selectedTimeSlot =
                listOfSchedules[_selectedDateIndex].expertSlotLists;
            // Updating Availabilty Map of selected day
            _selectedDateSlotAvailability =
                listOfSchedules[_selectedDateIndex].expertSlotAvailability;
            // Number of slots of the selected day
            int numberOfSlots =
                listOfSchedules[_selectedDateIndex].expertSlotLists.length;

            return Column(
              children: [
                Row(
                  children: List.generate(
                    listOfSchedules.length,
                    (index) => slotDateButton(index, listOfSchedules),
                  ),
                ),
                listOfSlotTime(numberOfSlots),
              ],
            );
          }
        });
  }

  Widget slotDateButton(int index, List<ScheduleModel> listOfSchedules) {
    DateTime dateAtIndex = listOfSchedules[index].expertSlotDate.toDate();
    String date =
        '${listOfSchedules[index].expertSlotDate.toDate().day}/${listOfSchedules[index].expertSlotDate.toDate().month}';
    String day =
        weekDay[listOfSchedules[index].expertSlotDate.toDate().weekday - 1];
    print("$index   $date");
    return InkWell(
      onTap: () {
        onSelectingDate(index, dateAtIndex);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.widthMultiplier),
        width: ((SizeConfig.widthMultiplier * 100) -
                SizeConfig.widthMultiplier * 8) /
            7,
        decoration: BoxDecoration(
            color: _selectedDateIndex == index ? amigo_blue : amigo_white,
            shape: BoxShape.rectangle,
            border: Border.all(width: 0.5, color: amigo_lightGrey)),
        child: Column(
          children: [
            Text(
              date,
              style: regulartextstyle(
                  SizeConfig.regulartextSize,
                  _selectedDateIndex == index ? amigo_white : amigo_grey,
                  false),
            ),
            Text(
              day,
              style: regulartextstyle(
                SizeConfig.regulartextSize * .6,
                _selectedDateIndex == index ? amigo_white : amigo_grey,
                false,
              ),
            )
          ],
        ),
      ),
    );
  }

  Container listOfSlotTime(int numberOfSlots) {
    return Container(
      height:
          SizeConfig.heightMultiplier * 5 * (numberOfSlots / 4).ceilToDouble(),
      child: GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 2.5 / 1,
        crossAxisSpacing: SizeConfig.widthMultiplier,
        children: List.generate(
          numberOfSlots,
          (index) => slotTime(index),
        ),
      ),
    );
  }

  Widget slotTime(int index) {
    print("Index of button $index");
    String availability =
        _selectedDateSlotAvailability[_selectedTimeSlot[index]];

    bool available = availability == 'Available' ? true : false;

    Color backgroundcolor = amigo_light_lightGrey;

    if (available)
      backgroundcolor = _selectedTimeIndex == index ? amigo_blue : amigo_white;

    Color textColor = _selectedTimeIndex == index ? amigo_white : amigo_blue;
    String timeText = _selectedTimeSlot[index];

    return InkWell(
      onTap: () {
        onSelectingTime(index, available, timeText);
      },
      child: Container(
        margin: EdgeInsets.only(top: SizeConfig.widthMultiplier * 2),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier,
          vertical: SizeConfig.widthMultiplier / 2,
        ),
        decoration: BoxDecoration(
          color: backgroundcolor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(13),
          border: _selectedTimeIndex != index
              ? Border.all(
                  width: 1,
                  color: available ? amigo_blue : amigo_light_lightGrey,
                )
              : null,
        ),
        width: ((SizeConfig.widthMultiplier * 100) -
                SizeConfig.widthMultiplier * 8) /
            4.5,
        child: Center(
          child: Text(
            timeText,
            style: regulartextstyle(SizeConfig.regulartextSize * 0.9,
                available ? textColor : amigo_white, false),
          ),
        ),
      ),
    );
  }

  //---Booking Button
  InkWell bookingButton(String therapyPrice) {
    return InkWell(
      onTap: () async {
        if (!isEmailVerified || !isPhoneVerified || !isProfileCompleted)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditAccount(),
            ),
          );
        else if (_selectedTimeIndex == -1) {
          await showNotificationDialog(
            "Error",
            "Please select some slot first",
            "",
            "Okay",
            context,
          );
        } else {
          log(_selectedTimeIndex.toString() +
              " TIME " +
              _selectedTime.toString());
          onSelectingBooking();
        }
      },
      child: bookButtonComponent(therapyPrice),
    );
  }

  // Functionality of Buttons

  onSelectingDate(int indexOfDateButton, DateTime dateText) {
    setState(() {
      _selectedDate = dateText;
      _selectedDateIndex = indexOfDateButton;
    });
  }

  onSelectingTime(int indexOfTimeButton, bool availablity, String timeText) {
    if (availablity) {
      setState(() {
        _selectedTime = timeText;
        _selectedTimeIndex = indexOfTimeButton;
      });
    } else
      ScaffoldMessenger.of(context).showSnackBar(
        snackBarComponent(
          context,
          'Choose an available time slot',
          amigo_blue,
        ),
      );
  }

  onSelectingBooking() async {
    setState(() {
      isLoading = true;
    });
    String bookingDate = _selectedDate.year.toString() +
        '-' +
        _selectedDate.month.toString() +
        "-" +
        _selectedDate.day.toString();

    log("Booking Tapped");
    log(bookingDate);
    log(_selectedTime + 'TIME IS HERE');

    String uid = AuthServices().returnUserUID();
    print("UID is $uid");

    BookingDetail bookingDetail = BookingDetail(
      bookingExpertUID: widget.currentExpert.expertUID,
      bookingUserUID: uid,
      bookingSlotDate: bookingDate,
      bookingTherapyName: widget.therapyName,
      bookingSlotTimestamp: _selectedDate,
      bookingSlotTime: _selectedTime,
    );

    _bookingDetail = bookingDetail;
    _expert = widget.currentExpert;

    var res = await ApiService().bookingInitiate(bookingDetail);

    if (res.statusCode == 200) {
      log(res.body);

      BookingAmountModel bookingDataModel =
          BookingAmountModel.fromJson(jsonDecode(res.body));
      _bookingAmountModel = bookingDataModel;

      String error = jsonDecode(res.body)['errorMessage'];

      if (error != null)
        showNotificationDialog(error, '', '', 'Okay', context);
      else
        setState(() {
          isLoading = false;
        });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingSummary(
            bookingExpert: _expert,
            bookingDetail: _bookingDetail,
            bookingAmountModel: _bookingAmountModel,
            currentUser: currentUser,
          ),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      String error = jsonDecode(res.body)['errorMessage'];
      showNotificationDialog('', error, '', 'Okay', context);
    }
  }
}
