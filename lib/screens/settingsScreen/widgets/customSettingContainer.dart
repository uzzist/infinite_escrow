import 'package:infinite_escrow/routes/routes.dart';

Container customSettingContainer({
    required String image,
    required String title,
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
              color: ColorConstant.midNight,
              fit: BoxFit.scaleDown,
            ),
          ),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
                color: ColorConstant.darkestGrey,
                fontSize: 15,
                fontWeight: FontWeight.w600),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: ColorConstant.darkestGrey,
          )
        ],
      ),
    );
  }