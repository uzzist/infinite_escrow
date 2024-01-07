import 'dart:ui';

class TicketsModel {
  late int id;
  late int status;
  late int priority;
  late String ticket;
  late String subject;
  late DateTime lastReply;
  TicketsModel({required this.id, required this.status, required this.priority,
    required this.ticket, required this.subject, required this.lastReply });
  static fromJson(List<dynamic>  data1){
    return data1.map((data) => TicketsModel(id: data['id'],
        status: int.tryParse(data['status'].toString()) ?? 0, priority: int.tryParse(data['priority'].toString()) ?? 0, ticket: data['ticket'], subject: data['subject'],
        lastReply: DateTime.parse(data['last_reply']))).toList();
  }
  static fromJsonSingle(dynamic data){
    return TicketsModel(id: int.tryParse(data['id'].toString()) ?? 0, status: int.tryParse(data['status'].toString()) ?? 0,
        priority: int.tryParse(data['priority'].toString()) ?? 0, ticket: data['ticket'], subject: data['subject'],
        lastReply: DateTime.parse(data['last_reply']));
  }
  getStatusString(){
    if( status == 0 ){
      return 'Open';
    }else if( status == 1 ){
      return 'Answered';
    }else if( status == 2 ){
      return 'Replied';
    }else if( status == 3 ){
      return 'Closed';
    }else{
      return 'Closed';
    }
  }
  getStatusColor(){
     if( status == 1 ){
      return Color(0xffE0EDFF);
    }else if( status == 3 ){
      return Color(0xffFFDEDE);
    }else if( status == 0 ){
      return Color(0xffD4FDC5);
    }else if( status == 2 ){
      return Color(0xffFFF2D8);
    }else{
      return Color(0xffFFDEDE);
    }
  }
}