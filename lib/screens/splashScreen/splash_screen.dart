import 'package:infinite_escrow/routes/routes.dart';
import 'package:infinite_escrow/screens/splashScreen/splash_controller.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
          init: SplashController(),
          builder: (controller) {
            return Container(
              height: Get.height,
              width: Get.width,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageConstant.splash1),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.55,
                  ),
                  Text.rich(TextSpan(
                      text: "Never buy or\nsell online\nwithout using\n",
                      style: TextStyle(
                          fontSize: 33,
                          fontWeight: FontWeight.w400,
                          color: ColorConstant.black),
                      children: [
                        TextSpan(
                          text: "Infinite Escrow",
                          style: TextStyle(
                              fontSize: 33,
                              fontWeight: FontWeight.w400,
                              fontFamily: FontConstant.jakartaBold,
                              color: ColorConstant.black),
                        ),
                      ])),
                  SizedBox(height: Get.height * 0.04),
                  Center(
                    child: CircularProgressIndicator(
                      color: ColorConstant.black,
                      strokeWidth: 3,
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                      child: Text(
                    "All Rights Reserved By Infinite Escrow 2023",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: ColorConstant.black,
                        decoration: TextDecoration.underline),
                  ))
                ],
              ),
            );
          }),
    );
  }
}
