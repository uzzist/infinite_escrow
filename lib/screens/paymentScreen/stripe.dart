import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinite_escrow/routes/routes.dart';

import '../../core/messages.dart';

class StripePaymentScreen extends StatefulWidget {
  const StripePaymentScreen({Key? key}) : super(key: key);

  @override
  State<StripePaymentScreen> createState() => _StripePaymentScreenState();
}

class _StripePaymentScreenState extends State<StripePaymentScreen> {

  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Stripe'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            customTextField(hintText: 'Name on card', prefixIcon: ''),
            TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CardNumberFormatter(),
              ],
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,

              decoration: InputDecoration(
                counterText: "",
                hintText: 'Valid Card Number',
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
              maxLength: 19,
              onChanged: (value) {},
            ),
            TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                MonthYearInputFormatter()
              ],
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,

              decoration: InputDecoration(
                counterText: "",
                hintText: 'MM / YYYY',
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
              maxLength: 19,
              onChanged: (value) {},
            ),
            TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,

              decoration: InputDecoration(
                counterText: "",
                hintText: 'CVC',
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
              maxLength: 3,
              onChanged: (value) {},
            ),
        Container(
          height: 56,
          width: double.infinity,
          decoration: BoxDecoration(color: ColorConstant.lightGreen),
          child: TextButton(
              onPressed: loading
                  ? () {}
                  : () {
                  // var http = HttpRequest();
                  // setState(() {
                  //   loading = true;
                  // });
              },
              child: loading
                  ? CircularProgressIndicator(
                color: Colors.white,
              )
                  : Text("PAY NOW",
                  style: TextStyle(
                      color: ColorConstant.midNight,
                      fontSize: 17,
                      fontFamily: FontConstant.jakartaBold,
                      fontWeight: FontWeight.w700)))

        )],
        ),
      ),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue previousValue,
      TextEditingValue nextValue,
      ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}

class MonthYearInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Get the current text and selection
    String newText = newValue.text;
    int selectionIndex = newValue.selection.end;

    // Remove any non-numeric characters
    String cleanedText = newText.replaceAll(RegExp(r'[^0-9]'), '');

    // If the cleaned text is empty, return an empty string
    if (cleanedText.isEmpty) {
      return TextEditingValue.empty;
    }

    // Insert a '/' between MM and YYYY if the length is greater than 2
    if (cleanedText.length > 2) {
      cleanedText = cleanedText.substring(0, 2) + '/' + cleanedText.substring(2);
    }

    // Update the selection index based on the formatted text
    selectionIndex += (cleanedText.length - newText.length);

    // Limit the total length to 7 characters (MM/YYYY)
    if (cleanedText.length > 7) {
      cleanedText = cleanedText.substring(0, 7);
      selectionIndex = 7;
    }

    // Return the formatted text and updated selection index
    return TextEditingValue(
      text: cleanedText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
