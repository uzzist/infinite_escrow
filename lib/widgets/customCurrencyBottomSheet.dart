import 'package:infinite_escrow/routes/routes.dart';

Future<dynamic> customCurrencyBottomSheet(
    BuildContext context, RxString coin, String title, Function selected) {
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30))),
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(15),
          height: 443,
          color: Theme.of(context).colorScheme.primaryContainer,
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
                  click: (e){
                    selected(e);
                  },
                  coin: coin,
                  coinName: "Ethereum",
                  value: "Ethereum",
                  coinImage: ImageConstant.etherium,
                  coinPrice: "0.0012 (ETH)"),
              customRadioButton(
                  click: (e){
                    selected(e);
                  },
                  coin: coin,
                  coinName: "BitCoin",
                  value: "BitCoin",
                  coinImage: ImageConstant.bitcoin,
                  coinPrice: "0.0012 (BTC)"),
              customRadioButton(
                  click: (e){
                    selected(e);
                  },
                  coin: coin,
                  coinName: "USDC",
                  value: "USDC",
                  coinImage: ImageConstant.usdc,
                  coinPrice: "0.0012 (USDC)"),
              customRadioButton(
                  click: (e){
                    selected(e);
                  },
                  coin: coin,
                  coinName: "Naira",
                  value: "Naira",
                  coinImage: ImageConstant.naira,
                  coinPrice: "0.0012 (#)"),
              customRadioButton(
                  coin: coin,
                  coinName: "Dollar",
                  value: "Dollar",
                  click: (e){
                    selected(e);
                  },
                  coinImage: ImageConstant.dollar,
                  coinPrice: "0.0012 (\$)"),
            ],
          ),
        );
      });
}
