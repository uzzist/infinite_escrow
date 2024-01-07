import 'package:infinite_escrow/routes/routes.dart';
import 'package:timeago/timeago.dart' as timeago;

Container customWithdrawHistoryContainer({
  required String price,
  required String charges,
  required String rate,
  required String recive,
  required String afterCharges,
  required String title,
  required String currencyName,
  required int id,
  required String sId,
  required Color containerColor,
  required String containerTitle,
  required DateTime date,
}) {
  return Container(
    height: 180,
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
        Text(
          "ID :${sId}",
          style: TextStyle(
              color: ColorConstant.darkestGrey,
              fontSize: 12,
              fontWeight: FontWeight.w600),
        ),
        // SvgPicture.asset(ImageConstant.paypal),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                text: 'Charge : ',
                style: TextStyle(
                    color: ColorConstant.darkestGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
                children: <TextSpan>[
                  TextSpan(
                      text: '${charges} ${currencyName}',
                      style: TextStyle(
                          color: ColorConstant.midNight,
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'After Charge : ',
                style: TextStyle(
                    color: ColorConstant.darkestGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
                children: <TextSpan>[
                  TextSpan(
                      text: '${afterCharges} ${currencyName}',
                      style: TextStyle(
                          color: ColorConstant.midNight,
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Rate: ${rate} ${currencyName}",
              style: TextStyle(
                  color: ColorConstant.darkestGrey,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
            Text.rich(
              TextSpan(
                text: 'Receivable : ',
                style: TextStyle(
                    color: ColorConstant.darkestGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
                children: <TextSpan>[
                  TextSpan(
                      text: recive,
                      style: TextStyle(
                          color: ColorConstant.midNight,
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                  TextSpan(
                    text: currencyName,
                    style: TextStyle(
                        color: ColorConstant.darkestGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ],
        ),
        Divider(),
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
            // Row(children: [
            //   Text(
            //     "More",
            //     style: TextStyle(
            //         color: ColorConstant.darkestGrey,
            //         fontSize: 12,
            //         fontWeight: FontWeight.w600),
            //   ),
            //   SizedBox(
            //     width: 5,
            //   ),
            //   Icon(
            //     Icons.arrow_forward_ios,
            //     color: ColorConstant.darkestGrey,
            //     size: 15,
            //   ),
            // ])
          ],
        )
      ],
    ),
  );
}
