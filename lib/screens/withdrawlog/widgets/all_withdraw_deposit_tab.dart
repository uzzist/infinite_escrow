import 'package:infinite_escrow/routes/routes.dart';
import '../model/withdraw_model.dart';

class AllWithDrawDepositTab extends StatelessWidget {
  List<WithdrawModel> list = [];
  AllWithDrawDepositTab({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for(var i in list) Padding(padding: EdgeInsets.only(bottom: 10),
            child:  customWithdrawHistoryContainer(
              containerColor: i.getStatusColor(),
              containerTitle: i.getStatusString(),
              id: 0,
              price: i.amount, charges: i.charge,
              rate: i.rate, recive: i.finalAmount,
              afterCharges: i.afterCharge, title: '',
              currencyName: i.methodCurrency, sId: i.trx, date: i.createdAt,
            ),)
        ],
      ),
    );
  }
}
