import 'package:infinite_escrow/routes/routes.dart';

AppBar customAppBar(
    {bool isIconShow = true,
    String? title,
    Widget? svgTitle,
    List<Widget>? actions,
      Color? titleColor,
    Color? backgroundColor, Color? iconColor,
    bool isActionsShow = false}) {
  return AppBar(
    backgroundColor: backgroundColor ?? ColorConstant.white,
    elevation: 0,
    leading: isIconShow
        ? IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: iconColor ?? ColorConstant.black,
            ))
        : SizedBox(),
    centerTitle: true,
    title: svgTitle ??
        Text(
          title!,
          style: TextStyle(
              color: titleColor ?? ColorConstant.black,
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
    actions: isActionsShow ? actions : null,
  );
}
