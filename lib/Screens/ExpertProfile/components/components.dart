// ignore_for_file: camel_case_types

import 'package:amigoapp/Models/expertModel.dart';
import 'package:amigoapp/Utils/color_constants.dart';
import 'package:amigoapp/Utils/constant_components.dart';
import 'package:amigoapp/Utils/size_config.dart';
import 'package:flutter/material.dart';

class ExpertDetail extends StatefulWidget {
  final ExpertModel currentExpert;
  const ExpertDetail({Key key, this.currentExpert}) : super(key: key);

  @override
  _ExpertDetailState createState() => _ExpertDetailState();
}

class _ExpertDetailState extends State<ExpertDetail> {
  bool viewAllSpecializations = false;
  bool viewAllBio = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        expertQualificationCard(widget.currentExpert.expertQualifications),
        expertExpCard(widget.currentExpert.expertExperience),
        expLanguageCard(widget.currentExpert.expertLanguages),
        expLocationCard(widget.currentExpert.expertCity),
        expbioCard(widget.currentExpert.expertBio),

        // expBioCard(widget.currentExpert.expertBio)
      ],
    );
  }

  Widget expBioCard(String expBio) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.widthMultiplier),
      child: Container(
        child: Text(
          expBio,
          style: regulartextstyle(
            SizeConfig.regulartextSize * 0.8,
            amigo_grey,
            false,
          ),
        ),
      ),
    );
  }

//----Experience
  Row expertExpCard(int experience) {
    return Row(
      children: [
        Padding(
          //Necessary padding to the right of icon
          padding: EdgeInsets.only(right: SizeConfig.widthMultiplier),
          child: Text(
            '💼',
            style: regulartextstyle(
              SizeConfig.regulartextSize,
              amigo_grey,
              false,
            ),
          ),
        ),
        experience == 0
            ? Text(
                'Less than a year exp',
                style: regulartextstyle(
                  SizeConfig.regulartextSize * 0.8,
                  amigo_grey,
                  false,
                ),
              )
            : Text(
                '${experience.toString()}+ years of experience',
                style: regulartextstyle(
                  SizeConfig.regulartextSize * 0.8,
                  amigo_grey,
                  false,
                ),
              )
      ],
    );
  }
}

Container expertImageCard(String expImgUrl) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(width: 1.0, color: amigo_blue),
      borderRadius: BorderRadius.circular(40),
    ),
    child: CircleAvatar(
      radius: 40,
      foregroundImage: NetworkImage(expImgUrl),
    ),
  );
}

Row expLocationCard(String expCity) {
  return Row(
    children: [
      Padding(
        //Necessary padding to the right of icon
        padding: EdgeInsets.only(right: SizeConfig.widthMultiplier),
        child: Text(
          '📍',
          style:
              regulartextstyle(SizeConfig.regulartextSize, amigo_grey, false),
        ),
      ),
      Text(
        expCity,
        style: regulartextstyle(
          SizeConfig.regulartextSize * .8,
          amigo_grey,
          false,
        ),
      ),
    ],
  );
}

//---- Expert Bio------

//----Exp detail
Padding expertDetail(String expName, String expReferredAs, dynamic expRating,
    String expPrice, String expStrikedPrice) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          expName,
          overflow: TextOverflow.clip,
          style: regulartextstyle(
            SizeConfig.regulartextSize * 1.2,
            amigo_grey,
            true,
          ),
        ),
        Text(
          expReferredAs,
          style: regulartextstyle(
            SizeConfig.regulartextSize * 0.9,
            amigo_lightGrey,
            false,
          ),
        ),
        expRating == 0
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: amigo_white,
                  border: Border.all(color: amigo_blue),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  'New',
                  style: regulartextstyle(
                    SizeConfig.regulartextSize * 0.8,
                    amigo_blue,
                    false,
                  ),
                ),
              )
            : Row(
                children: [
                  Text(
                    '⭐️${expRating.toString()}',
                    style: regulartextstyle(
                      SizeConfig.regulartextSize,
                      amigo_grey,
                      false,
                    ),
                  ),
                ],
              ),
        Row(
          children: [
            Row(
              children: [
                Text(
                  '₹',
                  style: TextStyle(
                    fontSize: SizeConfig.regulartextSize,
                    color: amigo_lightGrey,
                  ),
                ),
                Text(
                  '${expStrikedPrice.toString()}',
                  style: TextStyle(
                    fontSize: SizeConfig.regulartextSize,
                    color: amigo_lightGrey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  ' ₹',
                  style: TextStyle(
                    fontSize: SizeConfig.regulartextSize,
                    color: amigo_blue,
                  ),
                ),
                Text(
                  '${expPrice.toString()}',
                  style: regulartextstyle(
                    SizeConfig.regulartextSize,
                    amigo_blue,
                    true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Container expRating(dynamic expRating) {
  return Container(
    child: expRating == 0
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              color: amigo_white,
              border: Border.all(color: amigo_blue),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Text(
              'New',
              style: regulartextstyle(
                SizeConfig.regulartextSize,
                amigo_blue,
                false,
              ),
            ),
          )
        : Row(
            children: [
              Text(
                expRating.toString(),
                style: regulartextstyle(
                  SizeConfig.regulartextSize,
                  amigo_grey,
                  false,
                ),
              ),
              Icon(
                Icons.star,
                color: Colors.orangeAccent,
                size: SizeConfig.regulartextSize,
              ),
            ],
          ),
  );
}

//--- Expert Qualification Row

Row expertQualificationCard(List expQualifications) {
  return Row(
    children: [
      //Necessary Padding to the right of icon
      Padding(
        padding: EdgeInsets.only(right: SizeConfig.widthMultiplier),
        child: Text(
          '🎓',
          style: regulartextstyle(
            SizeConfig.regulartextSize,
            amigo_grey,
            false,
          ),
        ),
      ),
      //CHECK FOR NUMBER OF QUALIFICATIONS
      Text(
        expQualifications[0],
        style: regulartextstyle(
          SizeConfig.regulartextSize * .8,
          amigo_grey,
          false,
        ),
      ),
      expQualifications.length > 1
          ? Text(
              ', ${expQualifications[1]}',
              style: regulartextstyle(
                SizeConfig.regulartextSize * .8,
                amigo_grey,
                false,
              ),
            )
          : Text(''),
      expQualifications.length > 2
          ? Text(
              ', ${expQualifications[2]}',
              style: regulartextstyle(
                SizeConfig.regulartextSize * .8,
                amigo_grey,
                false,
              ),
            )
          : Text(''),
    ],
  );
}

Row expLanguageCard(List expLang) {
  String languages = "Speaks ";
  for (String language in expLang) {
    languages = languages + language + ', ';
  }
  languages = languages.substring(0, languages.length - 2);
  return Row(
    children: [
      Padding(
        //Necessary padding to the right of icon
        padding: EdgeInsets.only(right: SizeConfig.widthMultiplier),
        child: Text(
          '💭',
          style: regulartextstyle(
            SizeConfig.regulartextSize,
            amigo_grey,
            false,
          ),
        ),
      ),
      Text(
        languages,
        style: regulartextstyle(
          SizeConfig.regulartextSize * 0.8,
          amigo_grey,
          false,
        ),
      )
    ],
  );
}

//---Booking Button
Container bookButtonComponent(String therapyPrice) {
  return Container(
    width: double.infinity,
    height: SizeConfig.heightMultiplier * 7,
    padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 4),
    color: amigo_blue,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Book now",
          style: regulartextstyle(
            SizeConfig.regulartextSize * 1.4,
            amigo_white,
            false,
          ),
        ),
        Row(
          children: [
            Text(
              '₹',
              style: TextStyle(
                  fontSize: SizeConfig.regulartextSize * 1.4,
                  color: amigo_white),
            ),
            Text(
              '$therapyPrice',
              style: regulartextstyle(
                SizeConfig.regulartextSize * 1.4,
                amigo_white,
                false,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class ExpSpecializationCard extends StatefulWidget {
  final List expTherapyTypes;
  const ExpSpecializationCard({Key key, this.expTherapyTypes})
      : super(key: key);

  @override
  _ExpSpecializationCardState createState() => _ExpSpecializationCardState();
}

class _ExpSpecializationCardState extends State<ExpSpecializationCard> {
  bool showAll = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          showAll = !showAll;
        },
      ),
    );
  }
}

class expbioCard extends StatefulWidget {
  final String expBio;
  const expbioCard(this.expBio);
  @override
  _expbioCardState createState() => _expbioCardState();
}

class _expbioCardState extends State<expbioCard> {
  bool expBioLess = true;
  String textLessOrMore = 'Read more';
  @override
  Widget build(BuildContext context) {
    textLessOrMore = expBioLess ? 'Read more' : 'Read Less';

    return widget.expBio.length >= 200
        ? Column(
            children: [
              Text(
                expBioLess
                    ? '${widget.expBio.substring(0, 200)}.....'
                    : widget.expBio,
                style: regulartextstyle(
                  SizeConfig.regulartextSize * 0.8,
                  amigo_grey,
                  false,
                ),
              ),
              widget.expBio.length > 150
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            expBioLess = !expBioLess;
                          });
                        },
                        child: Text(
                          textLessOrMore,
                          style: regulartextstyle(
                            SizeConfig.regulartextSize * 0.8,
                            amigo_blue,
                            false,
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
          )
        : Text(
            widget.expBio,
            style: regulartextstyle(
              SizeConfig.regulartextSize * 0.8,
              amigo_grey,
              false,
            ),
          );
  }
}
