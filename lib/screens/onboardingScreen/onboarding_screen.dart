import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/routes/routes.dart';


class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OnboardingScreenController>(
          init: OnboardingScreenController(),
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            var http = HttpRequest();
                            http.setOnBoard();
                            navigateToOffAllNextPage(LoginScreen());
                          },
                          child: Text(
                            "Skip",
                            style: TextStyle(
                                color: ColorConstant.midNight,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                      child: PageView.builder(
                          itemCount: controller.pages.length,
                          controller: controller.pageController,
                          itemBuilder: (context, index) {
                            return controller.pages[index];
                          })),
                  // SizedBox(height: Get.height * 0.14),
                  if (controller.currentPage == controller.pages.length - 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              controller.pageController.previousPage(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeIn);
                            },
                            icon: Icon(Icons.arrow_back)),
                        Container(
                          height: 48,
                          width: 154,
                          decoration: BoxDecoration(
                            color: ColorConstant.midNight,
                          ),
                          child: TextButton(
                              onPressed: () {
                                var http = HttpRequest();
                                http.setOnBoard();
                                navigateToOffAllNextPage(LoginScreen());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Next",
                                    style: TextStyle(
                                        color: ColorConstant.white,
                                        fontSize: 15,
                                        fontFamily:
                                            FontConstant.jakartaSemiBold,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: ColorConstant.white,
                                  )
                                ],
                              )),
                        )
                      ],
                    )
                  else
                    Row(
                      mainAxisAlignment:controller.currentPage != 0?  MainAxisAlignment.spaceBetween: MainAxisAlignment.end,
                      children: [
                        controller.currentPage != 0? IconButton(
                            onPressed: () {
                              controller.pageController.previousPage(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeIn);
                            },
                            icon: Icon(Icons.arrow_back)): SizedBox(),
                        Container(
                          height: 48,
                          width: 154,
                          decoration: BoxDecoration(
                            color: ColorConstant.midNight,
                          ),
                          child: TextButton(
                              onPressed: () {
                                controller.pageController.nextPage(
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeIn);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Next",
                                    style: TextStyle(
                                        color: ColorConstant.white,
                                        fontSize: 15,
                                        fontFamily:
                                            FontConstant.jakartaSemiBold,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: ColorConstant.white,
                                  )
                                ],
                              )),
                        )
                      ],
                    )
                ],
              ),
            );
          }),
    );
  }
}
