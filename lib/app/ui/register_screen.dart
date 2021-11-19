import 'package:flutter/material.dart';
import 'package:mbanking_app/app/models/user.dart';
import 'package:mbanking_app/app/providers/user_provider.dart';
import 'package:mbanking_app/app/ui/pin_screen.dart';
import 'package:mbanking_app/utility/constants.dart';
import 'package:mbanking_app/utility/size_config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RegisterScreen extends StatefulHookWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const String routName = 'register_screen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _surname;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double? sizeH = SizeConfig.safeBlockVertical;
    double? sizeW = SizeConfig.safeBlockHorizontal;
    final nameFocusNode = useFocusNode();
    final surnameFocusNode = useFocusNode();
    final registerFocusNode = useFocusNode();

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: sizeH! * 12,
                ),
                Text(
                  'Welcome!',
                  style: TextStyle(fontSize: sizeH * 5),
                ),
                SizedBox(
                  height: sizeH * 4,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizeH * 6),
                  child: Text(
                    'Please provide following details for your new account',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: sizeH * 2.5, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: sizeH * 4,
                ),
                Image.asset("assets/images/bank.png", height: sizeH * 25),
                SizedBox(
                  height: sizeH * 4,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizeW! * 5),
                  child: TextFormField(
                    focusNode: nameFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _name = value;
                      });
                    },
                    onFieldSubmitted: (term) {},
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 16),
                    autofocus: false,
                    showCursor: true,
                    maxLength: 30,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.black),
                      hintText: 'Enter your name',
                      fillColor: kLightGrey,
                      focusColor: kMainColor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: kLightGrey, width: sizeW * 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kLightGrey),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.red, width: sizeW * 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: kMainColor, width: sizeW * 0.5),
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizeW * 5),
                  child: TextFormField(
                    focusNode: surnameFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your surname';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _surname = value;
                      });
                    },
                    onFieldSubmitted: (term) {},
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 16),
                    autofocus: false,
                    maxLength: 30,
                    showCursor: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.black),
                      hintText: 'Enter your surname',
                      fillColor: kLightGrey,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: kLightGrey, width: sizeW * 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kLightGrey),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.red, width: sizeW * 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: kMainColor, width: sizeW * 0.5),
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeH * 2,
                ),
                ElevatedButton(
                    focusNode: registerFocusNode,
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
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        User user =
                            User(userName: _name, userSurname: _surname);
                        context.read(userProvider.notifier).saveUser(user);
                        Navigator.pushNamed(context, PinScreen.routName);
                      }
                    },
                    child: Text('Sign up')),
                SizedBox(
                  height: sizeH * 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
