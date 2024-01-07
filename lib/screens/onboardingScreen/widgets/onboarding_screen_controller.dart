import 'package:infinite_escrow/routes/routes.dart';


class OnboardingScreenController extends GetxController{
  final PageController _pageController = PageController();
  int _currentPage = 0;
  @override
  void onInit() {
    _pageController.addListener(() {
      _currentPage = _pageController.page!.toInt();
      update();
    });
    super.onInit();
  }

  @override
  void onClose() {
    _pageController.dispose();
    super.onClose();
  }

  PageController get pageController => _pageController;
  int get currentPage => _currentPage;

  List pages = [
      OnBoardingPage1(
        title: "Title One",
        text: 'Infinite escrow is for contractual arrangement in which a third party receives and disburses money or cryptography, property or deals for the primary transacting parties, with the disbursement dependent on terms and conditions agreed to by the transacting parties.',
        image: ImageConstant.onBoardingPic1,
      ),
      OnBoardingPage1(
        title: "Title Two",
        text: 'With Escrow you can buy and sell anything safely without the risk of chargebacks. Truly secure payments.',
        image: ImageConstant.onBoardingPic2,
      ),
      OnBoardingPage1(
        title: "Title Three",
        text: 'Infinite Escrow empowers you to redefine trust and security, ensuring your transactions are conducted with utmost confidence.',
        image: ImageConstant.onBoardingPic3,
      ),
    ];
}