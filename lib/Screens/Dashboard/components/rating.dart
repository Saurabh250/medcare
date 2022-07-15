import 'dart:developer';

import 'package:amigoapp/Models/session_model.dart';
import 'package:amigoapp/Services/crud.dart';
import 'package:amigoapp/Utils/color_constants.dart';
import 'package:amigoapp/Utils/constant_components.dart';
import 'package:amigoapp/Utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class Rating extends StatefulWidget {
  final SessionModel currentSession;

  const Rating({Key key, this.currentSession}) : super(key: key);

  @override
  RatingState createState() => RatingState(session: currentSession);
}

class RatingState extends State<Rating> {
  SessionModel session;
  RatingState({this.session});
  TextEditingController _reviewController = TextEditingController();
  int rating = 4;
  @override
  Widget build(BuildContext context) {
    log(session.sessionUID.toString());
    // session = widget.currentSession;
    Text title = Text(
      'Review the session with\n${session.sessionExpertName}',
      textAlign: TextAlign.center,
      style: regulartextstyle(
        SizeConfig.regulartextSize,
        amigo_grey,
        false,
      ),
    );
    return Platform.isIOS
        ? CupertinoAlertDialog(
            title: title,
            content: rateAndReviewFields(),
            actions: [
              CupertinoDialogAction(
                child: Text('Later'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: Text('Submit'),
                onPressed: submitReviewAndRating,
              ),
            ],
          )
        : AlertDialog(
            title: title,
            content: rateAndReviewFields(),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Later')),
              TextButton(
                onPressed: submitReviewAndRating,
                child: Text('Submit'),
              )
            ],
          );
  }

  Container rateAndReviewFields() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () {
                    print(index + 1);
                    setState(() {
                      rating = index;
                    });
                    rating = index;
                  },
                  child: ratingStar(index),
                ),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.widthMultiplier,
          ),
          Platform.isIOS
              ? CupertinoTextField(
                  autofocus: true,
                  showCursor: true,
                  controller: _reviewController,
                  maxLines: 4,
                  maxLength: 100,
                  style: regulartextstyle(
                    SizeConfig.regulartextSize * 0.9,
                    amigo_grey,
                    false,
                  ),
                  placeholder: 'Write a review for your session',
                  placeholderStyle: regulartextstyle(
                    SizeConfig.regulartextSize * .5,
                    amigo_lightGrey,
                    false,
                  ),
                )
              : TextField(
                  controller: _reviewController,
                  autofocus: true,
                  showCursor: true,
                  maxLines: 4,
                  maxLength: 100,
                  style: regulartextstyle(
                    SizeConfig.regulartextSize * 0.9,
                    amigo_grey,
                    false,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: SizeConfig.widthMultiplier,
                      horizontal: SizeConfig.widthMultiplier,
                    ),
                    hintText: 'Write a review for your session',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: amigo_grey,
                        width: 0.3,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: amigo_grey, width: 1.0),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Icon ratingStar(int index) {
    return index > rating
        ? Icon(
            Icons.star_border,
            color: Colors.orangeAccent,
            size: SizeConfig.regulartextSize * 2,
          )
        : Icon(
            Icons.star,
            color: Colors.orangeAccent,
            size: SizeConfig.regulartextSize * 2,
          );
  }

  void submitReviewAndRating() {
    log('Rating is ${rating + 1}');
    log('Review is \n ${_reviewController.text}');
    Navigator.pop(context);
    DatabaseService().postReviewAndRating(
      rating + 1,
      _reviewController.text,
      session.sessionUID,
      session.sessionUserName,
      session.sessionUserUID,
      session.sessionExpertUID,
    );
  }

  int returnRating() {
    return rating + 1;
  }
}
