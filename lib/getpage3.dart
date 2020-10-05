import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:visualinfo/getuser.dart';

class GetPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<GetPage> {
  List<GetUserModel> _notes = List<GetUserModel>();

  Future<List<GetUserModel>> fetchNotes() async {
    var url = 'http://test.visualinfosoft.com/api/Employee/List';
    var response = await http.get(url);

    var notes = List<GetUserModel>();

    if (response.statusCode == 200) {
      print(response.statusCode);
      var notesJson = json.decode(response.body);
      print(notesJson);

      // for (var noteJsons in [notesJson])

      for (var noteJsons in [notesJson]) {
        // notes.addAll(GetUserModel.fromJson(noteJsons));
        notes.add(GetUserModel.fromJson(noteJsons));
        // notes.add(GetUserModel.fromJson(noteJsons));
        // notes.add(GetUserModel.fromJson(noteJsons));
        // notes.addAll(iterable)

        // notes.addAll(GetUserModel.fromJson());

        // notes.addAll(GetUserModel.fromJson(noteJsons));
      }
    }
    return notes;
  }

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('VISUAL INFOSOFT DATA'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _notes[index].data[index].name,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _notes[index].data[index].mobile,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: _notes.length,
        ));
  }
}
