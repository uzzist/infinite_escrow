
import 'package:infinite_escrow/routes/routes.dart';


Container customCurrencyContainer({
  required String image,
  required String title,
  required String price,
  required String currecy,
  bool currencyShow = true,
}) {
  return Container(
    height: 80,
    width: Get.width,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(color: ColorConstant.white, boxShadow: [
      BoxShadow(
        color: ColorConstant.black.withOpacity(0.1),
        spreadRadius: 0,
        blurRadius: 14,
        offset: Offset(0, 5), // changes position of shadow
      ),
    ]),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Color.fromRGBO(136, 144, 152, 0.2),
          ),
          child: SvgPicture.asset(
            image,
            fit: BoxFit.scaleDown,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: SizedBox(
            height: 36,
            child: GradientText(
              title,
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: FontConstant.jakartaMedium,
                  fontWeight: FontWeight.w500),
              colors: [
                Color(0xff58636E),
                Color(0xff11202F),
              ],
            ),
          ),
        ),
        Spacer(),
        Row(
          children: [
            GradientText(
              price,
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
            currencyShow == true
                ? SvgPicture.asset(
                  currencyImageByName[currecy]!,
                    fit: BoxFit.scaleDown,
                    height: 16,
                    width: 7,
                    // color: ColorConstant.grey,
                  )
                : SizedBox(),
            SizedBox(
              width: 5,
            ),
            Text(
              "|",
              style: TextStyle(
                color: ColorConstant.grey,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: ColorConstant.grey,
              size: 14,
            )
          ],
        )
      ],
    ),
  );
}
