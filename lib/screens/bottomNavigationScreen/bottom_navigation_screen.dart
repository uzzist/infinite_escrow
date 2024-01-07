import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/core/messages.dart';

import 'package:infinite_escrow/routes/routes.dart';
import 'package:provider/provider.dart';

import '../../core/state/base_State.dart';

class BottomNavigationScreen extends StatelessWidget {
  BottomNavigationScreen({super.key});

  buildBottomNavigationMenu(context, controller) {
    return Obx(
      () => AnimatedBottomNavigationBar.builder(
        itemCount: controller.iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? ColorConstant.white : ColorConstant.grey;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                controller.iconList[index],
                size: 24,
                color: color,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                controller.iconName[index],
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                ),
              ),
            ],
          );
        },
        backgroundColor: ColorConstant.black,
        activeIndex: controller.tabIndex.value,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.defaultEdge,
        onTap: controller.changeTabIndex,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationController controller =
        Get.put(BottomNavigationController(), permanent: false);
    return ListenableProvider<BaseState>(
      create: (_)=> BaseState(),
      child: SafeArea(
          child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            var http = HttpRequest();
            http.getUser().then((value){
              if(value.address.address != '' && value.address.city != '' && value.address.state != ''){
                navigateToPage(NewEscrowScreen());
              }else {
                SnackBarMessage.errorSnackbar(context, "Please fill in all information in the profile");
              }
            });
          },
          backgroundColor: ColorConstant.lightGreen,
          child: SvgPicture.asset(ImageConstant.plus),
        ),
        bottomNavigationBar: buildBottomNavigationMenu(context, controller),
        body: Obx(() => IndexedStack(
              clipBehavior: Clip.none,
              index: controller.tabIndex.value ?? 0,
              children: [
                DashboardScreen(),
                ProfileSetting(
                  isIconShow: false,
                ),
                NotificationScreen(
                  isIconShow: false,
                ),
                TransactionScreen(isIconShow: false)
              ],
            )),
      )),
    );
  }
}
