import 'package:infinite_escrow/routes/routes.dart';
import 'package:timeago/timeago.dart' as timeago;


Container customMilestoneContainer({
  required String price,
  required Color containerColor,
  required String containerTitle,
  required String currency,
  required DateTime date,
  required String note,
  required int id,
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
                  currency,
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
        Text(
          note,
          style: TextStyle(
              color: ColorConstant.darkestGrey,
              fontSize: 12,
              fontWeight: FontWeight.w500),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 66,
              height: 24,
              color: containerColor,
              child: Center(
                child: Text(
                  containerTitle,
                  style: TextStyle(
                      color: ColorConstant.midNight,
                      fontSize: 11,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                navigateToPage(EscrowDetailScreen(id: id));
              },
              child: Row(children: [
                Text(
                  "Details",
                  style: TextStyle(
                      color: ColorConstant.darkestGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: ColorConstant.darkestGrey,
                  size: 15,
                ),
              ]),
            )
          ],
        )
      ],
    ),
  );
}
