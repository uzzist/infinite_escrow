import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:infinite_escrow/routes/routes.dart';
import 'package:infinite_escrow/screens/notificationScreen/blogpost_screen.dart';
import '../models/blog_model.dart';
import 'package:timeago/timeago.dart' as timeago;

InkWell customNotificationContainer({required BlogModel model, required BuildContext context
}) {
  LineSplitter ls = new LineSplitter();
  List<String> _masForUsing = ls.convert(model.descriptionNic);
  RegExp exp = RegExp(r"<[^>]*>",multiLine: true,caseSensitive: true);
  String parsedstring1 = (_masForUsing.length> 1? _masForUsing[0]+_masForUsing[1]: _masForUsing.first).replaceAll(exp, '');
  return InkWell(
    onTap: () {
      navigateToPage(BlogPostScreen(model: model));
    },
    child: Container(
      width: double.infinity,
      height: 120,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.grey.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
              height: 96,
              width: 96,
              child: Image.network(
                model.image,
                fit: BoxFit.scaleDown,
              )),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: TextStyle(
                        color: ColorConstant.midNight,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      parsedstring1,
                      maxLines: 2,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: ColorConstant.darkestGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
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
            ],
          )
        ],
      ),
    ),
  );
}
