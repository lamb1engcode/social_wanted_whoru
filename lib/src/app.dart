import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whoru/src/pages/auth/auth_page.dart';
import 'dart:io';
import 'package:whoru/src/pages/navigation/navigation.dart';
import 'package:whoru/src/pages/splash/splash_page.dart';

class App extends StatefulWidget {
  static bool firstCome = true;
  static String token;
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  Timer _timmerInstance;
  int _countDown = 3;
  String points = '.';

  void startTimmer() {
    var oneSec = Duration(seconds: 1);
    _timmerInstance = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_countDown <= 0) {
            _timmerInstance.cancel();
            App.firstCome = false;
          } else {
            _countDown--;
            points += '.';
          }
        },
      ),
    );
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      statusBarIconBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
    ));
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
    startTimmer();
  }

  @override
  Widget build(BuildContext context) {
    return _countDown != 0 && App.firstCome
        ? SplashPage(points: points)
        : App.token != null
            ? AuthenticationPage()
            : Navigation();
  }
}
