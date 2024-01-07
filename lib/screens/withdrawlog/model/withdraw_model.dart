import 'dart:ui';

class WithdrawModel{
  late String trx;
  late String amount;
  late String finalAmount;
  late String rate;
  late String charge;
  late String afterCharge;
  late String methodCurrency;
  late int status;
  late DateTime createdAt;
  late String gatewayAlias;
  WithdrawModel({required this.trx, required this.amount, required this.methodCurrency,
    required this.status, required this.createdAt, required this.gatewayAlias,  required this.finalAmount,
    required this.rate, required this.charge, required this.afterCharge,});
  static fromList(List<dynamic> data){
    return data.map((e) => WithdrawModel(trx: e['trx'], amount: double.parse(e['amount']).toString() , methodCurrency: e['currency'],
        status: int.tryParse(e['status'].toString()) ?? 0, createdAt: DateTime.parse(e['created_at']), gatewayAlias: e['method'] != null? e['method']['name']: '',
      finalAmount: double.parse(e['final_amount']).toString() , rate: double.parse(e['rate']).toString() ,
      charge: double.parse(e['charge']).toString() , afterCharge: double.parse(e['after_charge']).toString() ,
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