import 'package:infinite_escrow/routes/routes.dart';

Future<dynamic> customCurrencyBottomSheetForMilestone(
    BuildContext context, RxString coin, String title, Function click) {
  return showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30))),
      context: context,
      builder: (context) {
        return Container(
          height: 520,
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(title,
                    style: TextStyle(
                        color: ColorConstant.midNight,
                        fontWeight: FontWeight.w600,
                        fontSize: 15)),
              ),
              SizedBox(height: 20),
              customRadioButton(
                  coin: coin,
                  coinName: "Ethereum",
                  value: "Ethereum",
                  click: (e){
                    click();
                  },
                  coinImage: ImageConstant.etherium,
                  coinPrice: "0.0012 (ETH)"),
              customRadioButton(
                  click: (e){
                    click();
                  },
                  coin: coin,
                  coinName: "BitCoin",
                  value: "BitCoin",
                  coinImage: ImageConstant.bitcoin,
                  coinPrice: "0.0012 (BTC)"),
              customRadioButton(
                  click: (e){
                    click();
                  },
                  coin: coin,
                  coinName: "USDC",
                  value: "USDC",
                  coinImage: ImageConstant.usdc,
                  coinPrice: "0.0012 (USDC)"),
              customRadioButton(
                  click: (e){
                    click();

                  },
                  coin: coin,
                  coinName: "Naira",
                  value: "Naira",
                  coinImage: ImageConstant.naira,
                  coinPrice: "0.0012 (#)"),
              customRadioButton(
                  click: (e){
                    click();

                  },
                  coin: coin,
                  coinName: "Dollar",
                  value: "Dollar",
                  coinImage: ImageConstant.dollar,
                  coinPrice: "0.0012 (\$)"),
            ],
          ),
        );
      });
}
