import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mbanking_app/app/providers/user_provider.dart';
import 'package:mbanking_app/app/ui/transaction_screen.dart';
import 'package:mbanking_app/utility/constants.dart';
import 'package:mbanking_app/utility/size_config.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class EnterPinScreen extends StatefulHookWidget {
  static const String routName = 'enter_pin_screen';
  const EnterPinScreen({Key? key}) : super(key: key);

  @override
  _EnterPinScreenState createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends State<EnterPinScreen> {
  final _formKey = GlobalKey<FormState>();
  int? pin;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double? sizeH = SizeConfig.safeBlockVertical;
    double? sizeW = SizeConfig.safeBlockHorizontal;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: sizeH! * 12,
          ),
          Text(
            'Enter your PIN',
            style: TextStyle(fontSize: sizeH * 5),
          ),
          SizedBox(
            height: sizeH * 4,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeH * 6),
            child: Text(
              'Enter your chosen PIN',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: sizeH * 2.5, color: Colors.grey),
            ),
          ),
          SizedBox(
            height: sizeH * 5,
          ),
          Form(
            key: _formKey,
            child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: sizeH * 2, horizontal: sizeW! * 7),
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  obscureText: true,
                  obscuringCharacter: '*',
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.length < 4 && v.length > 6) {
                      return "PIN must contain minimal 4 and maximal 6 numbers";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    errorBorderColor: Colors.black,
                    disabledColor: Colors.black,
                    inactiveColor: Colors.black,
                    activeColor: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    selectedColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                  ),
                  cursorColor: Colors.black,
                  animationDuration: Duration(milliseconds: 300),
                  keyboardType: TextInputType.number,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onSaved: (value) {
                    setState(() {
                      pin = int.parse(value!);
                    });
                  },
                  onChanged: (value) {},
                  beforeTextPaste: (text) {
                    return true;
                  },
                )),
          ),
          SizedBox(
            height: sizeH * 12,
          ),
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
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (context.read(userProvider).user.pin == pin!) {
                    Navigator.pushNamed(context, TransactionsScreen.routName);
                  } else {
                    showTopSnackBar(
                      context,
                      CustomSnackBar.error(
                        message: "You enter wrong PIN",
                      ),
                    );
                  }
                }
              },
              child: Text('OK')),
        ],
      ),
    );
  }
}
