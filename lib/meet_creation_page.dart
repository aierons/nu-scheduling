import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import './invitepage/InvitePageModel.dart';
import 'invitepage/inviteinfo.dart';
import './location_setup.dart';

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
  InviteInfo _blankInfo = new InviteInfo("", "", "", "");

  List<ListItem<String>> list = [
    ListItem<String>('Snell Library'),
    ListItem<String>('Curry Student Center'),
    ListItem<String>('Ryder Hall'),
    ListItem<String>('Richards Hall'),
  ];

  final format = DateFormat("yyyy-MM-dd HH:mm");
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    InvitePageModel _invModel = Provider.of<InvitePageModel>(context);

    // Location setup tiles
    Widget _getListItemTile(BuildContext context, int index) {
      return GestureDetector(
        onTap: () {
          var itemSelected =
              list.singleWhere((item) => item.isSelected, orElse: () => null);
          // if every single item is not selected, then allow for selection
          if (list.every((item) => !item.isSelected)) {
            setState(() {
              // allow selection
              list[index].isSelected = !list[index].isSelected;
            });
          } else if (itemSelected != null) {
            setState(() {
              itemSelected.isSelected = false;
              list[index].isSelected = !list[index].isSelected;
//              _allowAdvance = true;
              _upToPage = 1;
            });
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Card(
              color: list[index].isSelected ? Color.fromRGBO(179, 242, 255, 0.6) : Colors.white,
              elevation: 0,
              child:
      ListTile(
      title: Text(list[index].data),
          ),
        ))),
      );
    }

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
              duration: const Duration(milliseconds: 400),
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
                  style:
                    TextStyle(
                      fontWeight: FontWeight.w400
                    ),
                ),
                actions: <Widget>[
                  Center(child:MaterialButton(
                    elevation: 5.0,
                    child: Text(
                      "ok",
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15
                      )),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  )),
                ]);
          });
    }

    // Right navigation arrow
    Widget rightArrow = Container(
      child: FlatButton(
        onPressed: () {
          int curPage = _pageController.page.floor();
          if (curPage <= _upToPage) {
            int nextPage = curPage + 1;
            if(_upToPage == 3 && _curPage == 3 ) {
              _blankInfo.setName("You");
              _invModel.accept(_blankInfo);
              _blankInfo = new InviteInfo("", "", "", "");
              _successDialog();
            }
            if (_pageController.hasClients) {
              _pageController.animateToPage(
                nextPage,
                duration: const Duration(milliseconds: 400),
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
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: _getListItemTile,
              ),
            ),
          ),
        ],
      ),
    );

    Widget dateTimeSetup = Padding(
        padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,0,230),
              child: navArrows),
          Center(
              child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Tap below to choose a date and time'),
          )),
          Center(
            child: DateTimeField(
              format: format,
              onShowPicker: (context, currentValue) async {
                final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
                if (date != null) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );

                  // Add date to blank InviteInfo
                  _blankInfo
                      .setDate(DateTimeField.combine(date, time).toString());
                  _blankInfo.setLoc("Curry");
                  setState(() {
                    _upToPage = _upToPage > 2 ? 3 : 2;
                  });
                  print(_curPage);
                  print(_upToPage);
                  return DateTimeField.combine(date, time);
                } else {
                  return currentValue;
                }
              },
            ),
          ),
        ]));

    Widget memberSetup = Padding(
        padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
        child: Column(
          children: <Widget>[
        Padding(
        padding: const EdgeInsets.fromLTRB(0,0,0,175),
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
                  if(email != "") {
                    setState(() {
                      _upToPage = 3;
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
                    child: Text('Add Email', style: TextStyle(fontSize: 18))

            ))),
          ],
        ));

    Widget titleSetup = Padding(
        padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
        child: Column(
          children: <Widget>[
        Padding(
        padding: const EdgeInsets.fromLTRB(0,0,0,230),
        child: navArrows),
            Center(
              child: Container(
                child: Center(
                  child: TextField(
                    controller: _titleTextController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.create),
                      hintText: '"Study Meetup"',
                      labelText: 'Name your meeting',
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
