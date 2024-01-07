import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/routes/routes.dart';

import '../../core/messages.dart';

class WithdrawPaymentScreen extends StatefulWidget {
  int id;
  WithdrawPaymentScreen({super.key, required this.id});

  @override
  State<WithdrawPaymentScreen> createState() => _WithdrawPaymentScreen();
}

class _WithdrawPaymentScreen extends State<WithdrawPaymentScreen> {
  bool loading = false;
  dynamic formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        persistentFooterButtons: [
          Container(
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(color: ColorConstant.lightGreen),
            child: TextButton(
                onPressed: loading? (){ }:() {
                  if(formData['name'] == null || formData['name'] == ''){
                    SnackBarMessage.errorSnackbar(context, "name is required");
                  }else if(formData['bank_name'] == null || formData['bank_name'] == ''){
                    SnackBarMessage.errorSnackbar(context, "bank name is required");
                  }else if(formData['account'] == null || formData['account'] == ''){
                    SnackBarMessage.errorSnackbar(context, "account is required");
                  }else{
                    var data = {
                      'name': formData['name'].toString(),
                      'bank_name': formData['bank_name'].toString(),
                      'account': formData['account'].toString(),
                      'type': 1.toString(),
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
                    loading? CircularProgressIndicator(color: Colors.white,):  Text("Submit",
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
                            "Your Legal Name",
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
                                formData['name'] = e;
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Account Number",
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
                                  formData['account'] = e;
                                }),
                          ]),
                      SizedBox(
                        height: 14,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bank Name",
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
                                formData['bank_name'] = e;
                              }),
                        ],
                      ),
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

class CustomText extends StatelessWidget {
  const CustomText({Key? key, this.title, this.text}) : super(key: key);
  final String? title;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: title,
        style: TextStyle(
            color: ColorConstant.dividerColor,
            fontSize: 14,
            height: 1.5,
            fontFamily: FontConstant.jakartaBold,
            fontWeight: FontWeight.w700),
        children: [
          TextSpan(
            text: text,
            style: TextStyle(
                color: ColorConstant.dividerColor,
                fontSize: 14,
                height: 1.5,
                fontFamily: FontConstant.jakartaMedium,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
