import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  RxBool darkMode = false.obs; // Observable to track dark mode state

  void changeToLightTheme() {
    darkMode.value = false; // Toggle dark mode state
    GetStorage().write('darkMode', darkMode.value); // Save the mode to local storage
  }

  void changeToDarkTheme () {
    darkMode.value = true; // Toggle dark mode state
    GetStorage().write('darkMode', darkMode.value);
  }

  @override
  void onInit() {
    // Initialize theme from local storage
    darkMode.value = GetStorage().read('darkMode') ?? false;
    super.onInit();
  }
}