class EscrowCategoryModel{
  late int id;
  late String name;
  EscrowCategoryModel({required this.id, required this.name});
  static List<EscrowCategoryModel> fromJsonList(List<dynamic> data){
    return data.map((e) => EscrowCategoryModel(id: int.tryParse(e['id'].toString()) ?? 0, name: e['name'], )).toList();
  }
}