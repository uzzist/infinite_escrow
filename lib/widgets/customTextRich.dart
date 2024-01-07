
import 'package:infinite_escrow/routes/routes.dart';
Text customTextRich(BuildContext context) {
  return Text.rich(
    TextSpan(
        text: "By registering, you approve that you are agree with",
        style: TextStyle(
            color: ColorConstant.black,
            fontSize: 12,
            fontFamily: FontConstant.jakartaSemiBold,
            fontWeight: FontWeight.w500),
        children: [
          TextSpan(
              text: " Privacy Policy",
              recognizer: TapGestureRecognizer()
                ..onTap = () => customBottomSheet(context, "Privacy Policy"),
              style: TextStyle(
                  color: ColorConstant.black,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  fontFamily: FontConstant.jakartaSemiBold,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: " , ",
              style: TextStyle(
                  color: ColorConstant.black,
                  fontSize: 12,
                  fontFamily: FontConstant.jakartaSemiBold,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: " Terms of Service",
              recognizer: TapGestureRecognizer()
                ..onTap = () => customBottomSheet(context, "Terms of Service"),
              style: TextStyle(
                  color: ColorConstant.black,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  fontFamily: FontConstant.jakartaSemiBold,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: " , ",
              style: TextStyle(
                  color: ColorConstant.black,
                  fontSize: 12,
                  fontFamily: FontConstant.jakartaSemiBold,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: " Payment Policy",
              recognizer: TapGestureRecognizer()
                ..onTap = () => customBottomSheet(context, "Payment Policy"),
              style: TextStyle(
                  color: ColorConstant.black,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  fontFamily: FontConstant.jakartaSemiBold,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: " , ",
              style: TextStyle(
                  color: ColorConstant.black,
                  fontSize: 12,
                  fontFamily: FontConstant.jakartaSemiBold,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: "  Company Rules",
              recognizer: TapGestureRecognizer()
                ..onTap = () => customBottomSheet(context, "Company Rules"),
              style: TextStyle(
                  color: ColorConstant.black,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  fontFamily: FontConstant.jakartaSemiBold,
                  fontWeight: FontWeight.w500))
        ]),
  );
}
