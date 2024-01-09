import 'package:infinite_escrow/routes/routes.dart';

class NewEscrowController extends GetxController {
  RxString coin = "Naira".obs;
  RxString type = ''.obs;
  String value = '';
  String charge = '';
  RxBool isSeller = true.obs;
  RxBool isBuyer = false.obs;
}
