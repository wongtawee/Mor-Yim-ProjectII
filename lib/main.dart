import 'package:moryim/HomePage.dart';
import 'package:moryim/Login.dart';
import 'package:moryim/SignUp.dart';
import 'package:moryim/Start.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:moryim/screen/theme/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);

          return MaterialApp(
            theme: ThemeData(primaryColor: Colors.orange),
            debugShowCheckedModeBanner: false,
            home: HomePage(),
            themeMode: themeProvider.themeMode,
            darkTheme: MyThemes.darkTheme,
            routes: <String, WidgetBuilder>{
              "Login": (BuildContext context) => Login(),
              "SignUp": (BuildContext context) => SignUp(),
              "start": (BuildContext context) => Start(),
            },
          );
        },
      );
}
