import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'logout.dart';
import 'noti.dart';
import 'rank.dart';
import 'scan.dart';
import 'login.dart';
import 'profile.dart';
import 'category_list_view.dart';
import 'app_theme.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    Login.tag: (context) => Login(),
    Home.tag: (context) => Home(),
    Logout.tag: (context) => Logout(),
    Noti.tag: (context) => Noti(),
    Profile.tag: (context) => Profile(),
    Rank.tag: (context) => Rank(),
    Scan.tag: (context) => Scan(),
    CategoryListView.tag: (context) => CategoryListView(),
  };

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Revell1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Nunito',
      ),
      home: Login(),
      routes: routes,
    ); 
  }
}
class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
