import 'package:flutter/foundation.dart';

import '../../Services/api_service.dart';
import '../../Services/auth.dart';
import '../../Utils/color_constants.dart';
import '../../Utils/constant_components.dart';
import '../../Utils/size_config.dart';
import 'package:flutter/material.dart';

class JournalAdd extends StatefulWidget {
  late final DateTime selectedDate;
  //const JournalAdd({Key key, this.selectedDate}) : super(key: key);

  @override
  _JournalAddState createState() => _JournalAddState();
}

class _JournalAddState extends State<JournalAdd> {
  List<String> weekdays = [
    '',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  int activeIndex = 0;
  List<Color> colors = [
    amigo_journal_default_blue,
    amigo_journal_light_green,
    amigo_journal_peach,
    amigo_journal_pink,
    amigo_journal_yellow
  ];
  Color journalcolor = amigo_journal_default_blue;
  TextEditingController titletextEditingController = TextEditingController();

  TextEditingController bodytextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: amigo_white,
          centerTitle: true,
          leading: Builder(
            builder: (context) => IconButton(
                icon: Icon(
                  Icons.close,
                  size: SizeConfig.heightMultiplier! * 2.5,
                  color: amigo_grey,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          title: Text(
            'Add Journal',
            style: regulartextstyle(
              12,
              amigo_grey,
              false,
            ),
          ),
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.check,
                  color: amigo_grey,
                ),
                onPressed: () {
                  if (bodytextEditingController.text == null ||
                      bodytextEditingController.text.isEmpty) {
                    /* showNotificationDialog(
                      'Empty Journal cannot be submitted',
                      '',
                      '',
                      'Okay',
                      context,
                    ); */
                  } else if (titletextEditingController.text == null ||
                      titletextEditingController.text.isEmpty) {
                    /* showNotificationDialog(
                      'Journal without title cannot be submitted',
                      '',
                      '',
                      'Okay',
                      context,
                    ); */
                  } else
                    submitJournal();
                })
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.widthMultiplier! * 4,
              vertical: SizeConfig.widthMultiplier! * 4,
            ),
            child: Column(
              children: [
                Center(
                  child: Text(
                    " ${weekdays[widget.selectedDate.weekday]}  ${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}",
                    style: regulartextstyle(
                      20,
                      amigo_lightGrey,
                      false,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: titletextEditingController,
                    // maxLength: 10,
                    maxLines: 1,
                    style: regulartextstyle(
                      20,
                      amigo_grey,
                      false,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: amigo_grey.withOpacity(0.5),
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: amigo_grey,
                          width: 1.0,
                        ),
                      ),
                      hintText: "Add a title to your journal",
                      hintStyle: regulartextstyle(
                        20,
                        amigo_lightGrey,
                        false,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: bodytextEditingController,
                    // maxLength: 10,
                    maxLines: 15,
                    style: regulartextstyle(
                      20,
                      amigo_grey,
                      false,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: amigo_grey.withOpacity(0.5),
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: amigo_grey,
                          width: 1.0,
                        ),
                      ),
                      hintText: "What's on your mind ?",
                      hintStyle: regulartextstyle(
                        20,
                        amigo_lightGrey,
                        false,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Color",
                        style: regulartextstyle(
                          20,
                          amigo_lightGrey,
                          false,
                        ),
                      ),
                      Row(
                        children: List.generate(4, (index) => colorbox(index)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitJournal() {
    String myDate =
        '${widget.selectedDate.year}-${widget.selectedDate.month}-${widget.selectedDate.day}';
    ApiService().postJournals(
      AuthServices().toString(),
      titletextEditingController.text,
      bodytextEditingController.text,
      myDate,
      colors[activeIndex].value,
    );

    Navigator.pop(context);
  }

  Widget colorbox(index) {
    return InkWell(
      onTap: () {
        setState(() {
          activeIndex = index;
        });
        if (kDebugMode) {
          print(journalcolor.value);
        }
        journalcolor = colors[index];
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 10,
          shape: const CircleBorder(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: activeIndex == index ? amigo_blue : amigo_white,
                width: activeIndex == index ? 3.0 : 3.0,
              ),
            ),
            child: ClipRRect(
              child: CircleAvatar(
                radius: 12,
                backgroundColor: colors[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
