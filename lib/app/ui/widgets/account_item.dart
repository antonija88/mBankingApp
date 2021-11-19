import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mbanking_app/app/models/transaction.dart';
import 'package:mbanking_app/utility/constants.dart';
import 'package:mbanking_app/utility/size_config.dart';

class AccountItem extends StatelessWidget {
  Transaction transaction;

  AccountItem(this.transaction);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double? sizeH = SizeConfig.safeBlockVertical;
    double? sizeW = SizeConfig.safeBlockHorizontal;

    String formatedDate = DateFormat('dd.MM.yyyy').format(transaction.date!);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizeW! * 4),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: sizeW * 5),
              title: Text(
                '${transaction.description}',
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w500),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.update, color: kMainColor, size: sizeH! * 2),
                      SizedBox(width: sizeW * 2),
                      Text(formatedDate, style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  SizedBox(height: sizeH * 0.5),
                  transaction.type == null
                      ? Text(" ")
                      : Text('${transaction.type}',
                          style: TextStyle(color: Colors.black))
                ],
              ),
              trailing: Text('${transaction.amount}',
                  style: TextStyle(color: Colors.black))),
        ),
      ),
    );
  }
}
