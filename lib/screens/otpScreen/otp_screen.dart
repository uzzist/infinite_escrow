import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/routes/routes.dart';

import '../../core/messages.dart';

class OTPScreen extends StatefulWidget {
  String? email;
  String? phone;
  int type;

  OTPScreen({
    super.key,
    this.email,
    required this.type,
    this.phone,
  });

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  var controller;

  var loading = false;
  var cleartext = false;

  int seconds = 60;

  late Timer _timer;

  bool resend = false;

  startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        seconds--;
      });

      if (seconds == 0) {
        setState(() {
          resend = true;
          seconds = 60;
        });
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: customAppBar(
            title: "",
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? ColorConstant.white
                : ColorConstant.black),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.15,
                ),
                SizedBox(
                  height: 40,
                  child: Image.asset(ImageConstant.search),
                ),
                Text(
                  "Verification Code",
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? ColorConstant.midNight
                          : ColorConstant.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: FontConstant.jakartaBold,
                      fontSize: 32),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "The verification code has been sent to",
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? ColorConstant.midNight
                          : ColorConstant.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: FontConstant.jakartaMedium,
                      fontSize: 14),
                ),
                Text(
                  widget.type != 3 ? widget.email ?? '' : widget.phone ?? '',
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? ColorConstant.midNight
                          : ColorConstant.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: FontConstant.jakartaBold,
                      fontSize: 14),
                ),
                SizedBox(height: 20),
                OtpTextField(
                  textStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary
                  ),
                  numberOfFields: 6,
                  fieldWidth: 45,
                  handleControllers: (e) {
                    controller = e;
                  },
                  focusedBorderColor: ColorConstant.darkestGrey,
                  borderColor: ColorConstant.darkestGrey,
                  showFieldAsBox: true,
                  clearText: cleartext,
                ),
                SizedBox(height: 30),
                Container(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(color: ColorConstant.lightGreen),
                  child: TextButton(
                      onPressed: loading
                          ? () {}
                          : () {
                              var otp =
                                  controller.map((e) => e?.value.text).join('');
                              if (otp.toString().isEmpty) {
                                SnackBarMessage.errorSnackbar(
                                    context, "Please enter OTP");
                              } else {
                                var data = {
                                  'code': otp.toString(),
                                  'email': widget.email.toString()
                                };
                                if (widget.type == 3) {
                                  data['type'] = 'phone';
                                } else {
                                  data['type'] = 'email';
                                }
                                setState(() {
                                  loading = true;
                                });
                                var http = HttpRequest();
                                (widget.type == 1
                                        ? http.verifyOtp(data)
                                        : http.signUpVerification(data))
                                    .then((value) {
                                  setState(() {
                                    loading = false;
                                  });
                                  if (value.success == true) {
                                    if (widget.type == 1) {
                                      navigateToPage(ChangePassword(
                                        isForget: true,
                                        email: widget.email ?? '',
                                        token:
                                            value.data['data']['token'] ?? '',
                                      ));
                                    } else {
                                      if (widget.type != 3) {
                                        //http.sendVerification(widget.email ?? '', 'phone');
                                        SnackBarMessage.successSnackbar(context,
                                            "Email Verify successfully");
                                        setState(() {
                                          widget.type = 3;
                                          cleartext = true;
                                        });
                                        navigateToOffAllNextPage(LoginScreen());
                                        // navigateToPage(OTPScreen(type: 2, phone: widget.phone ?? '',));
                                      } else {
                                        SnackBarMessage.successSnackbar(context,
                                            'Account verified SuccessFully');
                                        http.clearToken();
                                        navigateToOffAllNextPage(LoginScreen());
                                      }
                                    }
                                  } else {
                                    SnackBarMessage.errorSnackbar(
                                        context, value.message);
                                  }
                                });
                              }
                              // navigateToOffAllNextPage(LoginScreen());
                            },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          loading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text("Verify",
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
                SizedBox(
                  height: Get.height * 0.3,
                ),
                Center(
                    child: resend
                        ? InkWell(
                            onTap: () {
                              var http = HttpRequest();
                              http
                                  .sendVerification(widget.email!, 'email')
                                  .then((value) {
                                if (value.success == true) {
                                  SnackBarMessage.successSnackbar(
                                      context, "code resent successfully");
                                  setState(() {
                                    resend = false;
                                  });
                                  startTimer();
                                } else {
                                  SnackBarMessage.errorSnackbar(
                                      context, value.message);
                                }
                              });
                            },
                            child: Text(
                              "Send again",
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? ColorConstant.darkestGrey
                                    : ColorConstant.offWhite,
                                fontSize: 15,
                                fontFamily: FontConstant.jakartaSemiBold,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : Text(
                            "Send again ( $seconds )",
                            style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? ColorConstant.darkestGrey
                                  : ColorConstant.offWhite,
                              fontSize: 15,
                              fontFamily: FontConstant.jakartaSemiBold,
                              fontWeight: FontWeight.w600,
                            ),
                          ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
