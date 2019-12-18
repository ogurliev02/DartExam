import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExamDart extends StatefulWidget {
  final String url;

  ExamDart({String url}):url = 'https://jsonplaceholder.typicode.com/todos/1';

  @override
  State<StatefulWidget> createState() => ExamDartState();
}

final String rawJson = '''
{
  "userId": 1,
  "id": 1,
  "title": "delectus aut autem",
  "completed": 1
}
''';

class User {
  final String userId;
  final String title;
  final String completed;

  User ({
    this.userId,
    this.title,
    this.completed
});

  factory User.fromJson(Map<String, dynamic> parsedJson) => User (
    userId: parsedJson['userId'].toString(),
    title: parsedJson['title'].toString(),
    completed: parsedJson['completed'].toString()
  );
}

class ExamDartState extends State<ExamDart> {
  final _formKey = GlobalKey<FormState>();
  String _url, _body, _userId, _title, _completed;
  int _status;

  @override
  void initState() {
    _url = widget.url;
    super.initState();
  }//initState

  _sendRequestGet() {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();//update form data

      final response = jsonDecode(rawJson);
      User user = User.fromJson(response);
      _userId = user.userId;
      _title = user.title;
      _completed = user.completed;
      _status = 1;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(key: _formKey, child: SingleChildScrollView(child: Column(
      children: <Widget>[
        SizedBox(height: 25.0),
        RaisedButton(child: Text('Отправить GET запрос'), onPressed: _sendRequestGet),
        SizedBox(height: 20.0),
        Text('Response status', style: TextStyle(fontSize: 20.0,color: Colors.blue)),
        Text(_status == null ? '' :_status.toString()),
        SizedBox(height: 20.0),
        Text('Response body', style: TextStyle(fontSize: 20.0,color: Colors.blue)),
        Text(_userId == null ? '' : _userId),
        Text(_title == null ? '' : _title),
        Text(_completed == null ? '' : _completed)
      ],
    ),
    ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Супер приложение для зачета'),
      ),
      body: ExamDart(url: 'https://jsonplaceholder.typicode.com/todos/1'),
    );
  }
}

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  )
);