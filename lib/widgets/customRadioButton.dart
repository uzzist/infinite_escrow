
import 'package:infinite_escrow/routes/routes.dart';

SizedBox customRadioButton(
      {required RxString coin,
      required String coinName,
      required String value,
        required Function click,
      required String coinImage,
      required String coinPrice}) {
    return SizedBox(
      child: Column(
        children: [
          Obx(
            () => InkWell(
              onTap: (){
                coin.value = value.toString();
                click(value);
              },
              child: Row(
                children: [
                  Radio(
                      activeColor: ColorConstant.darkestGrey,
                      groupValue: coin.value,
                      value: value,
                      onChanged: (val) {
                        coin.value = val.toString();
                        click(value);
                      }),
                  SvgPicture.asset(coinImage),
                  SizedBox(width: 10),
                  Text(
                    coinName,
                    style: TextStyle(
                        color: ColorConstant.midNight,
                        fontWeight: FontWeight.w500,
                        fontFamily: FontConstant.jakartaMedium,
                        fontSize: 14),
                  ),
                  Spacer(),
                  Text(coinPrice,
                      style: TextStyle(
                          color: ColorConstant.midNight,
                          fontWeight: FontWeight.w500,
                          fontFamily: FontConstant.jakartaMedium,
                          fontSize: 14))
                ],
              ),
            ),
          ),
          Divider(),
          SizedBox(height: 10)
        ],
      ),
    );
  }