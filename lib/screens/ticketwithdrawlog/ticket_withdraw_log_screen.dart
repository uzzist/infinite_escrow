import 'package:infinite_escrow/routes/routes.dart';

class TicketWithdrawlogScreen extends StatelessWidget {
  const TicketWithdrawlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        persistentFooterButtons: [
          Container(
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(color: ColorConstant.lightGreen),
            child: TextButton(
                onPressed: () {
                  navigateToPage(TickerSellerInfoScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageConstant.plus),
                    SizedBox(
                      width: 10,
                    ),
                    Text("New ticket",
                        style: TextStyle(
                            color: ColorConstant.midNight,
                            fontSize: 17,
                            fontFamily: FontConstant.jakartaSemiBold,
                            fontWeight: FontWeight.w700)),
                  ],
                )),
          ),
        ],
        appBar: customAppBar(title: "All tickets"),
        body: Padding(
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
                            "Only Opens",
                          ),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child:
                        TabBarView(children: [AllTickerTab(), OnlyOpensTab()])),
              ],
            )),
      ),
    );
  }
}
