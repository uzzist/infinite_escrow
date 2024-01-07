class DepositMethord{
  late int methodCode;
  late String  name;
  late String  currency;
  late String  minAmount;
  late String  maxAmount;
  late double  percentCharge;
  late double  fixedCharge;
  late double  rate;
  late bool isCrypto;
  DepositMethord({required this.rate, required this.fixedCharge, required this.percentCharge,
    required this.currency,  required this.name, required this.methodCode, required this.minAmount,
    required this.maxAmount, required this.isCrypto
  });
  static List<DepositMethord> fromList(List<dynamic> data){
    return data.map((e) =>
        DepositMethord(
            isCrypto: e['user_data'] != null && e['user_data']['wallet_id'] != null? true: false,
            rate: double.tryParse(e['rate'].toString()) ?? 0.0, fixedCharge: double.tryParse(e['fixed_charge'].toString()) ?? 0.0,
            percentCharge: double.tryParse(e['percent_charge'].toString()) ?? 0.0,
            minAmount:( double.tryParse(e['min_amount']?? e['min_limit']) ?? 0.0) .toString(), maxAmount: (double.tryParse(e['max_amount']?? e['max_limit']) ?? 0.0).toString(),
            currency:e['currency'], name: e['name'], methodCode: e['method_code'] != null ? int.parse(e['method_code'].toString()) : int.parse(e['id'].toString()))).toList();
  }
}