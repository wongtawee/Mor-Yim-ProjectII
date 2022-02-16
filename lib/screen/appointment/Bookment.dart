import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Bookment extends StatefulWidget {
  @override
  _BookmentState createState() => _BookmentState();
}

class _BookmentState extends State<Bookment> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _autovalidate = false;
  // ignore: non_constant_identifier_names
  String name, Date, lastname, Time;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Moryim'),
      ),
      body: new SingleChildScrollView(
        child: new Container(
          padding: new EdgeInsets.all(15.0),
          child: new Form(
            key: _key,
            // ignore: deprecated_member_use
            autovalidate: _autovalidate,
            child: FormUI(),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget FormUI() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Text('Book an appointment'),
        ),
        Column(
          children: [
            new Row(
              children: <Widget>[
                new Flexible(
                  child: new TextFormField(
                    decoration: new InputDecoration(hintText: 'FirstName'),
                    validator: validateName,
                    onSaved: (val) {
                      name = val;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            new Row(
              children: <Widget>[
                new Flexible(
                  child: new TextFormField(
                    decoration: new InputDecoration(hintText: 'LastName'),
                    validator: validateName,
                    onSaved: (val) {
                      lastname = val;
                    },
                  ),
                ),
                new SizedBox(width: 10.0),
              ],
            ),
          ],
        ),
        Column(
          children: [
            new Row(
              children: <Widget>[
                new Flexible(
                  child: new TextFormField(
                    decoration: new InputDecoration(hintText: 'Date'),
                    validator: validateName,
                    onSaved: (val) {
                      Date = val;
                    },
                  ),
                ),
                new SizedBox(width: 10.0),
              ],
            ),
          ],
        ),
        Column(
          children: [
            new Row(
              children: <Widget>[
                new Flexible(
                  child: new TextFormField(
                    decoration: new InputDecoration(hintText: 'Time'),
                    validator: validateName,
                    onSaved: (val) {
                      Time = val;
                    },
                  ),
                ),
                new SizedBox(width: 10.0),
              ],
            ),
          ],
        ),
        new ElevatedButton(
          onPressed: _sendToServer,
          child: new Text('จอง'),
        ),
        new SizedBox(height: 20.0),
      ],
    );
  }

  _sendToServer() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      DatabaseReference ref = FirebaseDatabase.instance.reference();
      var data = {
        "name": name,
        "lastname": lastname,
        "Date": Date,
        "Time": Time,
      };
      ref.child('Moryim').push().set(data).then((v) {
        _key.currentState.reset();
      });
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }

  String validateName(String val) {
    return val.length == 0 ? "Enter Name First" : null;
  }

  String validateMessage(String val) {
    return val.length == 0 ? "Enter Email First" : null;
  }
}
