import 'dart:ui';

class MilestoneModel{
  late String note;
  late String amount;
  late String methodCurrency;
  late int status;
  late int id;
  late DateTime createdAt;
  MilestoneModel({required this.note, required this.amount, required this.methodCurrency,
    required this.status, required this.createdAt,required this.id});
  static fromList(List<dynamic> data){
    return data.map((e) => MilestoneModel(note: e['note'], amount: double.parse(e['amount']).toString() , methodCurrency: e['currency'] ?? 'NGN',
        status: e['payment_status']!= null? int.parse(e['payment_status']): 0, createdAt: DateTime.parse(e['created_at']),
      id: e['escrow_id'] != null? int.parse(e['escrow_id']): 0,
    )).toList();
  }
  getStatusString(){
    if(status == 0){
      return 'Unfunded';
    }else if( status == 1 ){
      return 'Funded';
    }else{
      return 'Funded';
    }
  }
  getStatusColor(){
    if(status == 0){
      return Color(0xffFFF2D8);
    }else if( status == 1 ){
      return Color(0xffD4FDC5);
    }else{
      return Color(0xffFFDEDE);
    }
  }
}