import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mbanking_app/app/providers/user_provider.dart';
import 'package:mbanking_app/app/ui/enter_pin_screen.dart';
import 'package:mbanking_app/utility/constants.dart';
import 'package:mbanking_app/utility/size_config.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginScreen extends StatefulHookWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routName = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double? sizeH = SizeConfig.safeBlockVertical;
    double? sizeW = SizeConfig.safeBlockHorizontal;

    final user = useProvider(userProvider).user;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: sizeH! * 12,
              ),
              Text(
                'Welcome back!',
                style: TextStyle(fontSize: sizeH * 5),
              ),
              SizedBox(
                height: sizeH * 4,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sizeH * 6),
                child: Text(
                  'Log in to continue',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: sizeH * 2.5, color: Colors.grey),
                ),
              ),
              SizedBox(
                height: sizeH * 4,
              ),
              Image.asset("assets/images/bank.png", height: sizeH * 40),
              SizedBox(
                height: sizeH * 4,
              ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: sizeW! * 5),
                  child: Text(
                    user.userName,
                    style: TextStyle(fontSize: sizeH * 4),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: sizeW * 5),
                  child: Text(user.userSurname,
                      style: TextStyle(fontSize: sizeH * 4))),
              Expanded(child: SizedBox()),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: kMainColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: sizeW * 35, vertical: sizeH * 2.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(sizeH * 1.5),
                      ),
                      textStyle: TextStyle(
                          fontSize: sizeH * 3, fontWeight: FontWeight.w500)),
                  onPressed: () {
                    Navigator.pushNamed(context, EnterPinScreen.routName);
                  },
                  child: Text('Login')),
              SizedBox(
                height: sizeH * 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
