import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/core/messages.dart';
import 'package:infinite_escrow/routes/routes.dart';

class TickerSellerInfoScreen extends StatefulWidget {
  const TickerSellerInfoScreen({Key? key}) : super(key: key);

  @override
  State<TickerSellerInfoScreen> createState() => _TickerSellerInfoScreenState();
}

class _TickerSellerInfoScreenState extends State<TickerSellerInfoScreen> {
  List<File> attachment = [];
  bool loading = false;
  NewTickerController tickerController = NewTickerController();
  TextEditingController textEditingController =
      TextEditingController(text: 'High');

  dynamic iconType(String path) {
    var ext = path.split(".")[path.split(".").length - 1];
    if (ext == 'jpg' || ext == 'png') {
      return ImageConstant.photo;
    } else if (ext == 'mp4' || ext == 'mov') {
      return ImageConstant.video;
    } else {
      return ImageConstant.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        persistentFooterButtons: [
          Container(
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(color: ColorConstant.lightGreen),
            child: TextButton(
                onPressed: loading
                    ? () {}
                    : () {
                        var formData = {
                          'subject': tickerController.issue.value.toString(),
                          'message': tickerController.message.value.toString(),
                          'priority': tickerController.coin.value.toString(),
                        };
                        if (attachment.isNotEmpty) {
                          formData['attachments'] = (attachment[0]).path;
                        }
                        setState(() {
                          loading = true;
                        });
                        var http = HttpRequest();
                        http.newTicket(formData).then((value) {
                          setState(() {
                            loading = false;
                          });
                          if (value.success) {
                            SnackBarMessage.successSnackbar(
                                context, 'You Ticket Have been Submitted');
                            navigateToOffAllNextPage(BottomNavigationScreen());
                          } else {
                            SnackBarMessage.errorSnackbar(
                                context, value.message);
                          }
                        });
                      },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text("Submit",
                            style: TextStyle(
                                color: ColorConstant.midNight,
                                fontSize: 17,
                                fontFamily: FontConstant.jakartaSemiBold,
                                fontWeight: FontWeight.w700)),
                    SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Icon(
                        Icons.arrow_forward,
                        color: ColorConstant.midNight,
                      ),
                    )
                  ],
                )),
          ),
        ],
        appBar: customAppBar(
          title: "New Ticket",
          titleColor: Theme.of(context).colorScheme.tertiary,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          iconColor: Theme.of(context).colorScheme.tertiary,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Subject",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 15,
                          fontFamily: FontConstant.jakartaSemiBold,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    customTextFieldWithoutIcon(
                      hintTextColor: Theme.of(context).colorScheme.secondary,
                        hintText: "My Issue",
                        onChange: (e) {
                          tickerController.issue.value = e;
                        }),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Priority',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 15,
                          fontFamily: FontConstant.jakartaSemiBold,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 14,
                          fontFamily: FontConstant.jakartaMedium,
                          fontWeight: FontWeight.w500),
                      controller: textEditingController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 14,
                            fontFamily: FontConstant.jakartaMedium,
                            fontWeight: FontWeight.w500),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                            width: 1,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            Get.bottomSheet(Container(
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
                                    "Select Priority",
                                    style: TextStyle(
                                        color: ColorConstant.black,
                                        fontSize: 15,
                                        fontFamily:
                                            FontConstant.jakartaSemiBold,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  customRadioButtonForTicker(
                                      coin: tickerController.coin,
                                      value: "3",
                                      typeName: "High",
                                      change: (v) {
                                        textEditingController.text = "High";
                                      }),
                                  customRadioButtonForTicker(
                                      coin: tickerController.coin,
                                      value: "2",
                                      typeName: "Medium",
                                      change: (v) {
                                        textEditingController.text = "Medium";
                                      }),
                                  customRadioButtonForTicker(
                                      coin: tickerController.coin,
                                      value: "1",
                                      typeName: "Low",
                                      change: (v) {
                                        textEditingController.text = "Low";
                                      }),
                                ],
                              ),
                            ));
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Message",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 15,
                          fontFamily: FontConstant.jakartaSemiBold,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    customTextFieldWithoutIcon(
                      hintTextColor: Theme.of(context).colorScheme.secondary,
                        hintText: "Message",
                        maxlines: 4,
                        onChange: (e) {
                          tickerController.message.value = e;
                        }),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.custom,
                      allowedExtensions: [
                        'jpg',
                        'png',
                        'mp4',
                        'mov',
                        'pdf',
                        'doc'
                      ],
                    );
                    if (result != null) {
                      setState(() {
                        attachment =
                            result.paths.map((path) => File(path!)).toList();
                      });
                    }
                  },
                  child: DottedBorder(
                    color: Theme.of(context).colorScheme.outline,
                    strokeWidth: 1,
                    child: SizedBox(
                      height: 104,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(ImageConstant.cloud, color: Theme.of(context).colorScheme.primary,),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Choose file here",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 14,
                                fontFamily: FontConstant.jakartaMedium,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            ".JPG  .PNG   .MP4 and .MOV are allowed",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 14,
                                fontFamily: FontConstant.jakartaMedium,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.separated(
                  itemCount: attachment.length ?? 0,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                                iconType(attachment[index].path ?? '')),
                            SizedBox(
                              width: 10,
                            ),
                            Text.rich(
                              TextSpan(
                                text: attachment[index].path.split('/').last ??
                                    '',
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontSize: 14,
                                    fontFamily: FontConstant.jakartaMedium,
                                    fontWeight: FontWeight.w500),
                                children: [
                                  TextSpan(
                                    text:
                                        " (${(attachment[index].lengthSync() ?? 1) / 1000} KB)",
                                    style: TextStyle(
                                        color: Theme.of(context).colorScheme.secondary,
                                        fontSize: 14,
                                        fontFamily: FontConstant.jakartaMedium,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              attachment.removeAt(index);
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
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    height: 20,
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
