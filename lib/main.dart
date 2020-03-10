import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'draw.dart';
import 'card.dart';

// Uncomment lines 7 and 10 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MaterialApp(
    title: 'NuSchedule',
    home: MyPageView(),
  ));
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

    Widget homePage = Container(
      child: Center(
        child: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                //leading: FlutterLogo(size: 56.0),
                title: Text(_textController.text),
                subtitle: Text('location, date, time'),
                trailing: Icon(Icons.more_vert),
              ),
            ),
          ],
        ),
      ),
    );

    Widget titleSetup = Stack(
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
            child: Center(
              child: TextField(
                controller: _textController,
                onSubmitted: _onSubmitted,
              ),
            ),
          ),
        ),
        // new Container(
        //   child: Center(child: BasicDateTimeField()),
        // ),
      ],
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

    Widget memberSetup = Stack(
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

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('NU Schedule')),
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
            homePage,
            titleSetup,
            //locationSetup,
            dateTimeSetup,
            memberSetup,
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // checkbox
    Widget infoSection = ListView(
      children: const <Widget>[
        Card(child: ListTile(title: Text('One-line ListTile'))),
        Card(
          child: ListTile(
            leading: FlutterLogo(),
            title: Text('One-line with leading widget'),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('One-line with trailing widget'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          child: ListTile(
            leading: FlutterLogo(),
            title: Text('One-line with both widgets'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('One-line dense ListTile'),
            dense: true,
          ),
        ),
        Card(
          child: ListTile(
            leading: FlutterLogo(size: 56.0),
            title: Text('Two-line ListTile'),
            subtitle: Text('Here is a second line'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          child: ListTile(
            leading: FlutterLogo(size: 72.0),
            title: Text('Three-line ListTile'),
            subtitle:
                Text('A sufficiently long subtitle warrants three lines.'),
            trailing: Icon(Icons.more_vert),
            isThreeLine: true,
          ),
        ),
      ],
    );

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call, 'CALL'),
          _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(color, Icons.share, 'SHARE'),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        'random text label here to display stuff',
        softWrap: true,
      ),
    );

    return MaterialApp(
      title: 'I5 Assignment',
      home: Scaffold(
        appBar: AppBar(
          title: Text('NuSchedule'),
        ),
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
        body: ListView(
          children: [
            Card(
              child: ListTile(
                leading: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {},
                  child: Container(
                    width: 48,
                    height: 48,
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    alignment: Alignment.center,
                    child: CircleAvatar(),
                  ),
                ),
                title: Text('title'),
                subtitle: Text(''),
                dense: false,
              ),
            ),
            buttonSection,
            textSection,
            TextField(
              autofocus: true,
            ),
            RaisedButton(
              child: Text('Draw App'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Draw()),
                );
              },
            ),
            Tooltip(
                message: 'tooltip',
                child:
                    new Text('tooltip, press the button above for drawing^')),
            RaisedButton(
              child: Text('Labeled Panel'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyPanel()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
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

/// panel implementation with GUI componenets
class MyPanel extends StatelessWidget {
  static const String _title = 'Panel';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatefulWidget(),
      ),
    );
  }
}
