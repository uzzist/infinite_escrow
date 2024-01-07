import 'package:infinite_escrow/routes/routes.dart';

import '../model/deposit_model.dart';

class AllDepositTab extends StatelessWidget {
  List<DepositModel> list = [];
  AllDepositTab({super.key, required this.list});

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
              title: '', currencyName: i.methodCurrency, id: 0, date: i.createdAt
          ),)
        ],
      ),
    );
  }
}
