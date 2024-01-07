import 'package:infinite_escrow/routes/routes.dart';

navigateToOffAllNextPage(Widget page) {
  Get.offAll(() => page,
      duration: Duration(milliseconds: 400),
      transition: Transition.rightToLeft);
}

navigateToPage(Widget page) {
  Get.to(page,
      duration: Duration(milliseconds: 400),
      transition: Transition.rightToLeft);
}
