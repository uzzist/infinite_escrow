import 'package:infinite_escrow/routes/routes.dart';
import 'package:timeago/timeago.dart' as timeago;


Container customTickerContainer({
  required String ticketNo,
  required Color containerColor,
  required String containerTitle,
  required String subject,
  required Color dividercolor,
  required DateTime replayTime,
  required int id,
  final double? containerWidth,
}) {
  return Container(
    height: 140,
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
                  "|",
                  style: TextStyle(
                      color: dividercolor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Ticket # $ticketNo",
                  style: TextStyle(
                      color: ColorConstant.darkestGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Container(
              width: containerWidth ?? 66,
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
          ],
        ),
        Divider(),
        Text(
          subject,
          style: TextStyle(
              color: ColorConstant.midNight,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                  timeago.format(replayTime),
                  style: TextStyle(
                      color: ColorConstant.darkestGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Row(children: [
              TextButton(
                onPressed: () {
                  navigateToPage(TicketMessagingScreen(id: id));
                },
                child: Text(
                  "Details",
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
            ])
          ],
        ),

        // SvgPicture.asset(ImageConstant.paypal),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text.rich(
        //       TextSpan(
        //         text: 'Charge : ',
        //         style: TextStyle(
        //             color: ColorConstant.darkestGrey,
        //             fontSize: 12,
        //             fontWeight: FontWeight.w600),
        //         children: <TextSpan>[
        //           TextSpan(
        //               text: ' 458.40 NGN',
        //               style: TextStyle(
        //                   color: ColorConstant.midNight,
        //                   fontSize: 12,
        //                   fontWeight: FontWeight.w600)),
        //         ],
        //       ),
        //     ),
        //     Text.rich(
        //       TextSpan(
        //         text: 'After Charge : ',
        //         style: TextStyle(
        //             color: ColorConstant.darkestGrey,
        //             fontSize: 12,
        //             fontWeight: FontWeight.w600),
        //         children: <TextSpan>[
        //           TextSpan(
        //               text: ' 450.00 NGN',
        //               style: TextStyle(
        //                   color: ColorConstant.midNight,
        //                   fontSize: 12,
        //                   fontWeight: FontWeight.w600)),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       "Rate: 8.00 NGN",
        //       style: TextStyle(
        //           color: ColorConstant.darkestGrey,
        //           fontSize: 12,
        //           fontWeight: FontWeight.w600),
        //     ),
        //     Text.rich(
        //       TextSpan(
        //         text: 'Receivable : ',
        //         style: TextStyle(
        //             color: ColorConstant.darkestGrey,
        //             fontSize: 12,
        //             fontWeight: FontWeight.w600),
        //         children: <TextSpan>[
        //           TextSpan(
        //               text: ' 8.00 ',
        //               style: TextStyle(
        //                   color: ColorConstant.midNight,
        //                   fontSize: 15,
        //                   fontWeight: FontWeight.w600)),
        //           TextSpan(
        //             text: 'NGN ',
        //             style: TextStyle(
        //                 color: ColorConstant.darkestGrey,
        //                 fontSize: 12,
        //                 fontWeight: FontWeight.w600),
        //           )
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ],
    ),
  );
}
