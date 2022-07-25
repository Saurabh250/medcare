// ignore_for_file: deprecated_member_use, missing_return

import 'package:medcare/Utils/color_constants.dart';
import 'package:flutter/material.dart';

TextStyle regulartextstyle(double fontsize, Color textcolor, bool isBoldOrNot) {
  return TextStyle(
    fontFamily: 'Metropolis',
    fontSize: fontsize,
    height: 2.7 / 2.7,
    color: textcolor,
    fontWeight: isBoldOrNot ? FontWeight.w500 : FontWeight.w300,
  );
}

Drawer appDrawer(BuildContext context) => Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2.7 * 4),
            child: Column(
              children: [
                /* textButton('Account', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditAccount(),
                    ),
                  );
                }), */

                //-- Contact us using email
                textButton('Contact Us', () {}),

                textButton('Report a Bug', () {
                  String encodeQueryParameters(Map<String, String> params) {
                    return params.entries
                        .map((e) =>
                            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                        .join();
                  }
                })

                //-- Open FAQ
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 2.7 * 1,
                ),
                child: Image.asset(
                  'assets/logos/TextBlackLogoBlue.png',
                  width: 2.7 * 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 2.7 * 6,
                  top: 2.7 * 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [],
                ),
              )
            ],
          )
        ],
      ),
    );

SnackBar snackBarComponent(
    BuildContext context, String snackBarTitle, Color snackBarColor) {
  return SnackBar(
    backgroundColor: snackBarColor,
    content: Text(
      snackBarTitle,
      textAlign: TextAlign.center,
      style: regulartextstyle(
        5 * 5,
        Colors.white,
        true,
      ),
    ),
  );
}

Icon navBarIcons(IconData icons) {
  return Icon(
    icons,
    size: 2.7 * 2.75,
  );
}

final OutlineInputBorder border = OutlineInputBorder(
  borderRadius: BorderRadius.circular(
    5.7 * 7,
  ),
  borderSide: const BorderSide(
    color: amigo_grey,
    width: 10 * 2,
  ),
);
final OutlineInputBorder focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(
    2.7 * 7,
  ),
  borderSide: const BorderSide(
    color: amigo_grey,
    width: 2.7 * .2,
  ),
);
final OutlineInputBorder errorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(
    2.7 * 7,
  ),
  borderSide: const BorderSide(
    color: amigo_error_red,
    width: 2.7 * .2,
  ),
);

//TextButton for drawer
TextButton textButton(String title, Function onpressed) {
  return TextButton(
    onPressed: () async {
      onpressed();
    },
    child: Text(
      title,
      style: regulartextstyle(
        9 * 4,
        amigo_grey,
        false,
      ),
    ),
  );
}

//Icon button in Drawer for social media
//--Notification Dialog
/* Widget showNotificationDialog(
  String title,
  String content,
  String cancelButtonText,
  String defaultActionText,
  BuildContext context,
) {
  //TODO:TEXTSTYLE: Finalise all textstyles of the application
  TextStyle titleStyle =
      regulartextstyle(SizeConfig.appBarTextSize, amigo_grey, false);
  TextStyle textStyle =
      regulartextstyle(SizeConfig.regulartextSize, amigo_grey, false);
  TextStyle buttonTextStyle =
      regulartextstyle(SizeConfig.regulartextSize, amigo_blue, false);

  // Cupertino Dialog for IOS
  if (Platform.isIOS) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: title != ''
            ? Text(
                title,
                style: titleStyle,
              )
            : null,
        content: Text(
          content,
          style: textStyle,
        ),
        actions: cancelButtonText == ''
            ? [
                CupertinoDialogAction(
                  child: Text(
                    defaultActionText,
                    style: buttonTextStyle,
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ]
            : [
                CupertinoDialogAction(
                  child: Text(
                    cancelButtonText,
                    style: buttonTextStyle,
                  ),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                CupertinoDialogAction(
                  child: Text(
                    defaultActionText,
                    style: buttonTextStyle,
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: title != ''
            ? Text(
                title,
                style: titleStyle,
              )
            : null,
        content: content != ''
            ? Text(
                content,
                style: textStyle,
                textAlign: TextAlign.center,
              )
            : null,
        actions: <Widget>[
          if (cancelButtonText != '')
            TextButton(
              child: Text(
                cancelButtonText,
                style: buttonTextStyle,
              ),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          defaultActionText != ''
              ? TextButton(
                  child: Text(
                    defaultActionText,
                    style: buttonTextStyle,
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                )
              : Container(),
        ],
      ),
    );
  }
}
 */
