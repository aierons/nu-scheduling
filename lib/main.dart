import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import './invitepage/InvitePage.dart';
import './invitepage/InvitePageModel.dart';
import 'invitepage/inviteinfo.dart';
import 'home_page.dart';
import 'location_setup.dart';

// Uncomment lines 7 and 10 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
//debugPaintSizeEnabled = true;
  // runApp(MaterialApp(
  //   title: 'NuSchedule',
  //   home: MyPageView(),
  // ));
  runApp(ChangeNotifierProvider(
      create: (context) => InvitePageModel(),
      child: Consumer<InvitePageModel>(builder: (context, model, child) {
        return MaterialApp(
            title: 'NU Scheduling',
            //home: MyPageView(),
            initialRoute: "/invitepage",
            routes: {
              "/": (BuildContext context) => MyPageView(),
              "/invitepage": (BuildContext context) => InvitePage(),
            });
      })));
}

class MyPageView extends StatefulWidget {
  MyPageView({Key key}) : super(key: key);

  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final _pageController = PageController(
    initialPage: 0,
  );

  final _textController = new TextEditingController();

  String _displayValue = "";

  _onSubmitted(String value) {
    setState(() => _displayValue = value);
  }

  List<ListItem<String>> list = [
    ListItem<String>('Snell Library'),
    ListItem<String>('Curry Student Center'),
    ListItem<String>('Ryder Hall'),
    ListItem<String>('Richards Hall'),
  ];

  final format = DateFormat("yyyy-MM-dd HH:mm");

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  // Widget createMeeting() {
  //   if (_pageController.page == 0) {
  //     return FloatingActionButton(
  //       onPressed: () {
  //         if (_pageController.hasClients) {
  //           _pageController.animateToPage(
  //             1,
  //             duration: const Duration(milliseconds: 400),
  //             curve: Curves.easeInOut,
  //           );
  //         }
  //         // Navigator.push(
  //         //     context,
  //         //     MaterialPageRoute(
  //         //         builder: (BuildContext context) => titleSetup));
  //       },
  //       child: Icon(Icons.add),
  //     );
  //   } else {
  //     return Container();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    Widget titleSetup = Padding(
      padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              child: FlatButton(
                onPressed: () {
                  if (_pageController.hasClients) {
                    _pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Icon(Icons.arrow_left),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              child: FlatButton(
                onPressed: () {
                  if (_pageController.hasClients) {
                    _pageController.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Icon(Icons.arrow_right),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 300.0,
              child: TextField(
                controller: _textController,
                onSubmitted: _onSubmitted,
                decoration:
                    new InputDecoration.collapsed(hintText: 'Title of Meeting'),
              ),
              // ),
            ),
          ),
          // new Container(
          //   child: Center(child: BasicDateTimeField()),
          // ),
        ],
      ),
    );

    Widget dateTimeSetup = Stack(children: <Widget>[
      Center(
        child: Text('Select date and time'),
      ),
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
              return DateTimeField.combine(date, time);
            } else {
              return currentValue;
            }
          },
        ),
      ),
      Align(
        alignment: Alignment.topLeft,
        child: Container(
          child: FlatButton(
            onPressed: () {
              if (_pageController.hasClients) {
                _pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: Icon(Icons.arrow_left),
          ),
        ),
      ),
      Align(
        alignment: Alignment.topRight,
        child: Container(
          child: FlatButton(
            onPressed: () {
              if (_pageController.hasClients) {
                _pageController.animateToPage(
                  3,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: Icon(Icons.arrow_right),
          ),
        ),
      ),
    ]);

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
            });
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          color: list[index].isSelected ? Colors.red[100] : Colors.white,
          child: ListTile(
            title: Text(list[index].data),
          ),
        ),
      );
    }

    Widget locationSetup = Padding(
      padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              child: FlatButton(
                onPressed: () {
                  if (_pageController.hasClients) {
                    _pageController.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Icon(Icons.arrow_left),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              child: FlatButton(
                onPressed: () {
                  if (_pageController.hasClients) {
                    _pageController.animateToPage(
                      4,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Icon(Icons.arrow_right),
              ),
            ),
          ),
          Center(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: _getListItemTile,
            ),
          ),
        ],
      ),
    );

    Widget memberSetup = Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            child: FlatButton(
              onPressed: () {
                if (_pageController.hasClients) {
                  _pageController.animateToPage(
                    3,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Icon(Icons.arrow_left),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            child: RaisedButton(
              onPressed: () {
                if (_pageController.hasClients) {
                  _pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Icon(Icons.check),
            ),
          ),
        ),
        Center(
          child: TextFormField(
            controller: _textController,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Invite people here!',
              labelText: 'Name *',
            ),
          ),
        )
      ],
    );

    return Scaffold(
      //appBar: AppBar(title: Text('NU Schedule')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(height: 50.0),
        color: Colors.blueGrey,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_pageController.hasClients) {
            _pageController.animateToPage(
              1,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          }
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => titleSetup));
        },
        child: Icon(Icons.add),
      ),
      //visible: true, //(_pageController.page == 0 ? true : false),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageView(
        controller: _pageController,
        children: [
          HomePage(),
          titleSetup,
          locationSetup,
          dateTimeSetup,
          memberSetup,
        ],
      ),
    );
  }
}
