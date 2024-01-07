import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_escrow/screens/depositHistoryScreen/widgets/customDepositHistoryContainer.dart';

import '../../../constants/color_constant.dart';
import '../../../constants/font_constant.dart';
import '../../../constants/image_constant.dart';
import '../model/deposit_model.dart';

class PendedDepositTab extends StatelessWidget {
  List<DepositModel> list = [];
  PendedDepositTab({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for( var i in list ) Padding(padding: EdgeInsets.only(bottom: 10), child: customDepositHistoryContainer(
            containerColor: i.getStatusColor(),
            containerTitle: i.getStatusString(),
            price: i.amount,
            sId: i.trx,
            gateway: i.gatewayAlias,
            title: '', currencyName: i.methodCurrency, id: 0, date: DateTime.now()
        ),)
      ],
    ));
  }
}
