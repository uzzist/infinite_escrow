import 'package:infinite_escrow/routes/routes.dart';

Future<dynamic> customBottomSheet(
  BuildContext context,
  final String title,
) {
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      )),
      isScrollControlled: true,
      backgroundColor: ColorConstant.white,
      context: context,
      builder: (context) {
        return Container(
          height: 550,
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: ColorConstant.black),
              ),
              SizedBox(height: 20),
              Text(
                "What information do we collect?",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: ColorConstant.black),
              ),
              SizedBox(height: 20),
              Text(
                "We gather data from you when you register on our site, submit a request, buy any services, react to an overview, or round out a structure. At the point when requesting any assistance or enrolling on our site, as suitable, you might be approached to enter your: name, email address, or telephone number. You may, nonetheless, visit our site anonymously.",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: ColorConstant.darkestGrey),
              ),
              SizedBox(height: 20),
              Text(
                "How do we protect your information?",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: ColorConstant.black),
              ),
              SizedBox(height: 20),
              Text(
                "All provided delicate/credit data is sent through Stripe.After an exchange, your private data (credit cards, social security numbers, financials, and so on) won't be put away on our workers.",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: ColorConstant.darkestGrey),
              ),
              SizedBox(height: 20),
              Text(
                "Do we disclose any information to outside parties?",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: ColorConstant.black),
              ),
              SizedBox(height: 20),
              Text(
                "We don't sell, exchange, or in any case move to outside gatherings by and by recognizable data. This does exclude confided in outsiders who help us in working our site, leading our business, or adjusting you, since those gatherings consent to keep this data private. We may likewise deliver your data when we accept discharge is suitable to follow the law, implement our site strategies, or ensure our own or others' rights, property, or wellbeing.",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: ColorConstant.darkestGrey),
              ),
            ],
          ),
        );
      });
}
