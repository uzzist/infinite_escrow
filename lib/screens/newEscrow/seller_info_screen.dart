import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:infinite_escrow/core/constants.dart';
import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/core/messages.dart';
import 'package:infinite_escrow/routes/routes.dart';

class SellerInfoScreen extends StatefulWidget {
  NewEscrowController newEscrowController;
  String coin;
  String escrowType;
  SellerInfoScreen({Key? key, required this.newEscrowController, required this.coin, required this.escrowType}) : super(key: key);

  @override
  State<SellerInfoScreen> createState() => _SellerInfoScreenState();
}

class _SellerInfoScreenState extends State<SellerInfoScreen> {
  List<File> attachment = [];
  RxString coin = "2".obs;
  bool loading = false;
  TextEditingController textEditingController = TextEditingController();
  var data = {};
  dynamic iconType(String path) {
    var ext = path.split(".")[path.split(".").length - 1];
    if( ext == 'jpg' || ext == 'png'){
      return  ImageConstant.photo;
    }else if(ext == 'mp4' ||ext == 'mov' ){
      return ImageConstant.video;
    }else{
      return  ImageConstant.phone;
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
                onPressed: loading? (){}: () {
                  var formData = {
                    'email' : data['email'].toString() ?? '',
                    'title': data['title'].toString() ?? '',
                    'details': data['detail'].toString() ?? '',
                    'charge_payer': coin.value.toString(),
                    'category_id': widget.newEscrowController.type.value.toString(),
                    'amount': widget.newEscrowController.value.toString(),
                    'type': widget.newEscrowController.isSeller.isTrue ? '1': '2',
                    'currency_sym': Constants.currencyType[ widget.coin.toString()].toString()
                  };
                  setState(() {
                    loading = true;
                  });
                  var http = HttpRequest();
                  if(attachment.isNotEmpty){
                    formData['file'] = (attachment[0]).path;
                  }
                  http.newEscrow(formData).then((value) {
                    setState(() {
                      loading = false;
                    });
                    if(value.success){
                      navigateToPage(EscrowWithdrawScreen(price: widget.newEscrowController.value.toString(),
                      title: data['title'].toString() ?? '',
                        tTitle: "New Escrow submitted successfully",
                        coin: widget.coin.toString(),
                        escrowType: widget.escrowType,
                        isSeller: widget.newEscrowController.isSeller.value,
                      ));
                    }else{
                      SnackBarMessage.errorSnackbar(context, value.message);
                    }
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loading ? CircularProgressIndicator(color: Colors.white,): Text("Next",
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
        appBar: customAppBar(title: "Seller information"),
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
                      "Charge",
                      style: TextStyle(
                          color: ColorConstant.midNight,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        // Text(
                        //   widget.newEscrowController.value,
                        //   style: TextStyle(
                        //       color: ColorConstant.midNight,
                        //       fontSize: 20,
                        //       fontWeight: FontWeight.w600),
                        // ),
                        Text(
                          widget.newEscrowController.charge,
                          style: TextStyle(
                              color: ColorConstant.midNight,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.coin,
                          style: TextStyle(
                              color: ColorConstant.midNight,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Escrow Amount",
                      style: TextStyle(
                          color: ColorConstant.midNight,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Text(
                          widget.newEscrowController.value,
                          style: TextStyle(
                              color: ColorConstant.midNight,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.coin,
                          style: TextStyle(
                              color: ColorConstant.midNight,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                customTextFieldWithoutIcon(
                  hintText: "Seller Email",
                  onChange: (e){
                    data['email'] = e;
                  }
                ),
                SizedBox(
                  height: 20,
                ),
                customTextFieldWithoutIcon(
                  hintText: "Title",
                    onChange: (e){
                      data['title'] = e;
                    }
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  padding: EdgeInsets.only(left: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorConstant.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Constants.chargePay[coin.value]!,
                        style: TextStyle(
                            color: ColorConstant.darkestGrey,
                            fontSize: 14,
                            fontFamily: FontConstant.jakartaMedium,
                            fontWeight: FontWeight.w500),
                      ),
                      IconButton(
                          onPressed: () {
                            Get.bottomSheet(Container(
                                height: 250,
                                color: ColorConstant.white,
                                child: Column(children: [
                                  InkWell(
                                    child: customRadioButtonForSellerEscrow(
                                        coin: coin,
                                        typeName: "Buyer will pay",
                                        value: '2'),
                                    onTap: (){
                                      setState(() {
                                        coin.value = "2";
                                      });
                                    },
                                  ),
                                  InkWell(
                                    child: customRadioButtonForSellerEscrow(
                                        coin: coin,
                                        typeName: "Seller will pay",
                                        value: '1'),
                                    onTap: (){
                                      setState(() {
                                        coin.value = "1";
                                      });
                                    },
                                  ),
                                  InkWell(
                                    child: customRadioButtonForSellerEscrow(
                                        coin: coin,
                                        typeName: "50/50",
                                        value: '3'),
                                    onTap: (){
                                      setState(() {
                                        coin.value = "3";
                                      });
                                    },
                                  )
                                ])));
                          },
                          icon: Icon(Icons.keyboard_arrow_down))
                    ],
                  ),
                ),
                // TextField(
                //   decoration: InputDecoration(
                //     hintText: "Charge will pay",
                //     hintStyle: TextStyle(
                //         color: ColorConstant.darkestGrey,
                //         fontSize: 14,
                //         fontFamily: FontConstant.jakartaMedium,
                //         fontWeight: FontWeight.w500),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(0),
                //       borderSide: BorderSide(
                //         color: ColorConstant.grey,
                //         width: 1,
                //       ),
                //     ),
                //     suffixIcon: IconButton(
                //         onPressed: () {
                //           Get.bottomSheet(Container(
                //               height: 250,
                //               color: ColorConstant.white,
                //               child: Column(children: [
                //                 customRadioButtonForSellerEscrow(
                //                     coin: coin,
                //                     typeName: "Buyer will pay",
                //                     value: "Buyer will pay"),
                //                 customRadioButtonForSellerEscrow(
                //                     coin: coin,
                //                     typeName: "Seller will pay",
                //                     value: "Seller will pay"),
                //                 customRadioButtonForSellerEscrow(
                //                     coin: coin,
                //                     typeName: "50/50",
                //                     value: "50/50")
                //               ])));
                //         },
                //         icon: Icon(Icons.keyboard_arrow_down)),
                //     enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(0),
                //       borderSide: BorderSide(
                //         color: ColorConstant.grey,
                //         width: 1,
                //       ),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(0),
                //       borderSide: BorderSide(
                //         color: ColorConstant.grey,
                //         width: 1,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                customTextFieldWithoutIcon(hintText: "Details", maxlines: 4,
                    onChange: (e){
                      data['detail'] = e;
                    }),
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
                      allowedExtensions: ['jpg', 'png', 'mp4', 'mov'],
                    );
                    if (result != null) {
                      setState(() {
                        attachment =
                            result.paths.map((path) => File(path!)).toList();
                      });
                    }
                  },
                  child: DottedBorder(
                    color: ColorConstant.grey,
                    strokeWidth: 1,
                    child: SizedBox(
                      height: 104,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(ImageConstant.cloud),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Choose file here",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: ColorConstant.darkestGrey,
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
                                color: ColorConstant.darkestGrey,
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
                                    color: ColorConstant.midNight,
                                    fontSize: 14,
                                    fontFamily: FontConstant.jakartaMedium,
                                    fontWeight: FontWeight.w500),
                                children: [
                                  TextSpan(
                                    text:
                                    " (${(attachment[index].lengthSync() ?? 1) / 1000} KB)",
                                    style: TextStyle(
                                        color: ColorConstant.darkestGrey,
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

SizedBox customRadioButtonForSellerEscrow({
  required RxString coin,
  required String typeName,
  required String value,
}) {
  return SizedBox(
    child: Column(
      children: [
        Obx(
              () => Row(
            children: [
              Radio(
                  activeColor: Color(0xff0E642B),
                  groupValue: coin.value,
                  value: value,
                  onChanged: (val) {
                    coin.value = val.toString();
                  }),
              SizedBox(width: 10),
              Text(
                typeName,
                style: TextStyle(
                    color: coin.value == value
                        ? Color(0xff0E642B)
                        : ColorConstant.midNight,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontConstant.jakartaMedium,
                    fontSize: 14),
              ),
            ],
          ),
        ),
        Divider(),
        SizedBox(
          height: 10,
        )
      ],
    ),
  );
}
