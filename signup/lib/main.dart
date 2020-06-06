import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signup/pages/pill/global_bloc.dart';
import 'package:signup/services/authentication.dart';
import 'package:signup/pages/root/root_page.dart';


void main() {
  runApp(new MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalBloc globalBloc;

  void initState() {
    globalBloc = GlobalBloc();
 super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        home: new RootPage(auth: Auth(),),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}