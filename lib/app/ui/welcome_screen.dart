import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mbanking_app/app/ui/register_screen.dart';
import 'package:mbanking_app/utility/constants.dart';
import 'package:mbanking_app/utility/size_config.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routName = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    startTime();
    super.initState();
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacementNamed(context, RegisterScreen.routName);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double? sizeH = SizeConfig.safeBlockVertical;

    return Scaffold(
      backgroundColor: kMainColor,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: sizeH! * 15,
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    "mBanking App",
                    style: TextStyle(color: Colors.white, fontSize: sizeH * 5),
                  ),
                  SizedBox(height: sizeH * 10),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
