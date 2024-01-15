import 'package:infinite_escrow/core/http.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/color_constant.dart';
import '../../constants/font_constant.dart';
import '../../core/messages.dart';
import '../../functions/navigation_function.dart';
import '../../widgets/customAppBar.dart';
import '../withdrawlog/new_withdraw_log_screen.dart';
import '../withdrawlog/withdraw_payment_screen.dart';
import '../withdrawlog/withdraw_wallet_screen.dart';

class PayStackScreen extends StatefulWidget {

  String methodCode;
  String currency;
  String amount;
  int type;
  bool isCrypto;
  String title;

  PayStackScreen({required this.methodCode, required this.currency, required this.amount, required this.type, required this.isCrypto, required this.title});

  @override
  State<PayStackScreen> createState() => _PayStackState();
}

class _PayStackState extends State<PayStackScreen> {

  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Paystack'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pay ${widget.currency} ${widget.amount}'),
            SizedBox(
              height: 40,
            ),
            Container(
                height: 56,
                width: double.infinity,
                decoration: BoxDecoration(color: ColorConstant.lightGreen),
                child: TextButton(
                    onPressed: loading
                        ? () {}
                        : () {
                      var http = HttpRequest();
                      setState(() {
                        loading = true;
                      });
                      var data = {
                        'method_code': widget.methodCode,
                        'currency': widget.currency,
                        'amount': widget.amount
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
                            if (widget.isCrypto) {
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
                              navigateToPage(
                                  NewWithdrawLOGScreen(title: widget.title));
                            }
                          }
                        } else {
                          SnackBarMessage.errorSnackbar(
                              context, value.message);
                        }
                      });
                    },
                    child: loading
                        ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : Text("PAY NOW",
                        style: TextStyle(
                            color: ColorConstant.midNight,
                            fontSize: 17,
                            fontFamily: FontConstant.jakartaBold,
                            fontWeight: FontWeight.w700)))

            )
          ],
        ),
      ),
    );
  }
}
