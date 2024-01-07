import 'dart:ui';

class TransactionModel {
  late double amount;
  late String currency;
  late int status;
  late String title;
  late DateTime createdAt;
  late int id;
  TransactionModel({required this.amount, required this.status, required this.createdAt,
    required this.id, required this.currency, required this.title});
  static fromJson(dynamic data){
    return TransactionModel(amount: double.parse(data['amount']), status: data['status'],
      createdAt: DateTime.parse(data['created_at']), id:  data['status'], currency:  data['currency_sym'],
      title: data['title']
    );
  }
  static fromJsonToList( List<dynamic> data){
    return data.map((e) {
      return TransactionModel(amount: double.tryParse(e['amount']) ?? 0.0, status:  e['status'] != null ? int.parse(e['status']): 0,
          createdAt: DateTime.parse(e['created_at']), id: int.tryParse( e['id'].toString()) ?? 0, currency: e['currency_sym'] ?? 'NGN',
          title: e['title']
      );
    }).toList();
  }
  getStatusString(){
    if(status == 2){
      return 'Accepted';
    }else if( status == 8 ){
      return 'Disputed';
    }else if( status == 9 ){
      return 'Cancelled';
    }else if( status == 1 ){
      return 'Completed';
    }else if( status == 0 ){
      return 'Not Accepted';
    }else{
      return 'Cancelled';
    }
  }
   getStatusColor(){
    if(status == 2){
      return Color(0xffFFF2D8);
    }else if( status == 8 ){
      return Color(0xffE0EDFF);
    }else if( status == 9 ){
      return Color(0xffFFDEDE);
    }else if( status == 1 ){
      return Color(0xffD4FDC5);
    }else if( status == 0 ){
      return Color(0xffFFF2D8);
    }else{
      return Color(0xffFFDEDE);
    }
  }
}