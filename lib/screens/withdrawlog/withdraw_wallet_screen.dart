import 'package:infinite_escrow/core/constants.dart';
import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/core/messages.dart';
import 'package:infinite_escrow/routes/routes.dart';

class WithdrawWalletScreen extends StatefulWidget {
  int id;
  WithdrawWalletScreen({super.key, required this.id});

  @override
  State<WithdrawWalletScreen> createState() => _WithdrawWalletScreen();
}

class _WithdrawWalletScreen extends State<WithdrawWalletScreen> {
  bool loading = false;
  String coin = 'BitCoin';
  dynamic formData = {};
  WithdrawWalletController newEscrowController = WithdrawWalletController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        persistentFooterButtons: [
          Container(
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(color: ColorConstant.lightGreen),
            child: TextButton(
                onPressed: loading? (){}: () {
                  if(formData['wallet'] == null || formData['wallet'] == ''){
                    SnackBarMessage.errorSnackbar(context, "Wallet Id is required");
                  }else{
                    var data = {
                      'wallet': formData['wallet'].toString(),
                      'network': Constants.currencyCryptoType[newEscrowController.coin.value].toString(),
                      'type': 2.toString(),
                      'id': widget.id.toString(),
                    };
                    setState(() {
                      loading = true;
                    });
                    var http = HttpRequest();
                    http.withdrawPayment(data).then((value) {
                      setState(() {
                        loading = false;
                      });
                      if(value.success){
                        navigateToOffAllNextPage(NewWithdrawLOGScreen(title: 'New Withdraw',));
                      }else{
                        SnackBarMessage.errorSnackbar(context, value.message);
                      }
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loading? CircularProgressIndicator(color: Colors.white,): Text("Submit",
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
        appBar: customAppBar(
          title: "Important Information",
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Wallet ID",
                            style: TextStyle(
                                color: ColorConstant.midNight,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          customTextFieldWithoutIcon(
                              hintText: "",
                              onChange: (e) {
                                formData['wallet'] = e;
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Crypto type",
                              style: TextStyle(
                                  color: ColorConstant.midNight,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              onTap: () {
                                customCryptoBottomSheet(
                                    context,
                                    newEscrowController.coin,
                                    "Select currency type", (e) {
                                  setState(() {
                                    newEscrowController.coin.value = e;
                                    coin = e;
                                  });
                                });
                              },
                              onChanged: (e) {
                                formData['network'] = e;
                              },
                              readOnly: true,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  borderSide: BorderSide(
                                    color: ColorConstant.grey,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  borderSide: BorderSide(
                                    color: ColorConstant.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  borderSide: BorderSide(
                                    color: ColorConstant.grey,
                                  ),
                                ),
                                suffixIcon: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                              currencyImageByName[coin]!),
                                          SizedBox(width: 12)
                                        ])),
                                hintText: newEscrowController.coin.value,
                                hintStyle: TextStyle(
                                    color: ColorConstant.darkestGrey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ]),
                      SizedBox(height: 24),
                      CustomText(
                        text: 'Dear Valued User,',
                      ),
                      SizedBox(height: 20),
                      CustomText(
                        text:
                            'We deeply appreciate your trust in Infinite Escrow as your chosen provider of escrow services. Before proceeding with a withdrawal from your escrow account, we kindly request that you carefully consider the following important information:',
                      ),
                      SizedBox(height: 20),
                      CustomText(
                        title: 'Verification Process: ',
                        text:
                            'To ensure the security and legitimacy of transactions, it may be necessary for us to conduct additional verification. This may involve submitting identification documents or answering verification-related questions. To ensure a seamless withdrawal process, please ensure that the information you provide is accurate and up to date.',
                      ),
                      SizedBox(height: 20),
                      CustomText(
                        title: 'Transaction Confirmation: ',
                        text:
                            'Please review all the details pertaining to the specific transaction associated with your withdrawal request. Double-check the transaction amount, recipient information (ensuring it matches the first and last names on your profile), and any additional instructions provided. Once a withdrawal has been processed, it may not be possible to cancel or modify it.',
                      ),
                      SizedBox(height: 20),
                      CustomText(
                        title: 'Transaction Fees: ',
                        text:
                            'Kindly note that there may be fees associated with withdrawal transactions. These fees cover administrative and operational costs related to processing the withdrawal.',
                      ),
                      SizedBox(height: 20),
                      CustomText(
                        title: 'Timeframes: ',
                        text:
                            'While we strive to process withdrawal requests promptly, the processing time may vary depending on factors such as the payment method and any additional verification requirements. We will make every effort to provide an estimated processing time for your specific withdrawal request.',
                      ),
                      SizedBox(height: 20),
                      CustomText(
                        text:
                            'By proceeding with the withdrawal request, you confirm that you have read and understood the above information, and you agree to comply with our terms and conditions. We appreciate your decision to choose Infinite Escrow and entrust us with your funds. If you have any questions or require further assistance, our dedicated customer service team is available to assist you.',
                      ),
                      CustomText(
                        text:
                            'We appreciate your decision to choose Infinite Escrow and entrust us with your funds. If you have any questions or require further assistance, our dedicated customer service team is available to assist you.',
                      ),
                      SizedBox(height: 20),
                      CustomText(
                        title: 'Best regards,',
                      ),
                      CustomText(
                        title: 'Infinite Escrow',
                      ),
                    ]))));
  }
}

class WithdrawWalletController extends GetxController {
  RxString coin = "BitCoin".obs;
  RxString type = "1".obs;
  String value = '';
}

Future<dynamic> customCryptoBottomSheet(
    BuildContext context, RxString coin, String title, Function selected) {
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30))),
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(15),
          height: 300,
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
            ],
          ),
        );
      });
}
