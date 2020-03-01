import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchPost() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    List<dynamic> post = jsonDecode(response.body);
    return post;
  } else {
    throw Exception('Failed to load post');
  }
}

class PostDetail extends StatefulWidget {
  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  Future<List<dynamic>> _post;

  @override
  void initState() {
    super.initState();

    _post = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _post,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            // Data fetched successfully, display your data here
            return Column(
              children: <Widget>[
                Text(snapshot.data['title']),
                Text(snapshot.data['content'])
              ],
            );
          } else if (snapshot.hasError) {
            // If something went wrong
            return Text('Something went wrong...');
          }

          // While fetching, show a loading spinner.
          return CircularProgressIndicator();
        });
  }
}
