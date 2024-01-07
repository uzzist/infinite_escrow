import 'package:infinite_escrow/routes/routes.dart';

Container customRuningEscrowContainer({
  required String price,
  required Color containerColor,
  required String containerTitle,
}) {
  return Container(
    height: 114,
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
                  "NGN",
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
                  "3 hours ago",
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
          "ID :C-S1234",
          style: TextStyle(
              color: ColorConstant.darkestGrey,
              fontSize: 12,
              fontWeight: FontWeight.w600),
        ),
        // SvgPicture.asset(ImageConstant.paypal),
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
            Row(children: [
              InkWell(
                onTap: () {
                  navigateToPage(RuningEscrowDetailScreen());
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
            ])
          ],
        )
      ],
    ),
  );
}
