import 'package:infinite_escrow/routes/routes.dart';

class NewEscrowController extends GetxController {
  RxString coin = "Naira".obs;
  RxString type = "1".obs;
  String value = '';
  RxBool isSeller = true.obs;
  RxBool isBuyer = false.obs;
}
