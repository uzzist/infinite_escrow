import 'package:infinite_escrow/routes/routes.dart';

Widget customNewEscrowContainer(
    {required RxBool isActive,
      required BuildContext context,
    required void Function()? onPressed,
    required String title}) {
  return Container(
    height: 56,
    width: 160,
    decoration: BoxDecoration(
      color: isActive.value ? ColorConstant.lightGreen : Colors.transparent,
      border: isActive.value
          ? Border.all(
              color: ColorConstant.lightGreen,
            )
          : Border.all(
              color: Theme.of(context).colorScheme.outline,
            ),
    ),
    child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isActive.value
                ? SvgPicture.asset(ImageConstant.checkRight)
                : SvgPicture.asset(ImageConstant.circle, color: Theme.of(context).colorScheme.secondary),
            SizedBox(width: 10),
            Text(title,
                style: TextStyle(
                    color: isActive.value ? ColorConstant.midNight : Theme.of(context).colorScheme.secondary,
                    fontSize: 14,
                    fontFamily: FontConstant.jakartaBold,
                    fontWeight: FontWeight.w700)),
          ],
        )),
  );
}
