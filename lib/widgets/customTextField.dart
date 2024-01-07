import 'package:infinite_escrow/routes/routes.dart';

TextFormField customTextField(
    {required String hintText,
    required String prefixIcon,
    final String? suffixIcon,
    final String? value,
    final readonly = false,
    final Function? onChange,
    final void Function()? onSuffixTap,
    final bool obsecure = false}) {
  return TextFormField(
    onChanged: (value) {
      if (onChange != null) {
        onChange(value);
      }
    },
    obscureText: obsecure,
    readOnly: readonly,
    initialValue: value ?? '',
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
          color: ColorConstant.darkestGrey,
          fontSize: 14,
          fontFamily: FontConstant.jakartaMedium,
          fontWeight: FontWeight.w500),
      prefixIcon: SvgPicture.asset(
        prefixIcon,
        fit: BoxFit.scaleDown,
      ),
      suffixIcon: suffixIcon == null
          ? null
          : InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: onSuffixTap,
              child: SvgPicture.asset(
                suffixIcon,
                fit: BoxFit.scaleDown,
              ),
            ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide(
          color: ColorConstant.grey,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide(
          color: ColorConstant.grey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide(
          color: ColorConstant.grey,
        ),
      ),
    ),
  );
}

TextField customTextFieldWithoutIcon({
  required String hintText,
  final int maxlines = 1,
  TextInputType? keyboardType,
  required Function onChange,
}) {
  return TextField(
    maxLines: maxlines,
    keyboardType: keyboardType,
    onChanged: (e) {
      onChange(e);
    },
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
          color: ColorConstant.darkestGrey,
          fontSize: 14,
          fontFamily: FontConstant.jakartaMedium,
          fontWeight: FontWeight.w500),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide(
          color: ColorConstant.grey,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide(
          color: ColorConstant.grey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide(
          color: ColorConstant.grey,
        ),
      ),
    ),
  );
}
