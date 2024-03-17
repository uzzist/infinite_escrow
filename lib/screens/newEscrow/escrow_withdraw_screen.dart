import 'package:infinite_escrow/routes/routes.dart';

class EscrowWithdrawScreen extends StatelessWidget {
  String title;
  String tTitle;
  String price;
  String coin;
  String escrowType;
  bool isSeller;

  EscrowWithdrawScreen(
      {super.key,
      required this.tTitle,
      required this.title,
      required this.price,
      required this.coin,
      required this.escrowType,
      required this.isSeller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Container(
          height: 56,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.primary, width: 2)),
          child: TextButton(
              onPressed: () {
                navigateToOffAllNextPage(BottomNavigationScreen());
              },
              child: Text("Go to dashboard",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 17,
                      fontWeight: FontWeight.w600))),
        ),
      ],
      appBar: customAppBar(
          title: title,
          titleColor: Theme.of(context).colorScheme.tertiary,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          iconColor: Theme.of(context).colorScheme.tertiary),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(ImageConstant.withdrawTick),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 168,
              height: 40,
              child: Text(
                tTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 168,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    price,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 28,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    coin,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 44,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              color: Color(0xffE7F6EB),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isSeller
                      ? Text(
                          "As a Seller",
                          style: TextStyle(
                              color: ColorConstant.midNight,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        )
                      : Text(
                          "As a Buyer",
                          style: TextStyle(
                              color: ColorConstant.midNight,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                  Text(
                    "$escrowType",
                    style: TextStyle(
                        color: ColorConstant.midNight,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
