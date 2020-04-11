import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import './invitepage/InvitePageModel.dart';
import 'invitepage/inviteinfo.dart';
import './location_change.dart';
import 'package:f_datetimerangepicker/f_datetimerangepicker.dart';
import 'package:numberpicker/numberpicker.dart';

// Pages for creating a meeting
class MeetCreationPage extends StatefulWidget {
  MeetCreationPage({Key key}) : super(key: key);

  _CreationState createState() => _CreationState();
}

// Meeting built by progressing through page view
class _CreationState extends State<MeetCreationPage> {
  final _pageController = PageController(
    initialPage: 0,
  );

  final _titleTextController = new TextEditingController();
  final _emailTextController = new TextEditingController();
  int _upToPage = -1;
  int _curPage = 0;
  InviteInfo _blankInfo =
      new InviteInfo("", "", "", DateTime.now(), TimeOfDay.now(), TimeOfDay.now(), ["You"]);
  String _selectedLocation = "";
  List<String> _invitees = [];

  List<ListItem<String>> list = [
    ListItem<String>('Snell Library'),
    ListItem<String>('Curry Student Center'),
    ListItem<String>('Ryder Hall'),
    ListItem<String>('Richards Hall'),
  ];

  final formatDate = DateFormat("MM-dd-yyyy");
  final formatTime = TimeOfDayFormat.a_space_h_colon_mm;
//  DateTime selectedDate = DateTime.now();
  DateTime _selectedDate;
  TimeOfDay _selectedStart;
  TimeOfDay _selectedEnd;

  @override
  Widget build(BuildContext context) {
    InvitePageModel _invModel = Provider.of<InvitePageModel>(context);

    const Border blackRectBorder = Border(
      top: BorderSide(width: 1.0, color: Colors.black),
      left: BorderSide(width: 1.0, color: Colors.black),
      right: BorderSide(width: 1.0, color: Colors.black),
      bottom: BorderSide(width: 1.0, color: Colors.black),
    );

    // Location setup tiles
    Widget _getListItemTile(BuildContext context, int index) {
      return GestureDetector(
        onTap: () {
          var itemSelected =
              list.singleWhere((item) => item.isSelected, orElse: () => null);
          // Allow selection if none are selected
          if (list.every((item) => !item.isSelected)) {
            setState(() {
              // allow selection
              list[index].isSelected = !list[index].isSelected;
            });
          } else if (itemSelected != null) {
            setState(() {
              itemSelected.isSelected = false;
              list[index].isSelected = !list[index].isSelected;
              _selectedLocation = itemSelected.data;
              _upToPage = 1;
              print(_upToPage);
            });
          }
        },
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 4),
//            decoration: BoxDecoration(
//              border: list[index].isSelected
//                  ? blackRectBorder
//                  : null,
//            ),
            child: Card(
//                  color: list[index].isSelected
//                      ? Colors.grey
//                      : Colors.white,
              elevation: list[index].isSelected ? 10 : 0,
              child: ListTile(
                title: Text(list[index].data),
              ),
            )),
      );
    }

    Widget _colorDialog() => SimpleDialog(
          title: Text(
            "Meeting Created!",
            textAlign: TextAlign.center,
          ),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                "Your new meeting has been added to the homescreen.",
                textAlign: TextAlign.center,
              ),
            )
          ],
          backgroundColor: Color.fromRGBO(199, 255, 214, 1),
          elevation: 4,
        );

    // Popup to alert user of successful meeting creation
    _successDialog() {
      return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
                backgroundColor: Color.fromRGBO(162, 252, 186, 1.0),
                title: Text(
                  "Meeting Created!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                actions: <Widget>[
                  Center(
                      child: MaterialButton(
                    elevation: 5.0,
                    child: Text("ok",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 15)),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  )),
                ]);
          });
    }

    const int transitionSpeed = 250;

    // Left navigation arrow
    Widget leftArrow = Container(
      child: FlatButton(
        onPressed: () {
          if (_pageController.page == 0) {
            Navigator.pop(context);
          } else if (_pageController.hasClients) {
            double curPage = _pageController.page;
            int prevPage = (curPage - 1).floor();
            _pageController.animateToPage(
              prevPage,
              duration: const Duration(milliseconds: transitionSpeed),
              curve: Curves.easeInOut,
            );
            setState(() {
              _curPage = prevPage;
            });
          }
        },
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Icon(Icons.arrow_back, size: 50, color: Colors.black)),
      ),
    );

    // Right navigation arrow
    Widget rightArrow = Container(
      child: FlatButton(
        onPressed: () {
          int curPage = _pageController.page.floor();
          if (curPage <= _upToPage) {
            int nextPage = curPage + 1;
            if (_upToPage == 3 && _curPage == 3) {
              _blankInfo.setName("You");
              _blankInfo.setLoc(_selectedLocation);
              _blankInfo.setStart(_selectedStart);
              _blankInfo.setDate(_selectedDate);
              _blankInfo.setEnd(_selectedEnd);
              _blankInfo.setInvitees(_invitees);
              _invModel.accept(_blankInfo);
              _blankInfo = new InviteInfo(null, null, null, null, null, null, ["Blank ", "list"]);
              _successDialog();
            }
            if (_pageController.hasClients) {
              _pageController.animateToPage(
                nextPage,
                duration: const Duration(milliseconds: transitionSpeed),
                curve: Curves.easeInOut,
              );
            }
            setState(() {
              _curPage = nextPage;
            });
          }
        },
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Icon(
              Icons.arrow_forward,
              size: 50,
              color: _curPage <= _upToPage ? Colors.black : Colors.grey,
            )),
      ),
    );

    // Left/right arrows to move between pages
    Widget navArrows = Row(
      children: <Widget>[
        Expanded(child: Align(alignment: Alignment.topLeft, child: leftArrow)),
        Expanded(
            child: Align(alignment: Alignment.topRight, child: rightArrow)),
      ],
    );

    Widget locationSetup = Padding(
      padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
      child: Stack(
        children: <Widget>[
          navArrows,
          Positioned(
            top: 100,
            left: 20,
            child: Container(
                child: Text(
              "Where?",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 60),
            )),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 140, 10, 10),
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: _getListItemTile,
              ),
            ),
          ),
        ],
      ),
    );

    Decoration dateTimeBoxDeco = BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 2)));
//       borderRadius: BorderRadius.circular(6.0));

    Widget chooseDate = Container(
        child: Stack(
//        crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Choose a date",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Color.fromRGBO(100, 100, 100, 1),
                fontWeight: FontWeight.w400,
                fontSize: 15),
          ),
        ),
        Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 0, 30),
//                  padding: const EdgeInsets.fromLTRB(0, 5, 30, 5),
            decoration: dateTimeBoxDeco,
            child: MaterialButton(
                padding: const EdgeInsets.fromLTRB(0, 20, 200, 5),
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: _selectedDate == null
                              ? DateTime.now()
                              : _selectedDate,
                          firstDate: DateTime(2001),
                          lastDate: DateTime(2021))
                      .then((date) {
                        var allFilled = false;
                        if(_selectedStart != null && _selectedEnd != null) {
                          allFilled = true;
                        }
                    setState(() {
                      _selectedDate = date;
                      _upToPage = allFilled ? _upToPage + 1 : _upToPage;
                    });
                  });
                },
                child: Text(
                  _selectedDate == null
                      ? '2020-02-20'
                      : formatDate.format(_selectedDate),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(100, 100, 100, 1),
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                ))),
      ],
    ));

    Widget chooseStart = Container(
        child: Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Start Time?",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Color.fromRGBO(100, 100, 100, 1),
                fontWeight: FontWeight.w400,
                fontSize: 15),
          ),
        ),
        Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 0, 30),
//                  padding: const EdgeInsets.fromLTRB(0, 5, 30, 5),
            decoration: dateTimeBoxDeco,
            child: MaterialButton(
              padding: const EdgeInsets.fromLTRB(0, 20, 200, 5),
              onPressed: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then((time) {
                  var allFilled = false;
                  if(_selectedDate != null && _selectedEnd != null) {
                    allFilled = true;
                  }
                  setState(() {
                    _selectedStart = time;
                    _upToPage = allFilled ? _upToPage + 1 : _upToPage;
                  });
                });
              },
              child: Text(
                _selectedStart == null
                    ? 'Start time'
                    : _selectedStart.format(context).toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(100, 100, 100, 1),
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
            )),
      ],
    ));

    Widget chooseEnd = Container(
        child: Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "End Time?",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Color.fromRGBO(100, 100, 100, 1),
                fontWeight: FontWeight.w400,
                fontSize: 15),
          ),
        ),
        Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 0, 30),
            decoration: dateTimeBoxDeco,
            child: MaterialButton(
              padding: const EdgeInsets.fromLTRB(0, 20, 150, 5),
              onPressed: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then((time) {
                  var allFilled = false;
                  if(_selectedStart != null && _selectedDate != null) {
                    allFilled = true;
                  }
                  setState(() {
                    _selectedEnd = time;
                    _upToPage = allFilled ? _upToPage + 1 : _upToPage;
                  });
                });
              },
              child: Text(
                _selectedEnd == null
                    ? 'End time'
                    : _selectedEnd.format(context).toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(100, 100, 100, 1),
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
            )),
      ],
    ));

    Widget dateTimeSetup = Padding(
        padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: navArrows),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "When?",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 60),
                ),
              ),
              chooseDate,
              chooseStart,
              chooseEnd,
            ]));

    Widget memberSetup = Padding(
        padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 175),
                child: navArrows),
            Center(
              child: TextField(
                controller: _emailTextController,
                decoration: const InputDecoration(
                  icon: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 13, 0, 0),
                      child: Icon(Icons.contact_mail)),
                  hintText: 'ex: kuo.e@gmail.com',
                  labelText: 'Emails',
                ),
                onSubmitted: (email) {
                  if (email != "") {
                    setState(() {
                      _upToPage = 3;
                      _invitees.add(email);
                    });
                  }
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Center(
                    child: RaisedButton(
                        onPressed: () => print("FUCK"),
                        child: Text('Add Email',
                            style: TextStyle(fontSize: 18))))),
          ],
        ));

    Widget titleSetup = Padding(
        padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 150),
                child: navArrows),
            Container(
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 20),
                alignment: Alignment(-1.0, -1.0),
                child: Text(
                  "Create a meeting",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 40),
                )),
            Center(
              child: Container(
                child: Center(
                  child: TextField(
                    controller: _titleTextController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.create),
                      hintText: '"Study Meetup"',
                      labelText: "What's the name of your meeting?",
                    ),
                    onSubmitted: (title) {
                      if (title != "") {
                        _blankInfo.setTitle(title);
                        // Allow progress once title given
                        setState(() {
                          // _allowAdvance = true;
                          _upToPage = 0;
                        });
                        print(_blankInfo.getTitle);
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ));

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: new NeverScrollableScrollPhysics(),
        children: [
          titleSetup,
          locationSetup,
          dateTimeSetup,
          memberSetup,
        ],
      ),
    );
  }
}
