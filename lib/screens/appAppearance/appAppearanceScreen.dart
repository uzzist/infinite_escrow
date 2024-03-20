import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_escrow/constants/color_constant.dart';
import 'package:infinite_escrow/routes/routes.dart';
import 'package:infinite_escrow/screens/appAppearance/controller/theme_controller.dart';
import 'package:infinite_escrow/themes/dark_theme.dart';
import 'package:infinite_escrow/themes/light_theme.dart';

import '../../widgets/customAppBar.dart';

class AppAppearanceScreen extends StatelessWidget {
  AppAppearanceScreen({Key? key}) : super(key: key);

  final ThemeController _themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: "App Appearance",
          iconColor: Theme.of(context).colorScheme.tertiary,
          titleColor: Theme.of(context).colorScheme.tertiary,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              _themeController.changeToLightTheme();
              Get.changeTheme(lightTheme);
            },
            child: Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 12),
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstant.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 14,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Always light', style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                  ),),
                  Obx(()
                  => _themeController.darkMode.value == false ?  Icon(Icons.check, color: ColorConstant.lightGreen2) : SizedBox.shrink())
                ],
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              _themeController.changeToDarkTheme();
              Get.changeTheme(darkTheme);
            },
            child: Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 12),
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstant.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 14,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Always Dark', style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),),
                  Obx(()
                      => _themeController.darkMode.value ?  Icon(Icons.check, color: ColorConstant.lightGreen2) : SizedBox.shrink())
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
