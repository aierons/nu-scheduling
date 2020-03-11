import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ListItem<T> {
  bool isSelected = false; //Selection property to highlight or not
  T data; //Data of the user
  ListItem(this.data); //Constructor to assign the data
}

class LocationSetup extends StatefulWidget {
  @override
  _LocationSetup createState() => _LocationSetup();
}

class _LocationSetup extends State<LocationSetup> {
  List<ListItem<String>> list = [
    ListItem<String>('Snell Library'),
    ListItem<String>('Curry Student Center'),
    ListItem<String>('Ryder Hall'),
    ListItem<String>('Richards Hall'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: _getListItemTile,
      ),
    );
  }

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
}
