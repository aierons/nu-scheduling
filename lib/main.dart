import 'package:flutter/material.dart';
import 'draw.dart';
import 'http.dart';

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

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

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
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: PageView(
          controller: _pageController,
          children: [
            Container(
              child: Center(
                child: ListView(
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
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: RaisedButton(
                  color: Colors.white,
                  onPressed: () {
                    if (_pageController.hasClients) {
                      _pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text('Previous'),
                ),
              ),
            ),
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
            RaisedButton(
              child: Text('Fetch Data from Website/API'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostDetail()),
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

// stores ExpansionPanel state information
class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<Item> _data = generateItems(8);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  // Border for cards
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey,
              spreadRadius: 0.6,
              blurRadius: 5,
              // LTRB
              offset: Offset(
                0, // move 10 right
                3, // move 10 down
              ))
        ]);
  }

  // Return text section with title, name, date info
  Widget _buildInfoSection(String title, String name, String loc) => Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // Title+name, location, time+day
        children: <Widget>[
          // Title+name
          Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
              child: Row(children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                ),
                SizedBox(width: 8),
                Text(name,
                    style: TextStyle(color: Colors.grey[500], fontSize: 18))
              ])),
          Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: Row(children: <Widget>[
                Icon(Icons.location_on, color: Theme.of(context).accentColor),
                Text(
                  loc,
                )
              ])),
          Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: Row(children: <Widget>[
                Icon(Icons.access_time, color: Theme.of(context).accentColor),
                Text(
                  "2pm - 3pm",
                ),
                SizedBox(width: 8),
                Text(
                  "M",
                )
              ]))
        ],
      ));

  // Returns a meeting card
  Widget _buildCard(
      BuildContext context, String title, String name, String loc) {
    String img = loc == "Snell Library" ? "snell" : "curry";
    return Container(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(
        // Card info, picture
        children: <Widget>[
          // Card info side
          _buildInfoSection(title, name, loc),
          ClipRRect(
              child: Image.asset('images/$img.jpg',
                  width: 125, height: 150, fit: BoxFit.cover),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8)))
        ],
      ),
      decoration: _cardDecoration(),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              subtitle: Text('To delete this panel, tap the trash can icon'),
              trailing: Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.removeWhere((currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
