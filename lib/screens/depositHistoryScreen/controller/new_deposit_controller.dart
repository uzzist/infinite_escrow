import 'package:infinite_escrow/routes/routes.dart';

class NewDepositController extends GetxController {
  RxString dropdownvalue = 'Select Gateway'.obs;
  RxString currency = 'NGN'.obs;
  double value =0;

  // List of items in our dropdown menu
  var items = [
    'Select Gateway',
    'Item 2',
    'Item 3',
  ];
}
