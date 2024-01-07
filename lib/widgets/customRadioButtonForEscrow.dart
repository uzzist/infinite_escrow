
import 'package:infinite_escrow/routes/routes.dart';

SizedBox customRadioButtonForEscrow({
  required RxString coin,
  required String typeName,
  required String value,
  required Function change
}) {
  return SizedBox(
    child: Column(
      children: [
        Obx(
          () => InkWell(
            onTap: (){
              coin.value = value.toString();
              change(value);
            },
            child: Row(
              children: [
                Radio(
                    activeColor: Color(0xff0E642B),
                    groupValue: coin.value,
                    value: value,
                    onChanged: (val) {
                      coin.value = val.toString();
                      change(value);
                    }),
                SizedBox(width: 10),
                Text(
                  typeName,
                  style: TextStyle(
                      color: coin.value == value
                          ? Color(0xff0E642B)
                          : ColorConstant.midNight,
                      fontWeight: FontWeight.w500,
                      fontFamily: FontConstant.jakartaMedium,
                      fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        Divider(),
        SizedBox(
          height: 10,
        )
      ],
    ),
  );
}
