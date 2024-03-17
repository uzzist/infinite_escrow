import 'dart:io';

import 'package:flutter/services.dart';
import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/routes/routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/messages.dart';
import '../../core/models/profile.dart';

class FAScreen extends StatefulWidget {
  const FAScreen({super.key});

  @override
  State<FAScreen> createState() => _FAScreenState();
}

class _FAScreenState extends State<FAScreen> {
  String url = '';
  String code = 'AVJWV3Q2XTG7OWJL';
  String pass = '';
  ProfileModel? profile;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    var http = HttpRequest();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      http.getUser().then((value) => {profile = value});
      SnackBarMessage.showLoading(context);
      http.getFaShow().then((value) {
        Navigator.pop(context);
        if (value.success == true) {
          setState(() {
            code = value.data['secret'];
            url = value.data['qrCodeUrl'];
          });
        }
      });
    });
  }

  Future<void> mobileAppUrl(dynamic context) async {
    if (Platform.isAndroid) {
      final Uri url = Uri(
          scheme: 'https',
          host: 'play.google.com',
          query: 'id=com.google.android.apps.authenticator2',
          path: '/store/apps/details');
      https: //apps.apple.com/us/app/google-authenticator/id388497605
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        SnackBarMessage.errorSnackbar(context, 'Some thing went Wrong!');
      }
    } else {
      final Uri url = Uri(
          scheme: 'https',
          host: 'apps.apple.com',
          path: '/us/app/google-authenticator/id388497605');
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        SnackBarMessage.errorSnackbar(context, 'Some thing went Wrong!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: "Two Factor Authenticator",
          iconColor: Theme.of(context).colorScheme.tertiary,
          titleColor: Theme.of(context).colorScheme.tertiary,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    code,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    child: Icon(Icons.copy),
                    onTap: () async {
                      await Clipboard.setData(ClipboardData(text: code));
                    },
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                    height: 200,
                    width: 200,
                    child: url.isNotEmpty
                        ? Image.network(url)
                        : Image.asset("assets/images/qr_code.png")),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 56,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                )),
                child: TextButton(
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: ColorConstant.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Verify Your Otp",
                                style: TextStyle(
                                    color: ColorConstant.midNight,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SvgPicture.asset(
                                  ImageConstant.googleAuthenticator),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Google Authenticator",
                                style: TextStyle(
                                    color: ColorConstant.midNight,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15),
                                child: customTextField(
                                    onChange: (e) {
                                      setState(() {
                                        pass = e;
                                      });
                                    },
                                    hintText: "Enter Google Authenticator Code",
                                    prefixIcon: ImageConstant.security),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15),
                                child: Container(
                                  height: 56,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: ColorConstant.lightGreen),
                                  child: TextButton(
                                      onPressed: loading
                                          ? () {}
                                          : () {
                                              // navigateToOffAllNextPage(SettingScreen());
                                              var data = {
                                                'key': code,
                                                'code': pass
                                              };
                                              setState(() {
                                                loading = true;
                                              });
                                              var http = HttpRequest();
                                              (profile?.ts == 1
                                                      ? http.fsDisable(data)
                                                      : http.fsEnable(data))
                                                  .then((value) {
                                                setState(() {
                                                  loading = false;
                                                });
                                                if (value.success) {
                                                  if (profile?.ts == 1) {
                                                    SnackBarMessage.successSnackbar(
                                                        context,
                                                        'Two Factor Authenticator is Disable');
                                                  } else {
                                                    SnackBarMessage.successSnackbar(
                                                        context,
                                                        'Two Factor Authenticator is Enabled');
                                                  }
                                                } else {
                                                  SnackBarMessage.errorSnackbar(
                                                      context, value.message);
                                                }
                                              });
                                            },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          loading
                                              ? CircularProgressIndicator(
                                                  color: Colors.white,
                                                )
                                              : Text("Save Changes",
                                                  style: TextStyle(
                                                      color: ColorConstant
                                                          .midNight,
                                                      fontSize: 17,
                                                      fontFamily: FontConstant
                                                          .jakartaSemiBold,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 3.0),
                                            child: Icon(
                                              Icons.arrow_forward,
                                              color: ColorConstant.midNight,
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "${profile?.ts == 1 ? 'Disable' : 'Enable'} Two Factor Authenticator",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 17,
                                fontFamily: FontConstant.jakartaSemiBold,
                                fontWeight: FontWeight.w700)),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: Get.height * 0.47,
                width: double.infinity,
                padding: EdgeInsets.all(10),
                color: ColorConstant.grey.withOpacity(0.5),
                child: Column(
                  children: [
                    SvgPicture.asset(ImageConstant.googleAuthenticator),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Google Authenticator",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Google Authenticator is a multifactor app for mobile devices. It generates timed codes used during the 2-step verification process. To use Google Authenticator, install the Google Authenticator application on your mobile device.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 56,
                      width: 179,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      )),
                      child: TextButton(
                          onPressed: () {
                            mobileAppUrl(context);
                          },
                          child: Text("Download App",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 17,
                                  fontFamily: FontConstant.jakartaSemiBold,
                                  fontWeight: FontWeight.w700))),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
