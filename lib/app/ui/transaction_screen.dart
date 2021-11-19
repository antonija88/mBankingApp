import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mbanking_app/app/providers/accounts_provider.dart';
import 'package:mbanking_app/app/providers/user_provider.dart';
import 'package:mbanking_app/app/ui/login_screen.dart';
import 'package:mbanking_app/app/ui/widgets/account_item.dart';
import 'package:mbanking_app/utility/constants.dart';
import 'package:mbanking_app/utility/size_config.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionsScreen extends StatefulHookWidget {
  const TransactionsScreen({Key? key}) : super(key: key);
  static const String routName = 'transactions_screen';
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double? sizeH = SizeConfig.safeBlockVertical;
    double? sizeW = SizeConfig.safeBlockHorizontal;

    final user = useProvider(userProvider).user;
    final account = useProvider(accountsProvider).account;
    final accounts = useProvider(accountsProvider).accounts;
    final isLoading = useProvider(accountsProvider).isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kMainColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: sizeW! * 4),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, LoginScreen.routName);
              },
              child: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: sizeH! * 20,
                color: kMainColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizeW * 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.userName + " " + user.userSurname,
                        style: TextStyle(
                            fontSize: sizeH * 4,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: sizeH * 1,
                      ),
                      Text(
                        'Account user',
                        style: TextStyle(
                            fontSize: sizeH * 2.5, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: sizeH * 6,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: sizeW * 4),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Transactions",
                    style: TextStyle(
                        fontSize: sizeH * 3,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
              SizedBox(
                height: sizeH * 2,
              ),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        separatorBuilder: (context, index) {
                          return Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: sizeW * 10),
                              child: const Divider(color: kMainColor));
                        },
                        itemCount: account.transactions.length,
                        itemBuilder: (context, index) {
                          return AccountItem(account.transactions[index]);
                        }),
              ),
              SizedBox(
                height: sizeH * 2,
              )
            ],
          ),
          Positioned(
              left: 0,
              right: 0,
              top: sizeH * 12,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: sizeW * 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  height: sizeH * 12,
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: sizeW * 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: sizeH * 2,
                                  ),
                                  Text(
                                    account.currency + " " + account.amount,
                                    style: TextStyle(fontSize: sizeH * 3),
                                  ),
                                  SizedBox(
                                    height: sizeH * 1,
                                  ),
                                  Text(
                                    "Available balance",
                                    style: TextStyle(fontSize: sizeH * 2),
                                  )
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.0))),
                                            title: Text("My accounts"),
                                            content: StatefulBuilder(
                                              builder: (context, setState) {
                                                return Container(
                                                  height: sizeH * 30,
                                                  width: sizeW * 90,
                                                  child: ListView.separated(
                                                    shrinkWrap: true,
                                                    separatorBuilder:
                                                        (context, index) {
                                                      return Divider(
                                                          color: kMainColor);
                                                    },
                                                    itemCount: accounts.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            context
                                                                .read(accountsProvider
                                                                    .notifier)
                                                                .changeAccount(
                                                                    index);
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              height: sizeH * 4,
                                                              child: Text(
                                                                accounts[index]
                                                                    .IBAN,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        sizeH *
                                                                            2),
                                                              ),
                                                            ),
                                                            accounts[index]
                                                                    .isSelected
                                                                ? Icon(
                                                                    Icons.check,
                                                                    color:
                                                                        kMainColor)
                                                                : SizedBox()
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            ));
                                      });
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: kMainColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(sizeH * 1.5),
                                    ),
                                    textStyle: TextStyle(
                                      fontSize: sizeH * 2,
                                    )),
                                child: Text("Switch account"),
                              )
                            ],
                          ),
                        ),
                ),
              )),
        ],
      ),
    );
  }
}
