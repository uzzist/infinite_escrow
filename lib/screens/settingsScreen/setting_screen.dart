import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/routes/routes.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  RxString coin = "Naira".obs;
  @override
  void initState() {
    super.initState();
    var http = HttpRequest();
    var t = http.getCurrency();
    if( t != null ){
      setState(() {
        coin.value = t;
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Setting",
        isActionsShow: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.bottomSheet(
                  Container(
                    height: 300,
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
                          "Log out",
                          style: TextStyle(
                              color: ColorConstant.midNight,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SvgPicture.asset(ImageConstant.leaving),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 163.5,
                              height: 56,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorConstant.black, width: 2)),
                              child: TextButton(
                                  onPressed: () {
                                    var http = HttpRequest();
                                    http.clearToken();
                                    navigateToOffAllNextPage(LoginScreen());
                                  },
                                  child: Text(
                                    "Yes, Log out",
                                    style: TextStyle(
                                        color: ColorConstant.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ),
                            Container(
                              width: 163.5,
                              height: 56,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorConstant.black, width: 2)),
                              child: TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    "No, Cancel",
                                    style: TextStyle(
                                        color: ColorConstant.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.logout,
                color: ColorConstant.black,
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                navigateToPage(ProfileSetting());
              },
              child: customSettingContainer(
                image: ImageConstant.profile,
                title: "Profile Setting",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                navigateToPage(TicketWithdrawlogScreen());
              },
              child: customSettingContainer(
                image: ImageConstant.tickets,
                title: "All Tickets",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
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
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(136, 144, 152, 0.2),
                    ),
                    child: SvgPicture.asset(
                      ImageConstant.runningEscrow,
                      color: ColorConstant.midNight,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Default Currency",
                    style: TextStyle(
                        color: ColorConstant.darkestGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  InkWell(
                      onTap: () {
                        customCurrencyBottomSheet(
                            context, coin, "Select currency wallet??", (e){
                          coin.value = e;
                          var http =HttpRequest();
                          http.saveCurrency(e);
                          setState(() {

                          });
                        });
                      },
                      child: SvgPicture.asset(currencyImageByName[coin.value]!))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                navigateToPage(ChangePassword(isForget: false, email: '', token: '',));
              },
              child: customSettingContainer(
                image: ImageConstant.changePassword,
                title: "Change Password",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                navigateToPage(FAScreen());
              },
              child: customSettingContainer(
                image: ImageConstant.security,
                title: "2FA Security",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
