class BalanceModel {
  late double ngn;
  late double usd;
  late double euro;
  late double btc;
  late double eth;
  BalanceModel({required this.btc,required this.usd,required this.euro,
    required this.ngn,required this.eth});
  static BalanceModel formJson(dynamic data){
    print(data.toString());
    return BalanceModel(btc: double.parse(data['btc'].toString()),usd: double.parse(data['usd'].toString()),
        euro: double.parse(data['euro'].toString()), ngn: double.parse(data['ngn'].toString()),
        eth: double.parse(data['eth'].toString()));
  }
}