import 'package:infinite_escrow/core/constants.dart';

class BlogModel {
  late String title;
  late String writtenBy;
  late String descriptionNic;
  late String image;
  late DateTime createdAt;
  BlogModel({ required this.title, required this.image, required this.createdAt, required this.descriptionNic, required this.writtenBy });
  static fromJsonList(List<dynamic> data){
    return data.map((e) => BlogModel(title: e['data_values']['title'], image: Constants.imageUrlBlog +  e['data_values']['image'],
        createdAt: DateTime.parse(e['created_at']), descriptionNic: e['data_values']['description_nic'],
        writtenBy: e['data_values']['written_by'])).toList();
  }
}