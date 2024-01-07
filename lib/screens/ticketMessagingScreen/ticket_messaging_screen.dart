import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/routes/routes.dart';
import 'package:infinite_escrow/screens/ticketMessagingScreen/models/messageModel.dart';
import '../../core/messages.dart';
import '../../core/models/profile.dart';
import '../ticketwithdrawlog/models/ticket_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class TicketMessagingScreen extends StatefulWidget {
  late int id;
  TicketMessagingScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<TicketMessagingScreen> createState() => _TicketMessagingScreenState();
}

class _TicketMessagingScreenState extends State<TicketMessagingScreen> {
  File? attachment;
  bool loading = false;
  TicketsModel? model;
  ProfileModel? profile;
  String message = '';
  List<MessagesModel> list = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    getData();
  }
  getData(){
    var http = HttpRequest();
    http.getTicketById(widget.id).then((value) {
       http.getUser().then((value) => {
        profile = value
       });
      setState(() {
        loading = false;
      });
      if (value.success == true) {
        setState(() {
          model = TicketsModel.fromJsonSingle(value.data['data']['my_ticket']);
          list = MessagesModel.fromJson(value.data['data']['messages']);
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        svgTitle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "|",
              style: TextStyle(
                  color: Color(0xffFF5732),
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Ticket # ${model?.ticket ?? ''}",
              style: TextStyle(
                  color: ColorConstant.darkestGrey,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        isActionsShow: true,
        actions: [
          InkWell(
              onTap: () {
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
                        SvgPicture.asset(ImageConstant.tickerClose),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 163.5,
                              height: 56,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorConstant.black, width: 2)),
                              child: TextButton(
                                  onPressed: () {
                                    if(model?.status == 3){
                                      SnackBarMessage.errorSnackbar(context, 'You can not replay to this conversation');
                                      return;
                                    }
                                    var http = HttpRequest();
                                    Get.back();
                                    var data = { 'replayTicket': '2'};
                                    SnackBarMessage.showLoading(context);
                                    http.ticketMessage(data, model?.id ?? 0).then((value) {
                                      Navigator.pop(context);
                                      if(value.success){
                                        getData();
                                      }else{
                                        SnackBarMessage.errorSnackbar(context, value.message);
                                      }
                                    });
                                  },
                                  child: Text(
                                    "Yes, Close it",
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
                                      color: ColorConstant.black, width: 2)),
                              child: TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    "No, Cancel",
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
              child: SvgPicture.asset(ImageConstant.close)),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    model?.subject?? '',
                    style: TextStyle(
                        color: ColorConstant.midNight,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                  Container(
                    width: 101,
                    height: 24,
                    color: model?.getStatusColor() ?? Color(0xffE0EDFF),
                    child: Center(
                      child: Text(
                        model?.getStatusString()?? '',
                        style: TextStyle(
                            color: ColorConstant.midNight,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    color: ColorConstant.darkestGrey,
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    timeago.format(model?.lastReply ?? DateTime.now()),
                    style: TextStyle(
                        color: ColorConstant.darkestGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              loading ? Center( child: Padding(padding: EdgeInsets.only(top: 10),
              child: CircularProgressIndicator(),
              ), ): ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  primary: false,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ChatBubble(
                              clipper: ChatBubbleClipper1(
                                  type: BubbleType.receiverBubble),
                              backGroundColor: Color(0xffE7F6EB),
                              margin: EdgeInsets.only(top: 20),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.7,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      profile?.username ?? '',
                                      style: TextStyle(
                                          color: ColorConstant.midNight,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      list[index].message,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                timeago.format(list[index].createdAt),
                                style: TextStyle(
                                    color: ColorConstant.darkestGrey,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12),
                              ),
                            )
                          ],
                        ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     ChatBubble(
                        //       clipper: ChatBubbleClipper1(
                        //           type: BubbleType.sendBubble),
                        //       alignment: Alignment.topRight,
                        //       margin: EdgeInsets.only(top: 20),
                        //       backGroundColor: Color(0xffF2F6F7),
                        //       child: Container(
                        //         constraints: BoxConstraints(
                        //           maxWidth:
                        //               MediaQuery.of(context).size.width * 0.7,
                        //         ),
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.end,
                        //           children: [
                        //             Text(
                        //               "You",
                        //               style: TextStyle(
                        //                   color: ColorConstant.midNight,
                        //                   fontWeight: FontWeight.w700,
                        //                   fontSize: 12),
                        //             ),
                        //             Text(
                        //               "visual form of a document or a typeface without relying on meaningful content.",
                        //               style: TextStyle(
                        //                   color: ColorConstant.midNight),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       height: 10,
                        //     ),
                        //     Padding(
                        //       padding: EdgeInsets.only(left: Get.width * 0.2),
                        //       child: Text(
                        //         "2 hours ago",
                        //         style: TextStyle(
                        //             color: ColorConstant.darkestGrey,
                        //             fontWeight: FontWeight.w700,
                        //             fontSize: 12),
                        //       ),
                        //     )
                        //   ],
                        // ),
                      ],
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              attachment == null
                  ? SizedBox()
                  : Container(
                      padding: EdgeInsets.only(right: 12, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: attachment?.path.split('/').last ?? '',
                              style: TextStyle(
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
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: ColorConstant.white,
                          border: Border.all(color: ColorConstant.grey)),
                      child: TextField(
                        controller: controller,
                        onChanged: (e){
                          message =e;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
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
                              onTap: (){
                                if(model?.status == 3){
                                  SnackBarMessage.errorSnackbar(context, 'You can not replay to this conversation');
                                  return;
                                }
                                if(message == ''){
                                  SnackBarMessage.errorSnackbar(context, 'Message Required');
                                  return;
                                }
                                var http = HttpRequest();
                                var data = {'message': message, 'replayTicket': '1'};
                                if(attachment != null){
                                  data['attachments'] =  (attachment as File).path;
                                }
                                http.ticketMessage(data, model?.id ?? 0).then((value) {
                                  if(value.success){
                                    message = '';
                                    controller.clear();
                                    attachment = null;
                                    getData();
                                  }else{
                                    SnackBarMessage.errorSnackbar(context, value.message);
                                  }
                                });
                              },
                              child: SvgPicture.asset(
                                ImageConstant.send,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            hintText: "Type your message",
                            hintStyle: TextStyle(
                                color: ColorConstant.darkestGrey,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
