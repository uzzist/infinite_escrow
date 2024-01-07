import 'package:infinite_escrow/routes/routes.dart';

class NewWithdrawLOGScreen extends StatelessWidget {
  final String title;
  const NewWithdrawLOGScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Container(
          height: 56,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: ColorConstant.midNight, width: 2)),
          child: TextButton(
              onPressed: () {
                navigateToOffAllNextPage(BottomNavigationScreen());
              },
              child: Text("Go to dashboard",
                  style: TextStyle(
                      color: ColorConstant.midNight,
                      fontSize: 17,
                      fontWeight: FontWeight.w600))),
        ),
      ],
      appBar: customAppBar(title: title),
      body: Center(
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
              "$title submitted successfully ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xff404D58),
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      )),
    );
  }
}
