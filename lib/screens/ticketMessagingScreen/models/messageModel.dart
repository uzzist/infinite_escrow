import '../../../core/constants.dart';

class MessagesModel{
  late int adminId;
  late int supportTicketId;
  late String message;
  late List<dynamic> file = [];
  late DateTime createdAt;
  MessagesModel({ required this.supportTicketId, required this.adminId, required this.message,
    required this.file, required this.createdAt,});
  static fromJson(List<dynamic> data ){
    return data.map((e) => MessagesModel( supportTicketId: int.tryParse( e['supportticket_id'].toString()) ?? 0,
        adminId: int.tryParse(e['admin_id'].toString()) ?? 0,
        message: e['message'], file: e['attachments'] != null ?  e['attachments'].map((a)=> (Constants.imageUrl+a['attachment']).toString()).toList(): [] ,
        createdAt: DateTime.parse( e['created_at']))).toList();
  }
}