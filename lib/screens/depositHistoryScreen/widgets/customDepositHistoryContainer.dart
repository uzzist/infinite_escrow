import 'package:infinite_escrow/routes/routes.dart';
import 'package:timeago/timeago.dart' as timeago;


Container customDepositHistoryContainer({
  required String price,
  required Color containerColor,
  required String containerTitle,
  required String title,
  required String currencyName,
  required int id,
  required String sId,
  required DateTime date,
  String? gateway,
}) {
  return Container(
    height: 125,
    width: double.infinity,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(color: ColorConstant.white, boxShadow: [
      BoxShadow(
        color: ColorConstant.black.withOpacity(0.1),
        spreadRadius: 0,
        blurRadius: 14,
        offset: Offset(0, 5), // changes position of shadow
      ),
    ]),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  price,
                  style: TextStyle(
                      color: ColorConstant.midNight,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  currencyName,
                  style: TextStyle(
                      color: ColorConstant.darkestGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.access_time_rounded,
                  color: ColorConstant.darkestGrey,
                  size: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  timeago.format(date),
                  style: TextStyle(
                      color: ColorConstant.darkestGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ],
            )
          ],
        ),
        Divider(),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      'ID :C-${sId}',
      style: TextStyle(
          color: ColorConstant.darkestGrey,
          fontSize: 12,
          fontWeight: FontWeight.w600),
    ),
    gateway != null ? Text(
      gateway,
      style: TextStyle(
          color: ColorConstant.darkestGrey,
          fontSize: 12,
          fontWeight: FontWeight.w600),
    ): SizedBox(),
  ],
),
        // SvgPicture.asset(ImageConstant.paypal),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Container(
            //   height: 24,
            //   padding: EdgeInsets.symmetric(horizontal: 8),
            //   color: containerColor,
            //   child: Center(
            //     child: Text(
            //       containerTitle,
            //       style: TextStyle(
            //           color: ColorConstant.midNight,
            //           fontSize: 11,
            //           fontWeight: FontWeight.w500),
            //     ),
            //   ),
            // ),
            id > 0? Row(children: [
              InkWell(
                onTap: () {
                  navigateToPage(EscrowDetailScreen(id : id));
                },
                child: Text(
                  "More",
                  style: TextStyle(
                      color: ColorConstant.darkestGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: ColorConstant.darkestGrey,
                size: 15,
              ),
            ]): SizedBox()
          ],
        )
      ],
    ),
  );
}
