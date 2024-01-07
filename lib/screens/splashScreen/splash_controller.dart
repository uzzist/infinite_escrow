

import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/routes/routes.dart';


class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(Duration(seconds: 5), () async {
      var http = HttpRequest();
      var data = await http.getOnBoard();
      if( data != true ){
        navigateToOffAllNextPage(OnBoardingScreen());
      }else{
        navigateToOffAllNextPage(LoginScreen());
      }
    });
  }
}
