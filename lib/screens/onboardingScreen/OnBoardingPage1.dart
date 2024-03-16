import 'package:infinite_escrow/routes/routes.dart';

class OnBoardingPage1 extends StatelessWidget {
  final String title;
  final String? text;
  final String image;
  const OnBoardingPage1(
      {super.key, required this.title, required this.image, this.text});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Center(
        child: Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
              color: ColorConstant.grey.withOpacity(0.3),
              shape: BoxShape.circle),
          child: Center(child: Image.asset(image)),
        ),
      ),
      SizedBox(height: 30),
      Text(
        title,
        style: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? ColorConstant.midNight // Set color to black in light theme
                : ColorConstant.white,
            fontSize: 20,
            fontFamily: FontConstant.jakartaSemiBold,
            fontWeight: FontWeight.w600),
      ),
      SizedBox(height: 30),
      Text(
        text ?? '',
        style: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? ColorConstant.darkestGrey // Set color to black in light theme
                : ColorConstant.offWhite,
            fontSize: 13,
            fontFamily: FontConstant.jakartaMedium,
            fontWeight: FontWeight.w500),
      )
    ]);
  }
}
