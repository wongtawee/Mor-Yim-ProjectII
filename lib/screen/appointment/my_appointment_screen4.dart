import 'package:moryim/constants.dart';
import 'package:moryim/screen/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyAppointmentScreen4 extends StatefulWidget {
  const MyAppointmentScreen4({Key key}) : super(key: key);

  @override
  _MyAppointmentScreen4 createState() => _MyAppointmentScreen4();
}

class _MyAppointmentScreen4 extends State<MyAppointmentScreen4> {
  final auth = FirebaseAuth.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  String get workResult => null;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("start");
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();

    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsScreen(),
              ),
            ),
            icon: Icon(
              Icons.settings,
              color: primaryColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.all(Radius.circular(defaultPadding / 2)),
              child: Image.asset(
                "assets/images/user_pic.png",
                height: 120,
                width: 120,
              ),
            ),
            SizedBox(height: defaultPadding),
            Form(
              child: Column(
                children: <Widget>[
                  Text(
                    auth.currentUser.email,
                    style: TextStyle(fontSize: 25),
                  ),
                  TextFormField(
                    initialValue: "Wongtawee",
                    decoration: inputDecoration.copyWith(hintText: "Name"),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: TextFormField(
                      initialValue: "test@gmail.com",
                      decoration: inputDecoration.copyWith(hintText: "Email"),
                    ),
                  ),
                  TextFormField(
                    initialValue: "0999990000",
                    decoration:
                        inputDecoration.copyWith(hintText: "Phone Number"),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: TextFormField(
                      initialValue: "Phuket, Thailand",
                      decoration: inputDecoration.copyWith(hintText: "Address"),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  ElevatedButton(
                    style: style,
                    onPressed: signOut,
                    child: Text(
                      'Signout',
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const InputDecoration inputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  border: OutlineInputBorder(borderSide: BorderSide.none),
  enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
  focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
);
