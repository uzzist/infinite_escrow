import 'dart:math';

import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/core/messages.dart';
import 'package:infinite_escrow/core/models/profile.dart';
import 'package:infinite_escrow/core/state/base_State.dart';
import 'package:infinite_escrow/routes/routes.dart';
import 'package:provider/provider.dart';

import 'models/states.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  StatesModel? states;
  ProfileModel? profile;
  RxString coin = "Naira".obs;
  @override
  void initState() {
    super.initState();
    var http = HttpRequest();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SnackBarMessage.showLoading(context);
      http.getUser().then((value) {
        profile = value;
        context.read<BaseState>().updateProfile(value);
      });
      var t = http.getCurrency();
      if (t != null) {
        setState(() {
          coin.value = t;
        });
      }
      http.getStates().then((value) {
        if (value.data['code'] == 403) {
          http.clearToken();
          navigateToPage(LoginScreen());
          return;
        }
        http.getEscrowCategoryList().then((value) {
          if (value.success) {
            http.saveEscrowCatagory(value.data['data']);
          }
        });
        if (t != null) {
          http.currencyExchange(coin.value).then((value1) {
            Navigator.pop(context);
            if (value1.success == true) {
              setState(() {
                states = StatesModel.formJson(value.data['data']);
                states?.updateData(value1.data['data']);
              });
            }
          });
        } else {
          Navigator.pop(context);
          if (value.success == true) {
            setState(() {
              states = StatesModel.formJson(value.data['data']);
            });
          }
        }
      });
    });
  }

  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });
    setState(() {});
    return completer.future.then<void>((_) {
      var http = HttpRequest();

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        SnackBarMessage.showLoading(context);
        http.getUser().then((value) {
          profile = value;
          context.read<BaseState>().updateProfile(value);
        });
        var t = http.getCurrency();
        if (t != null) {
          setState(() {
            coin.value = t;
          });
        }
        http.getStates().then((value) {
          if (value.data['code'] == 403) {
            http.clearToken();
            navigateToPage(LoginScreen());
            return;
          }
          http.getEscrowCategoryList().then((value) {
            if (value.success) {
              http.saveEscrowCatagory(value.data['data']);
            }
          });
          if (t != null) {
            http.currencyExchange(coin.value).then((value1) {
              Navigator.pop(context);
              if (value1.success == true) {
                setState(() {
                  states = StatesModel.formJson(value.data['data']);
                  states?.updateData(value1.data['data']);
                });
              }
            });
          } else {
            Navigator.pop(context);
            if (value.success == true) {
              setState(() {
                states = StatesModel.formJson(value.data['data']);
              });
            }
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.light
              ? ColorConstant.black
              : ColorConstant.white,
        ),
        elevation: 0,
        title: SvgPicture.asset(ImageConstant.logo),
        centerTitle: true,
        actions: [
          SvgPicture.asset(
            currencyImageByName[coin.value]!,
            color: Theme.of(context).brightness == Brightness.light
                ? ColorConstant.black
                : ColorConstant.white,
          ),
          IconButton(
              onPressed: () {
                customCurrencyBottomSheet(
                    context, coin, "Select currency wallet??", (e) {
                  setState(() {
                    coin.value = e;
                  });
                  Navigator.pop(context);
                  var http = HttpRequest();
                  SnackBarMessage.showLoading(context);
                  http.currencyExchange(e).then((value) {
                    Navigator.pop(context);
                    if (value.success == true) {
                      setState(() {
                        states?.updateData(value.data['data']);
                      });
                    }
                  });
                });
              },
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Theme.of(context).colorScheme.secondary,
              ))
        ],
      ),
      drawer: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        backgroundColor: ColorConstant.black,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: ColorConstant.white,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                Center(child: SvgPicture.asset(ImageConstant.logo)),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(vertical: 28),
                    width: 136,
                    height: 136,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(200)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(200)),
                      child: context.watch<BaseState>().profile?.image != null
                          ? Image.network(
                              context.watch<BaseState>().profile?.image ?? '',
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.green,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            )
                          : SvgPicture.asset(
                              ImageConstant.profilePicture,
                              fit: BoxFit.cover,
                            ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  context.watch<BaseState>().profile?.username ?? 'Loading',
                  style: TextStyle(
                      fontSize: 15,
                      color: ColorConstant.white,
                      fontFamily: FontConstant.jakartaMedium,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            ListTile(
              leading: SvgPicture.asset(ImageConstant.dashboardOutlined),
              title: Text(
                "Dashboard",
                style: TextStyle(
                    fontSize: 15,
                    color: ColorConstant.white,
                    fontFamily: FontConstant.jakartaMedium,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                navigateToPage(BottomNavigationScreen());
              },
            ),
            Divider(
              color: ColorConstant.dividerColor,
            ),
            ListTile(
              leading: SvgPicture.asset(ImageConstant.profile),
              title: Text(
                "Profile",
                style: TextStyle(
                    fontSize: 15,
                    color: ColorConstant.white,
                    fontFamily: FontConstant.jakartaMedium,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                navigateToPage(ProfileSetting());
              },
            ),
            Divider(
              color: ColorConstant.dividerColor,
            ),
            ListTile(
              leading: SvgPicture.asset(ImageConstant.notification),
              title: Text(
                "Notifications",
                style: TextStyle(
                    fontSize: 15,
                    color: ColorConstant.white,
                    fontFamily: FontConstant.jakartaMedium,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                navigateToPage(NotificationScreen());
              },
            ),
            Divider(
              color: ColorConstant.dividerColor,
            ),
            ListTile(
              leading: SvgPicture.asset(ImageConstant.transaction),
              title: Text(
                "Transactions",
                style: TextStyle(
                    fontSize: 15,
                    color: ColorConstant.white,
                    fontFamily: FontConstant.jakartaMedium,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                navigateToPage(TransactionScreen());
              },
            ),
            Divider(
              color: ColorConstant.dividerColor,
            ),
            ListTile(
              leading: SvgPicture.asset(ImageConstant.settings2),
              title: Text(
                "Settings",
                style: TextStyle(
                    fontSize: 15,
                    color: ColorConstant.white,
                    fontFamily: FontConstant.jakartaMedium,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                navigateToPage(SettingScreen());
              },
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    navigateToPage(BalanceScreen());
                  },
                  child: customCurrencyContainer(
                    currecy: coin.value,
                    image: ImageConstant.balance,
                    title: "Your Balance",
                    price: states?.balance.toString() ?? '0',
                    backgroundColor: ColorConstant.lightPurple,
                    iconColor: ColorConstant.purple,
                    iconContainerColor: ColorConstant.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    navigateToPage(DepositHistoryScreen());
                  },
                  child: customCurrencyContainer(
                    currecy: coin.value,
                    image: ImageConstant.deposit,
                    title: "Deposit",
                    price: states?.depositAmount.toString() ?? '0',
                    backgroundColor: ColorConstant.lightTurquoise,
                    iconColor: ColorConstant.turquoise,
                    iconContainerColor: ColorConstant.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    navigateToPage(WithdrawlogScreen());
                  },
                  child: customCurrencyContainer(
                    currecy: coin.value,
                    image: ImageConstant.withdraw,
                    title: "Withdrawal",
                    price: states?.withdrawAmount.toString() ?? '0',
                    backgroundColor: ColorConstant.lightMustard,
                    iconColor: ColorConstant.mustard,
                    iconContainerColor: ColorConstant.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    navigateToPage(MilestoneScreen());
                  },
                  child: customCurrencyContainer(
                    currecy: coin.value,
                    image: ImageConstant.milestone,
                    title: "Milestone funded",
                    price: states?.milestoneAmount.toString() ?? '0',
                    backgroundColor: ColorConstant.lightPink,
                    iconColor: ColorConstant.pink,
                    iconContainerColor: ColorConstant.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Escrows",
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: FontConstant.jakartaMedium,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    navigateToPage(AwaitingEscrowScreen());
                  },
                  child: Container(
                    height: 64,
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      ColorConstant.lightGreen,
                      ColorConstant.lightGreen2
                    ])),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(136, 144, 152, 0.2),
                              shape: BoxShape.circle),
                          child: SvgPicture.asset(
                            ImageConstant.time,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: SizedBox(
                            height: 36,
                            child: GradientText(
                              "Awaiting for Accept",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: FontConstant.jakartaMedium,
                                  fontWeight: FontWeight.w500),
                              colors: [
                                ColorConstant.darkestGrey,
                                ColorConstant.midNight,
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            GradientText(
                              states?.noAccepted.toString() ?? '0',
                              style: TextStyle(
                                  fontSize: 28,
                                  fontFamily: FontConstant.jakartaBold,
                                  fontWeight: FontWeight.w500),
                              colors: [
                                ColorConstant.black,
                                ColorConstant.black.withOpacity(0.6),
                              ],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "|",
                              style: TextStyle(
                                color: ColorConstant.white,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: ColorConstant.white,
                              size: 14,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    navigateToPage(CompletedScreen());
                  },
                  child: customCurrencyContainer(
                      currecy: coin.value,
                      image: ImageConstant.tick,
                      title: "Completed",
                      price: states?.completed.toString() ?? '0',
                      currencyShow: false),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    navigateToPage(DisputedScreen());
                  },
                  child: customCurrencyContainer(
                      currecy: coin.value,
                      image: ImageConstant.disputed,
                      title: "Disputed",
                      price: states?.disputed.toString() ?? '0',
                      currencyShow: false),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    navigateToPage(CanceledScreen());
                  },
                  child: customCurrencyContainer(
                      currecy: coin.value,
                      image: ImageConstant.cancelled,
                      title: "Canceled",
                      price: states?.cancelled.toString() ?? '0',
                      currencyShow: false),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    navigateToPage(TransactionScreen());
                  },
                  child: customCurrencyContainer(
                      currecy: coin.value,
                      image: ImageConstant.handHeart,
                      title: "Your Escrow",
                      price: states?.total.toString() ?? '0',
                      currencyShow: false),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    navigateToPage(RuningEscrowScreen());
                  },
                  child: customCurrencyContainer(
                      currecy: coin.value,
                      image: ImageConstant.runningEscrow,
                      title: "Running Escrow",
                      price: states?.accepted.toString() ?? '0',
                      currencyShow: false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
