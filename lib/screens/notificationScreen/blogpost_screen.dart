import 'package:infinite_escrow/routes/routes.dart';
import 'package:infinite_escrow/screens/notificationScreen/widgets/customNotificationContainer.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'models/blog_model.dart';

class BlogPostScreen extends StatelessWidget {
  BlogModel model;
  BlogPostScreen({super.key, required  this.model});
  @override
  Widget build(BuildContext context) {
    RegExp exp = RegExp(r"<[^>]*>",multiLine: true,caseSensitive: true);
    String parsedstring1 = (model.descriptionNic??'').replaceAll(exp, '');
    return Scaffold(
      appBar: customAppBar(title: "Blog posts"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(model.image),
              SizedBox(
                height: 15,
              ),
              Text(
                model.title,
                style: TextStyle(
                    color: ColorConstant.midNight,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(Icons.access_time,
                      color: ColorConstant.darkestGrey, size: 12),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                      timeago.format(model.createdAt),
                    style: TextStyle(
                        color: ColorConstant.darkestGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                parsedstring1,
                style: TextStyle(
                    color: ColorConstant.darkestGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              Row(
                children: [
                  Icon(Icons.access_time,
                      color: ColorConstant.darkestGrey, size: 12),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    timeago.format(model.createdAt),
                    style: TextStyle(
                        color: ColorConstant.darkestGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // Text(
              //   "Similar posts",
              //   style: TextStyle(
              //       color: ColorConstant.midNight,
              //       fontSize: 15,
              //       fontWeight: FontWeight.w500),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // customNotificationContainer(
              //   image: ImageConstant.contract3,
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // customNotificationContainer(
              //   image: ImageConstant.contract4,
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // customNotificationContainer(
              //   image: ImageConstant.contract5,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
