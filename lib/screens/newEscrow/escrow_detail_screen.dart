import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/routes/routes.dart';
import 'package:infinite_escrow/screens/newEscrow/models/escrow_detail.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../core/messages.dart';
import '../../core/models/profile.dart';

class EscrowDetailScreen extends StatefulWidget {
  int id;
  EscrowDetailScreen({super.key, required int this.id});

  @override
  State<EscrowDetailScreen> createState() => _EscrowDetailScreenState();
}

class _EscrowDetailScreenState extends State<EscrowDetailScreen> {
  EscrowDetail? model;
  ProfileModel? profile;
  File? attachment;
  String message = '';
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SnackBarMessage.showLoading(context);
      getData();
    });
  }

  getData() async {
    var http = HttpRequest();
    var data = http.getUser().then((value) => {
      profile = value
    });
    http.getEscrowDetail(widget.id).then((value) {
      Navigator.pop(context);
      if (value.success == true) {
        setState(() {
          model = EscrowDetail.fromJson(
            value.data['data']['escrows'],
            value.data['data'],
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: customAppBar(
          title: "Escrow details",
          isActionsShow: true,
          actions: [
            model?.status == 1 || model?.status == 9
                ? Container()
                : TextButton(
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
                          height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: ColorConstant.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Confirmation!",
                                style: TextStyle(
                                    color: ColorConstant.midNight,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              SvgPicture.asset(ImageConstant.cancelEscrow),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 163.5,
                                    height: 56,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ColorConstant.black,
                                            width: 2)),
                                    child: TextButton(
                                        onPressed: () {
                                          if (model?.status != 2) {
                                            SnackBarMessage.errorSnackbar(
                                                context,
                                                'You can not cancel this escrow');
                                            return;
                                          }
                                          Get.back();
                                          var http = HttpRequest();
                                          SnackBarMessage.showLoading(context);
                                          http
                                              .cancelEscrow(model?.id ?? 0)
                                              .then((value) {
                                            if (value.success) {
                                              getData();
                                            } else {
                                              SnackBarMessage.errorSnackbar(
                                                  context,
                                                  'something went wrong please try again');
                                            }
                                          });
                                        },
                                        child: Text(
                                          "Yes, I’m sure",
                                          style: TextStyle(
                                              color: ColorConstant.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        )),
                                  ),
                                  Container(
                                    width: 163.5,
                                    height: 56,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ColorConstant.black,
                                            width: 2)),
                                    child: TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text(
                                          "No, Go back",
                                          style: TextStyle(
                                              color: ColorConstant.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        )),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          "Cancel",
                          style: TextStyle(
                              color: ColorConstant.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        SvgPicture.asset(ImageConstant.close),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    )),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(color: ColorConstant.white, boxShadow: [
                    BoxShadow(
                      color: ColorConstant.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 14,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            model?.title ?? '',
                            style: TextStyle(
                                color: ColorConstant.midNight,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            height: 24,
                            decoration: BoxDecoration(
                                color: model?.getStatusColor() ??
                                    Color(0xffFFDEDE)),
                            child: Center(
                              child: Text(
                                model?.getStatusString() ?? '',
                                style: TextStyle(
                                    color: ColorConstant.midNight,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "I’m Selling to",
                            style: TextStyle(
                                color: ColorConstant.darkestGrey,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            model?.buyerName ?? '',
                            style: TextStyle(
                                color: ColorConstant.midNight,
                                fontSize: 13,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      customRow(
                          title: "Amount",
                          amount: model?.amount ?? 0,
                          currency: model?.currency ?? ''),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Charge",
                            style: TextStyle(
                                color: ColorConstant.darkestGrey,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: [
                              Text(
                                ((model?.buyerCharge ?? 0) +
                                        (model?.sellerCharge ?? 0))
                                    .toString(),
                                style: TextStyle(
                                    color: ColorConstant.midNight,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                model?.currency ?? '',
                                style: TextStyle(
                                    color: ColorConstant.darkestGrey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "By",
                                style: TextStyle(
                                    color: ColorConstant.darkestGrey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                height: 24,
                                color: Color(0xffE0EDFF),
                                child: Center(
                                  child: Text(
                                    model?.getPayerString() ?? '',
                                    style: TextStyle(
                                        color: ColorConstant.midNight,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Status",
                            style: TextStyle(
                                color: ColorConstant.darkestGrey,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            height: 24,
                            color: model?.getStatusColor() ?? Color(0xffFFDEDE),
                            child: Center(
                              child: Text(
                                model?.getStatusString() ?? '',
                                style: TextStyle(
                                    color: ColorConstant.midNight,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      customRow(
                        title: "Created Milestone",
                        amount:
                            (model?.amount ?? 0) + (model?.buyerCharge ?? 0),
                        currency: model?.currency ?? '',
                      ),
                      SizedBox(height: 10),
                      customRow(
                        title: "Milestone Funded",
                        amount: model?.milestoneFunded ?? 0,
                        currency: model?.currency ?? '',
                      ),
                      SizedBox(height: 10),
                      customRow(
                        title: "Milestone Unfunded",
                        amount: model?.milestoneUnfunded ?? 0,
                        currency: model?.currency ?? '',
                      ),
                      SizedBox(height: 10),
                      customRow(
                        title: "Rest Amount",
                        amount: model?.restAmount ?? 0,
                        currency: model?.currency ?? '',
                      ),
                      SizedBox(height: 10),
                      (model?.disputerId ?? 0) > 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Disputed by",
                                  style: TextStyle(
                                      color: ColorConstant.darkestGrey,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  model?.disputeName ?? '',
                                  style: TextStyle(
                                      color: ColorConstant.midNight,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            )
                          : SizedBox(),
                      model?.status == 0 ||
                              model?.status == 1 ||
                              model?.status == 9 ||
                              model?.status == 2
                          ? Container()
                          : SizedBox(height: 20),
                      model?.status == 0 ||
                              model?.status == 1 ||
                              model?.status == 9 ||
                              model?.status == 2
                          ? Container()
                          : Divider(),
                      model?.status == 0 ||
                              model?.status == 1 ||
                              model?.status == 9 ||
                              model?.status == 2
                          ? Container()
                          : SizedBox(height: 20),
                      model?.status == 0 ||
                              model?.status == 1 ||
                              model?.status == 9 ||
                              model?.status == 2
                          ? Container()
                          : Text(
                              "Dispute reason :",
                              style: TextStyle(
                                  color: ColorConstant.darkestGrey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                      model?.status == 0 ||
                              model?.status == 1 ||
                              model?.status == 9 ||
                              model?.status == 2
                          ? Container()
                          : TextField(
                              readOnly: model?.status == 8,
                              onSubmitted: model?.status == 8
                                  ? (e) {}
                                  : (e) {
                                      if (e == '') {
                                        SnackBarMessage.errorSnackbar(
                                            context, 'Message Required');
                                      }
                                      if (model?.status != 2) {
                                        SnackBarMessage.errorSnackbar(context,
                                            'You can not dispute this escrow');
                                        return;
                                      }
                                      var http = HttpRequest();
                                      SnackBarMessage.showLoading(context);
                                      http
                                          .disputeEscrow(model?.id ?? 0, e)
                                          .then((value) {
                                        if (value.success) {
                                          getData();
                                        } else {
                                          SnackBarMessage.errorSnackbar(context,
                                              'something went wrong please try again');
                                        }
                                      });
                                    },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: model?.status == 8
                                      ? model?.disputeNote
                                      : "Reason of dispute would write here or some attachment...",
                                  hintStyle: TextStyle(
                                      color: ColorConstant.midNight,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500)),
                            ),
                      model?.status != 2
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: Get.width * 0.4,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Color(0xffE7F6EB),
                                    border: Border.all(
                                        color: Color(0xff0E642B), width: 2),
                                  ),
                                  child: TextButton(
                                      onPressed: () {
                                        navigateToPage(NewMileStoneScreen(
                                            id: model?.id ?? 0));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.save_outlined,
                                            color: Color(0xff0E642B),
                                            size: 15,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Fund Escrow",
                                            style: TextStyle(
                                                color: Color(0xff0E642B),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      )),
                                ),
                                Container(
                                  width: Get.width * 0.4,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Color(0xffFFF4F4),
                                    border: Border.all(
                                        color: Color(0xffE73A3A), width: 2),
                                  ),
                                  child: TextButton(
                                      onPressed: () {
                                        navigateToPage(
                                            TickerSellerInfoScreen());
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Dispute",
                                            style: TextStyle(
                                                color: Color(0xffE73A3A),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.privacy_tip_outlined,
                                            color: Color(0xffE73A3A),
                                            size: 15,
                                          ),
                                        ],
                                      )),
                                )
                              ],
                            )
                    ],
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: model?.messages.length ?? 0,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          model?.messages[index].senderId != profile?.id
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ChatBubble(
                                      clipper: ChatBubbleClipper1(
                                          type: BubbleType.receiverBubble),
                                      backGroundColor: Color(0xffE7F6EB),
                                      margin: EdgeInsets.only(top: 20),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              model?.messages[index]
                                                      .senderName ??
                                                  '',
                                              style: TextStyle(
                                                  color: ColorConstant.midNight,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              model?.messages[index].message ??
                                                  '',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        model?.messages[index] != null
                                            ? timeago.format(model
                                                    ?.messages[index]
                                                    .createdAt ??
                                                DateTime.now())
                                            : '',
                                        style: TextStyle(
                                            color: ColorConstant.darkestGrey,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                      ),
                                    )
                                  ],
                                )
                              : SizedBox(),
                          model?.messages[index].senderId == profile?.id
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ChatBubble(
                                      clipper: ChatBubbleClipper1(
                                          type: BubbleType.sendBubble),
                                      alignment: Alignment.topRight,
                                      margin: EdgeInsets.only(top: 20),
                                      backGroundColor: Color(0xffF2F6F7),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "You",
                                              style: TextStyle(
                                                  color: ColorConstant.midNight,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              model?.messages[index].message ??
                                                  '',
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.midNight),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: Get.width * 0.2),
                                      child: Text(
                                        model?.messages[index] != null
                                            ? timeago.format(model
                                                    ?.messages[index]
                                                    .createdAt ??
                                                DateTime.now())
                                            : '',
                                        style: TextStyle(
                                            color: ColorConstant.darkestGrey,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                      ),
                                    )
                                  ],
                                )
                              : SizedBox(),
                        ],
                      );
                    }),
                attachment == null
                    ? SizedBox()
                    : Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: attachment?.path.split('/').last ?? '',
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: ColorConstant.midNight,
                                    fontSize: 14,
                                    fontFamily: FontConstant.jakartaMedium,
                                    fontWeight: FontWeight.w500),
                                children: [
                                  TextSpan(
                                    text:
                                        " (${(attachment?.lengthSync() ?? 1) / 1000} KB)",
                                    style: TextStyle(
                                        color: ColorConstant.darkestGrey,
                                        fontSize: 14,
                                        fontFamily: FontConstant.jakartaMedium,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  attachment = null;
                                });
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(ImageConstant.redError),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Remove",
                                    style: TextStyle(
                                        color: Color(0xffE73A3A),
                                        fontSize: 14,
                                        fontFamily: FontConstant.jakartaMedium,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                Divider(),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: controller,
                    onChanged: (e) {
                      message = e;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type your message...",
                        prefixIcon: InkWell(
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
                            if (result != null) {
                              setState(() {
                                attachment =
                                    File(result.files.single.path ?? '');
                              });
                            }
                          },
                          child: SvgPicture.asset(
                            ImageConstant.attachments,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        suffixIcon: InkWell(
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: () {
                            if (model?.status == 9) {
                              SnackBarMessage.errorSnackbar(context,
                                  'You can not replay to this conversation');
                              return;
                            }
                            if (message == '') {
                              SnackBarMessage.errorSnackbar(
                                  context, 'Message Required');
                              return;
                            }
                            var http = HttpRequest();
                            var data = {
                              'conversation_id':
                                  model?.conversationId.toString() ?? '',
                              'message': message,
                            };
                            if (attachment != null) {
                              data['file'] = (attachment as File).path;
                            }
                            SnackBarMessage.showLoading(context);
                            http.message(data).then((value) {
                              if (value.success) {
                                message = '';
                                controller.clear();
                                attachment = null;
                                getData();
                              } else {
                                SnackBarMessage.errorSnackbar(
                                    context, value.message);
                              }
                            });
                          },
                          child: SvgPicture.asset(
                            ImageConstant.send,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        hintStyle: TextStyle(
                            color: ColorConstant.midNight,
                            fontSize: 13,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
