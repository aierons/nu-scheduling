import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import './invitepage/InvitePage.dart';
import './invitepage/InvitePageModel.dart';
import 'invitepage/inviteinfo.dart';
import 'home_page.dart';
import 'location_setup.dart';
//import './location_setup.dart';

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
            initialRoute: "/",
            routes: {
              "/": (BuildContext context) => MyPageView(),
              "/invitepage": (BuildContext context) => InvitePage(),
            });
      })));
}

void goToPage(PageController controller, int page) {
  if (controller.hasClients) {
    controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
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
  InviteInfo _blankInfo = new InviteInfo("", "", "", "");

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

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    InvitePageModel _invModel = Provider.of<InvitePageModel>(context);

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
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Icon(Icons.arrow_left, size: 50)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                child: FlatButton(
                  onPressed: () {
                    print(_blankInfo.getTitle);
                    if (_pageController.hasClients) {
                      _pageController.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Icon(Icons.arrow_right, size: 50)),
                ),
              ),
            ),
            Center(
              child: Container(
                child: Center(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: "What's the title of your meeting?",
                      labelText: 'Meeting Title',
                    ),
                    onSubmitted: (title) {
                      _blankInfo.setTitle(title);
                      print(_blankInfo.getTitle);
                    },
                  ),
                ),
              ),
            ),
          ],
        ));

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
                      1,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Icon(Icons.arrow_left, size: 50)),
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
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Icon(Icons.arrow_right, size: 50)),
              ),
            ),
          ),
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
        child: Stack(children: <Widget>[
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

                  // Add date to blank InviteInfo
                  _blankInfo
                      .setDate(DateTimeField.combine(date, time).toString());
                  _blankInfo.setLoc("Curry");
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
                      2,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Icon(Icons.arrow_left, size: 50)),
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
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Icon(Icons.arrow_right, size: 50)),
              ),
            ),
          ),
        ]));

    Widget memberSetup = Padding(
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
                        3,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Icon(Icons.arrow_left, size: 50)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                child: RaisedButton(
                  onPressed: () {
                    if (_pageController.hasClients) {
                      _blankInfo.setName("You");
                      _invModel.accept(_blankInfo);
                      _blankInfo = new InviteInfo("", "", "", "");
                      _pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Icon(Icons.check)),
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
        ));

    Widget changeLocation = Padding(
      padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
      child: Stack(
        children: <Widget>[
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
                child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Icon(Icons.check)),
              ),
            ),
          ),
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

    Widget changeDateTime = Padding(
        padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
        child: Stack(children: <Widget>[
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

                  // Add date to blank InviteInfo
                  _blankInfo
                      .setDate(DateTimeField.combine(date, time).toString());
                  _blankInfo.setLoc("Curry");
                  return DateTimeField.combine(date, time);
                } else {
                  return currentValue;
                }
              },
            ),
          ),
          Align(
            alignment: Alignment.topRight,
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
                child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Icon(Icons.check)),
              ),
            ),
          ),
        ]));

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
          HomePage(_pageController),
          titleSetup,
          locationSetup,
          dateTimeSetup,
          memberSetup,
          changeLocation,
          changeDateTime // 6
        ],
      ),
    );
  }
}

class _ArticleDescription extends StatelessWidget {
  _ArticleDescription({
    Key key,
    this.title,
    this.subtitle,
    this.author,
    this.publishDate,
    this.readDuration,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$title',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                '$subtitle',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                '$author',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$publishDate · $readDuration ★',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  CustomListItemTwo({
    Key key,
    this.thumbnail,
    this.title,
    this.subtitle,
    this.author,
    this.publishDate,
    this.readDuration,
  }) : super(key: key);

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: thumbnail,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _ArticleDescription(
                  title: title,
                  subtitle: subtitle,
                  author: author,
                  publishDate: publishDate,
                  readDuration: readDuration,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    this.thumbnail,
    this.title,
    this.user,
    this.viewCount,
  });

  final Widget thumbnail;
  final String title;
  final String user;
  final int viewCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: thumbnail,
          ),
          Expanded(
            flex: 3,
            child: _VideoDescription(
              title: title,
              user: user,
              viewCount: viewCount,
            ),
          ),
          const Icon(
            Icons.more_vert,
            size: 16.0,
          ),
        ],
      ),
    );
  }
}

class _VideoDescription extends StatelessWidget {
  const _VideoDescription({
    Key key,
    this.title,
    this.user,
    this.viewCount,
  }) : super(key: key);

  final String title;
  final String user;
  final int viewCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            user,
            style: const TextStyle(fontSize: 10.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            '$viewCount views',
            style: const TextStyle(fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}

// buttons
class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;
  bool _isChecked = false;

  // ···
  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
            tooltip: 'tooltip',
          ),
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        ),
        Checkbox(
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value;
            });
          },
        )
      ],
    );
  }
}
