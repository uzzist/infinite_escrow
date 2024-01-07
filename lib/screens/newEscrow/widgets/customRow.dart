import 'package:infinite_escrow/routes/routes.dart';

Row customRow({
    required String title,
    required double amount,
  required String currency
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              color: ColorConstant.darkestGrey,
              fontSize: 13,
              fontWeight: FontWeight.w500),
        ),
        Row(
          children: [
            Text(
              amount.toString(),
              style: TextStyle(
                  color: ColorConstant.midNight,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              currency,
              style: TextStyle(
                  color: ColorConstant.darkestGrey,
                  fontSize: 13,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    );
  }