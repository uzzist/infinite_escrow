import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/routes/routes.dart';

import '../../core/messages.dart';
import 'model/withdraw_model.dart';

class WithdrawlogScreen extends StatefulWidget {
  const WithdrawlogScreen({super.key});

  @override
  State<WithdrawlogScreen> createState() => _WithdrawlogScreenState();
}

class _WithdrawlogScreenState extends State<WithdrawlogScreen> {
  List<WithdrawModel> listModels = [];
  List<WithdrawModel> listPendingModels = [];
  bool loading = false;
  @override
  void initState() {
    super.initState();
    var http = HttpRequest();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SnackBarMessage.showLoading(context);
      var all = http.getWithdrawList();
      var pending = http.getWithdrawPendingList();
      Future.wait([all, pending]).then((value) {
        Navigator.pop(context);
        if (value[0].success == true) {
          setState(() {
            listModels = WithdrawModel.fromList(value[0].data['data']['data']);
            listPendingModels =
                WithdrawModel.fromList(value[1].data['data']['data']);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        persistentFooterButtons: [
          listModels.isEmpty
              ? SizedBox()
              : Container(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(color: ColorConstant.lightGreen),
                  child: TextButton(
                      onPressed: () {
                        navigateToPage(
                            NewDepositScreen(title: 'New Withdraw', type: 2));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(ImageConstant.plus),
                          SizedBox(
                            width: 10,
                          ),
                          Text("New withdraw",
                              style: TextStyle(
                                  color: ColorConstant.midNight,
                                  fontSize: 17,
                                  fontFamily: FontConstant.jakartaSemiBold,
                                  fontWeight: FontWeight.w700)),
                        ],
                      )),
                ),
        ],
        appBar: customAppBar(
          title: "Withdraw log",
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            titleColor: Theme.of(context).colorScheme.tertiary,
            iconColor: Theme.of(context).colorScheme.tertiary,
          actions: [
            IconButton(
                onPressed: () {
                  navigateToPage(NewWithdrawlogScreen(
                    title: "New Withdraw",
                  ));
                },
                icon: SvgPicture.asset(ImageConstant.plus))
          ],
        ),
        body: listModels.isEmpty
            ? Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: MediaQuery.of(context).size.height / 4),
                child: Center(
                  child: Column(
                    children: [
                      Image.asset(
                        ImageConstant.noWithdraw,
                        width: 103,
                      ),
                      SizedBox(height: 16),
                      Container(
                        height: 56,
                        width: double.infinity,
                        decoration:
                            BoxDecoration(color: ColorConstant.lightGreen),
                        child: TextButton(
                            onPressed: () {
                              navigateToPage(NewDepositScreen(
                                  title: 'New Withdraw', type: 2));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(ImageConstant.plus),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("New Withdraw",
                                    style: TextStyle(
                                        color: ColorConstant.midNight,
                                        fontSize: 17,
                                        fontFamily:
                                            FontConstant.jakartaSemiBold,
                                        fontWeight: FontWeight.w700)),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 36,
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: ColorConstant.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TabBar(
                          indicator: BoxDecoration(
                            color: ColorConstant.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          unselectedLabelColor: ColorConstant.black,
                          labelColor: ColorConstant.black,
                          labelStyle: TextStyle(
                              color: ColorConstant.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                          tabs: [
                            Tab(
                              child: Text(
                                "All",
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Pending",
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: TabBarView(children: [
                      AllWithDrawDepositTab(list: listModels),
                      PendedWithdrawTab(list: listPendingModels)
                    ])),
                  ],
                )),
      ),
    );
  }
}
