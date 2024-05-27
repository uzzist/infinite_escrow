import 'package:flutter/material.dart';
import 'package:infinite_escrow/routes/routes.dart';
import 'package:rive/rive.dart';

import '../widgets/typographic.dart';

class SnackBarMessage {
  static void errorSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Container(
        decoration: BoxDecoration(
            color: HexColor('#FBEAE9'),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10.0,
                  offset: const Offset(0, 4))
            ]),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: HexColor('#DB3329'),
              size: 24,
            ),
            const SizedBox(
              width: 16,
            ),
            Flexible(
              child: AppTypography(
                text: message,
                size: 14,
                weight: FontWeight.w500,
                color: HexColor('#333333'),
              ),
            )
          ],
        ),
      ),
      backgroundColor: (Colors.transparent),
      shape: Border(
        bottom: BorderSide(color: HexColor('#DB3329'), width: 5),
      ),
      margin: const EdgeInsets.only(bottom: 16, left: 20, right: 20),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 4),
      padding: const EdgeInsets.all(0),
      elevation: 0,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void successSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Container(
        decoration: BoxDecoration(
            color: HexColor('#ECF8ED'),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10.0,
                  offset: const Offset(0, 4))
            ]),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(
              Icons.task_alt_outlined,
              color: HexColor('#2E7D32'),
              size: 24,
            ),
            const SizedBox(
              width: 16,
            ),
            AppTypography(
                text: message,
                size: 14,
                weight: FontWeight.w500,
                color: HexColor('#333333'))
          ],
        ),
      ),
      backgroundColor: (Colors.transparent),
      shape: Border(
        bottom: BorderSide(color: HexColor('#2E7D32'), width: 5),
      ),
      margin: const EdgeInsets.only(bottom: 16, left: 20, right: 20),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 4),
      padding: const EdgeInsets.all(0),
      elevation: 0,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void waringSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Container(
        decoration: BoxDecoration(
            color: HexColor('#FFFAE6'),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10.0,
                  offset: const Offset(0, 4))
            ]),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(
              Icons.warning_amber_outlined,
              color: HexColor('#FFAB00'),
              size: 24,
            ),
            const SizedBox(
              width: 16,
            ),
            AppTypography(
              text: message,
              size: 14,
              weight: FontWeight.w500,
              color: HexColor('#333333'),
            )
          ],
        ),
      ),
      backgroundColor: (Colors.transparent),
      shape: Border(
        bottom: BorderSide(color: HexColor('#FFAB00'), width: 5),
      ),
      margin: const EdgeInsets.only(bottom: 16, left: 20, right: 20),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 4),
      padding: const EdgeInsets.all(0),
      elevation: 0,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showLoading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            child: Container(
              height: 250,
              child: RiveAnimation.asset(ImageConstant.loadingAnimation),
            ),
          );
        });
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
