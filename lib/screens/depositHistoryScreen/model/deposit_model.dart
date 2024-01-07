import 'dart:ui';

class DepositModel{
  late String trx;
  late String amount;
  late String methodCurrency;
  late int status;
  late DateTime createdAt;
  late String gatewayAlias;
  DepositModel({required this.trx, required this.amount, required this.methodCurrency,
    required this.status, required this.createdAt, required this.gatewayAlias, });
  static fromList(List<dynamic> data){
    return data.map((e) => DepositModel(trx: e['trx'], amount: double.parse(e['amount'].toString()).toString() , methodCurrency: e['method_currency'],
        status: int.tryParse(e['status'].toString()) ?? 0, createdAt: DateTime.parse(e['created_at']), gatewayAlias: e['gateway'] != null? e['gateway']['alias']: ''
    )).toList();
  }
  getStatusString(){
    if(status == 2){
      return 'Pending';
    }else if( status == 1 ){
      return 'Done';
    }else{
      return 'Cancelled';
    }
  }
  getStatusColor(){
    if(status == 2){
      return Color(0xffFFF2D8);
    }else if( status == 1 ){
      return Color(0xffD4FDC5);
    }else{
      return Color(0xffFFDEDE);
    }
  }
}