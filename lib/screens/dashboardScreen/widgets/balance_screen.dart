import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/routes/routes.dart';

import '../../../core/messages.dart';
import 'models/balance.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  BalanceModel? model;
  @override
  void initState() {
    super.initState();
    var http = HttpRequest();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SnackBarMessage.showLoading(context);
      http.getBalance().then((value) {
          Navigator.pop(context);
          if (value.success == true) {
            setState(() {
              print(value.data.toString());
              model = BalanceModel.formJson(value.data['data']);
            });
          }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Balance",),

      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customBalanceContainer(
              image: ImageConstant.naira,
              title: "Naira",
              price: (model?.ngn?? 0).toString(),
              currencyImage: ImageConstant.nairaBlur,
            ),
            SizedBox(
              height: 10,
            ),
            customBalanceContainer(
              image: ImageConstant.dollar,
              title: "Dollar",
              price: (model?.usd ?? 0).toString(),
              currencyImage: ImageConstant.dollarBlur,
            ),
            SizedBox(
              height: 10,
            ),
            customBalanceContainer(
              image: ImageConstant.etherium,
              title: "Ethereum",
              price: (model?.eth?? 0).toString(),
              currencyImage: ImageConstant.etheriumBlur,
            ),
            SizedBox(
              height: 10,
            ),
            customBalanceContainer(
              image: ImageConstant.bitcoin,
              title: "Bitcoin",
              price: (model?.btc?? 0).toString(),
              currencyImage: ImageConstant.bitcoinBlur,
            ),
            SizedBox(
              height: 10,
            ),
            customBalanceContainer(
              image: ImageConstant.usdc,
              title: "USDC",
              price: (model?.euro?? 0).toString(),
              currencyImage: ImageConstant.usdcBlur,
            ),
          ],
        ),
      ),
    );
  }

  Container customBalanceContainer(
      {required String image,
      required String title,
      required String price,
      required String currencyImage}) {
    return Container(
      height: 80,
      width: Get.width,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: ColorConstant.white, boxShadow: [
        BoxShadow(
          color: ColorConstant.black.withOpacity(0.1),
          spreadRadius: 0,
          blurRadius: 14,
          offset: Offset(0, 5), // changes position of shadow
        ),
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            image,
            fit: BoxFit.scaleDown,
          ),
          SizedBox(
            width: 10,
          ),
          Row(
            children: [
              Text(
                price,
                style: TextStyle(
                    fontSize: 32,
                    fontFamily: FontConstant.jakartaMedium,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 12,
                    color: ColorConstant.darkestGrey,
                    fontFamily: FontConstant.jakartaMedium,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Spacer(),
          SvgPicture.asset(currencyImage)
        ],
      ),
    );
  }
}
