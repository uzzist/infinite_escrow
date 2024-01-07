import 'dart:ui';

import 'package:infinite_escrow/core/constants.dart';

class EscrowDetail{
  late double amount;
  late String currency;
  late int status;
  late String title;
  late DateTime createdAt;
  late int id;
  late int sellerId;
  late String sellerName;
  late int buyerId;
  late String buyerName;
  late int creatorId;
  late double paidAmount;
  late double restAmount;
  late double milestoneFunded;
  late double milestoneUnfunded;
  late int chargePayer;
  late int categoryId;
  late double charge;
  late double buyerCharge;
  late double sellerCharge;
  late String? invitationMail;
  late int disputerId;
  late String disputeNote;
  late String disputeName;
  late int conversationId;
  late List<MessagesModel> messages;
  EscrowDetail({required this.amount, required this.status, required this.createdAt,
    required this.id, required this.currency, required this.title,
    required this.sellerId, required this.buyerId, required this.creatorId,required this.paidAmount,required this.chargePayer,
    required this.categoryId,required this.charge,required this.buyerCharge,required this.sellerCharge,required this.invitationMail,
    required this.disputerId, required this.disputeNote, required this.messages, required this.sellerName, required this.buyerName,
    required this.restAmount, required this.milestoneFunded, required this.milestoneUnfunded, required this.disputeName, required this.conversationId
  });
  static fromJson(dynamic data, dynamic body){
    return EscrowDetail(amount: double.parse(data['amount'].toString()), status: int.tryParse(data['status'].toString())?? 0,
        createdAt: DateTime.parse(data['created_at']), id: int.tryParse(data['id'].toString())?? 0 , currency:  data['currency_sym'] ?? 'NGR',
        title: data['title'],  sellerId: int.tryParse( data['seller_id']) ?? 0,  buyerId: int.tryParse(data['buyer_id'].toString())??0,
        creatorId: int.tryParse(data['creator_id'].toString())??0,
      paidAmount: double.tryParse(data['paid_amount'].toString())?? 0.0,
      chargePayer: int.tryParse(data['charge_payer'].toString()) ?? 0,  categoryId: int.tryParse(data['category_id'].toString()) ?? 0,  charge:double.tryParse( data['charge'].toString()) ?? 0.0,  buyerCharge:double.parse( data['buyer_charge'].toString()),
      sellerCharge: double.tryParse(data['seller_charge'].toString())??0.0, invitationMail: data['invitation_mail'], disputerId: int.tryParse(data['disputer_id'].toString()) ?? 0,
        disputeNote: data['dispute_note'] ?? '',
      messages: MessagesModel.fromJson(data['conversation']['messages']),
        sellerName: data['seller'] != null? data['seller']['username']: '',
        buyerName: data['buyer']!= null ? data['buyer']['username']: '',
      disputeName: data['disputer'] != null? data['disputer']['username']: '',
      restAmount: double.tryParse(body['restAmount'].toString())?? 0.0, milestoneFunded: double.tryParse(body['milestoneFunded'].toString())?? 0.0,
        milestoneUnfunded: double.tryParse(body['milestoneUnfunded'].toString())?? 0.0,
        conversationId: int.tryParse(data['conversation']['id'].toString()) ?? 0
    );
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
  getPayerString(){
    if(chargePayer == 1){
      return 'Seller';
    }else if( status == 8 ){
      return 'Buyer';
    }else{
      return '50%-50%';
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

class MessagesModel{
  late int senderId;
  late int adminId;
  late int conversationId;
  late String message;
  late String? file;
  late String senderName;
  late DateTime createdAt;
  MessagesModel({ required this.senderId, required this.adminId, required this.conversationId, required this.message,
    required this.file, required this.createdAt,
    required this.senderName,});
  static fromJson(List<dynamic> data ){
    return data.map((e) => MessagesModel( senderId: int.tryParse(e['sender_id'].toString()) ?? 0,
        adminId: int.tryParse(e['admin_id'].toString()) ?? 0,
        conversationId: int.tryParse(e['conversation_id'].toString()) ?? 0, message: e['message'], file: e['file'] != null ? Constants.imageUrl +  e['file']: null ,
        senderName: e['sender']['username'], createdAt: DateTime.parse( e['created_at']))).toList();
  }
}