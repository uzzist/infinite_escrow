
import 'package:infinite_escrow/routes/routes.dart';

class BottomNavigationController extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }



  final iconName = [
    "Dashboard",
    "Profile",
    "Notifications",
    "Transaction",
  ];

  final iconList = <IconData>[
    Icons.dashboard,
    Icons.person_outline,
    Icons.notifications_outlined,
    Icons.list,
  ];
}
