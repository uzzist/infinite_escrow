import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/routes/routes.dart';
import 'package:infinite_escrow/screens/paymentScreen/stripe.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/messages.dart';
import 'model/deposite_methord.dart';

class NewDepositScreen extends StatefulWidget {
  int type;
  String title;

  NewDepositScreen({super.key, required this.type, required this.title});

  @override
  State<NewDepositScreen> createState() => _NewDepositScreenState();
}

class _NewDepositScreenState extends State<NewDepositScreen> {
  List<DepositMethord> list = [];
  String charges = '0.0';
  String payable = '0.0';
  String max = '0.0';
  String min = '0.0';
  bool loading = false;
  NewDepositController depositController = NewDepositController();

  @override
  void initState() {
    super.initState();
    var http = HttpRequest();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SnackBarMessage.showLoading(context);
      var pending = http.getDepositMethordList(widget.type);
      Future.wait([pending]).then((value) {
        Navigator.pop(context);
        if (value[0].success == true) {
          setState(() {
            list = DepositMethord.fromList(value[0].data['data']['methods']);
            depositController.dropdownvalue.value = list[0].name;
            depositController.currency.value = list[0].currency;
            max = list[0].maxAmount;
            min = list[0].minAmount;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        persistentFooterButtons: [
          Container(
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(color: ColorConstant.lightGreen),
            child: TextButton(
                onPressed: loading
                    ? () {}
                    : () {
                        if (depositController.value == 0) {
                          SnackBarMessage.errorSnackbar(
                              context, "Please add Amount");
                          return;
                        }
                        var d = list.firstWhere((element) =>
                            element.name ==
                            depositController.dropdownvalue.value);
                        var http = HttpRequest();
                          setState(() {
                            loading = true;
                          });
                          var data = {
                            'method_code': d.methodCode.toString(),
                            'currency': depositController.currency.value,
                            'amount': depositController.value.toString()
                          };
                          (widget.type == 1
                              ? http.submitDeposit(data)
                              : http.submitWithdraw(data))
                              .then((value) async {
                            setState(() {
                              loading = false;
                            });
                            if (value.success) {
                              if (widget.type == 2) {
                                if (d.isCrypto) {
                                  navigateToPage(WithdrawWalletScreen(
                                      id: value.data['withdraw']['id']));
                                } else {
                                  navigateToPage(WithdrawPaymentScreen(
                                      id: value.data['withdraw']['id']));
                                }
                              } else {
                                if (value.data['data']['redirect'] != null) {
                                  var u =
                                      value.data['data']['redirect'] as String ??
                                          '';
                                  var d = u
                                      .replaceAll('https://', '')
                                      .replaceAll('/', '\\');
                                  final Uri url = Uri.parse(u);
                                  if (!await launchUrl(
                                    url,
                                    mode: LaunchMode.externalApplication,
                                  )) {
                                    SnackBarMessage.errorSnackbar(
                                        context, 'Something went Wrong!');
                                  }
                                } else {
                                  if(depositController.dropdownvalue.value == "USD") {
                                    navigateToPage(StripePaymentScreen(
                                        methodCode: d.methodCode.toString(),
                                        currency: depositController.currency.value,
                                        amount: depositController.value.toString(),
                                        type: widget.type,
                                        isCrypto: d.isCrypto,
                                        title: widget.title,
                                      track: value.data['data']['deposit']['trx'],
                                    ));
                                  }
                                }
                              }
                            } else {
                              SnackBarMessage.errorSnackbar(
                                  context, value.message);
                            }
                          });
                      },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text("Submit",
                            style: TextStyle(
                                color: ColorConstant.midNight,
                                fontSize: 17,
                                fontFamily: FontConstant.jakartaSemiBold,
                                fontWeight: FontWeight.w700)),
                    SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Icon(
                        Icons.arrow_forward,
                        color: ColorConstant.midNight,
                      ),
                    )
                  ],
                )),
          ),
        ],
        appBar: customAppBar(title: widget.title),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 56,
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorConstant.grey,
                    ),
                  ),
                  child: Obx(
                    () => DropdownButton(
                      // Initial Value
                      value: depositController.dropdownvalue.value,
                      isExpanded: true,
                      underline: Container(),

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: list.map((DepositMethord item) {
                        return DropdownMenuItem(
                          value: item.name,
                          child: Text(
                            item.name,
                            style: TextStyle(
                                color: ColorConstant.darkestGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (newValue) {
                        var f = list
                            .firstWhere((element) => element.name == newValue);
                        if (f != null) {
                          var chargesc = (f.fixedCharge +
                              (depositController.value * f.percentCharge) /
                                  100);
                          setState(() {
                            charges = chargesc.toString();
                            payable =
                                (chargesc + depositController.value).toString();
                            if (widget.type == 1) {
                              payable = (chargesc + depositController.value)
                                  .toString();
                            } else {
                              payable = (depositController.value - chargesc)
                                  .toString();
                            }
                            depositController.currency.value = f.currency;
                            max = f.maxAmount;
                            min = f.minAmount;
                          });
                        }
                        depositController.dropdownvalue.value =
                            newValue as String;
                      },
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 56,
                padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorConstant.grey,
                  ),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (e) {
                    var val = 0.0;
                    if (e != '') {
                      val = double.parse(e);
                    }
                    var f = list.firstWhere((element) =>
                        element.name == depositController.dropdownvalue.value);
                    if (f != null) {
                      var chargesc =
                          (f.fixedCharge + (val * f.percentCharge) / 100);
                      setState(() {
                        charges = chargesc.toString();
                        if (widget.type == 1) {
                          payable = (chargesc + val).toString();
                        } else {
                          payable = (val - chargesc).roundToDouble().toString();
                        }
                        depositController.currency.value = f.currency;
                        max = f.maxAmount;
                        min = f.minAmount;
                      });
                    }
                    depositController.value = val;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        depositController.currency.value,
                        style: TextStyle(
                            color: ColorConstant.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    hintText: "Amount",
                    hintStyle: TextStyle(
                        color: ColorConstant.darkestGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 136,
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  decoration:
                      BoxDecoration(color: ColorConstant.white, boxShadow: [
                    BoxShadow(
                      color: ColorConstant.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 14,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Limit",
                            style: TextStyle(
                                color: ColorConstant.darkestGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: [
                              Text.rich(TextSpan(
                                children: [
                                  TextSpan(
                                    text: min,
                                    style: TextStyle(
                                        color: ColorConstant.midNight,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: depositController.currency.value,
                                    style: TextStyle(
                                        color: ColorConstant.darkestGrey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )),
                              SizedBox(
                                width: 5,
                              ),
                              Text("-"),
                              SizedBox(
                                width: 5,
                              ),
                              Text.rich(TextSpan(
                                children: [
                                  TextSpan(
                                    text: max,
                                    style: TextStyle(
                                        color: ColorConstant.midNight,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: depositController.currency.value,
                                    style: TextStyle(
                                        color: ColorConstant.darkestGrey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Charge",
                            style: TextStyle(
                                color: ColorConstant.darkestGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          Text.rich(TextSpan(
                            children: [
                              TextSpan(
                                text: charges,
                                style: TextStyle(
                                    color: ColorConstant.midNight,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: depositController.currency.value,
                                style: TextStyle(
                                    color: ColorConstant.darkestGrey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payable",
                            style: TextStyle(
                                color: ColorConstant.darkestGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          Text.rich(TextSpan(
                            children: [
                              TextSpan(
                                text: payable,
                                style: TextStyle(
                                    color: ColorConstant.midNight,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: depositController.currency.value,
                                style: TextStyle(
                                    color: ColorConstant.darkestGrey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
