import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/routes/routes.dart';
import 'package:infinite_escrow/screens/notificationScreen/widgets/customNotificationContainer.dart';

import 'models/blog_model.dart';

class NotificationScreen extends StatefulWidget {
  final bool isIconShow;
  const NotificationScreen({super.key, this.isIconShow = true});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<BlogModel> list = [];
  bool loading = false;
  @override
  void initState() {
    super.initState();
    var http = HttpRequest();
    setState(() {
      loading = true;
    });
    http.getBlogs().then((value) {
      setState(() {
        loading = true;
      });
      if (value.success == true) {
        setState(() {
          list = BlogModel.fromJsonList(value.data['data']['data']);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        isIconShow: widget.isIconShow,
        title: "Notifications",
        titleColor: Theme.of(context).colorScheme.tertiary,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor
      ),
      body: list.isEmpty
          ? Center(
              child: loading
                  ? CircularProgressIndicator(
                      color: ColorConstant.darkestGrey,
                    )
                  : Image.asset(
                      ImageConstant.noBlog,
                      width: 132,
                    ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i in list)
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: customNotificationContainer(model: i),
                      )
                  ],
                ),
              ),
            ),
    );
  }
}
