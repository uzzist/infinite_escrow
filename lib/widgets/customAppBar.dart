import 'package:infinite_escrow/routes/routes.dart';

AppBar customAppBar(
    {bool isIconShow = true,
    String? title,
    Widget? svgTitle,
    List<Widget>? actions,
    Color? backgroundColor,
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
              color: ColorConstant.black,
            ))
        : SizedBox(),
    centerTitle: true,
    title: svgTitle ??
        Text(
          title!,
          style: TextStyle(
              color: ColorConstant.black,
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
    actions: isActionsShow ? actions : null,
  );
}
