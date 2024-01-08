import 'package:infinite_escrow/routes/routes.dart';

class CompletedEscrowDetailScreen extends StatelessWidget {
  const CompletedEscrowDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: customAppBar(
          title: "Escrow details",
        ),

       
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 450,
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
                            "Title of Escrow would be here",
                            style: TextStyle(
                                color: ColorConstant.midNight,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          Container(
                            width: 65,
                            height: 24,
                            decoration: BoxDecoration(color: Color(0xffD4FDC5)),
                            child: Center(
                              child: Text(
                                "Completed",
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
                            "Hamid455874644",
                            style: TextStyle(
                                color: ColorConstant.midNight,
                                fontSize: 13,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      customRow(title: "Amount", amount: 0, currency: ''),
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
                                "1200",
                                style: TextStyle(
                                    color: ColorConstant.midNight,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "NGN",
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
                                width: 47,
                                height: 24,
                                color: Color(0xffE0EDFF),
                                child: Center(
                                  child: Text(
                                    "Buyer",
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
                      customRow(
                        title: "Created Milestone",amount: 0, currency: ''
                      ),
                      SizedBox(height: 10),
                      customRow(
                        title: "Milestone Funded", amount: 0, currency: ''
                      ),
                      SizedBox(height: 10),
                      customRow(title: "Milestone Unfunded", amount: 0, currency: ''),
                      SizedBox(height: 10),
                      customRow(title: "Rest Amount", amount: 0, currency: ''),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    physics: NeverScrollableScrollPhysics(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Hamid455874644",
                                        style: TextStyle(
                                            color: ColorConstant.midNight,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        "in publishing and graphic design",
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
                                  "1 hours ago",
                                  style: TextStyle(
                                      color: ColorConstant.darkestGrey,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12),
                                ),
                              )
                            ],
                          ),
                          Column(
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
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.7,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "You",
                                        style: TextStyle(
                                            color: ColorConstant.midNight,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        "visual form of a document or a typeface without relying on meaningful content.",
                                        style: TextStyle(
                                            color: ColorConstant.midNight),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: Get.width * 0.2),
                                child: Text(
                                  "2 hours ago",
                                  style: TextStyle(
                                      color: ColorConstant.darkestGrey,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ],
                      );
                    }),
                Divider(),
                SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type your message...",
                        prefixIcon: SvgPicture.asset(
                          ImageConstant.attachments,
                          fit: BoxFit.scaleDown,
                        ),
                        suffixIcon: SvgPicture.asset(
                          ImageConstant.send,
                          fit: BoxFit.scaleDown,
                        ),
                        hintStyle: TextStyle(
                            color: ColorConstant.midNight,
                            fontSize: 13,
                            fontWeight: FontWeight.w500)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}