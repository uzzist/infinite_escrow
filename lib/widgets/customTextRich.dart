
import 'package:infinite_escrow/routes/routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/messages.dart';
Text customTextRich(BuildContext context) {
  return Text.rich(
    TextSpan(
        text: "By registering, you approve that you are agree with",
        style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontSize: 12,
            fontFamily: FontConstant.jakartaSemiBold,
            fontWeight: FontWeight.w500),
        children: [
          TextSpan(
              text: " Privacy Policy",
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  final Uri url = Uri.parse('https://infiniteescrow.com/policy/42/privacy-policy');
                  if (!await launchUrl(
                  url,
                  )) {
                  SnackBarMessage.errorSnackbar(
                  context, 'Something went Wrong!');
                  }
                },
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  fontFamily: FontConstant.jakartaSemiBold,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: " , ",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 12,
                  fontFamily: FontConstant.jakartaSemiBold,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: " Terms of Service",
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  final Uri url = Uri.parse('https://infiniteescrow.com/policy/43/terms-of-service');
                  if (!await launchUrl(
                    url,
                  )) {
                    SnackBarMessage.errorSnackbar(
                        context, 'Something went Wrong!');
                  }
                },
              style: TextStyle(
                  color:Theme.of(context).colorScheme.tertiary,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  fontFamily: FontConstant.jakartaSemiBold,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: " , ",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 12,
                  fontFamily: FontConstant.jakartaSemiBold,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: " Payment Policy",
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  final Uri url = Uri.parse('https://infiniteescrow.com/policy/94/payment-policy');
                  if (!await launchUrl(
                    url,
                  )) {
                    SnackBarMessage.errorSnackbar(
                        context, 'Something went Wrong!');
                  }
                },
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  fontFamily: FontConstant.jakartaSemiBold,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: " , ",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 12,
                  fontFamily: FontConstant.jakartaSemiBold,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: "  Company Rules",
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  final Uri url = Uri.parse('https://infiniteescrow.com/policy/95/company-rules');
                  if (!await launchUrl(
                    url,
                  )) {
                    SnackBarMessage.errorSnackbar(
                        context, 'Something went Wrong!');
                  }
                },
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  fontFamily: FontConstant.jakartaSemiBold,
                  fontWeight: FontWeight.w500))
        ]),
  );
}
