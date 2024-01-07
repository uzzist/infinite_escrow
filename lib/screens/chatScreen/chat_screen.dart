
import 'package:infinite_escrow/routes/routes.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChatBubble(
                clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
                backGroundColor: Color(0xffE7F6EB),
                margin: EdgeInsets.only(top: 20),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(top: 20),
                backGroundColor: Color(0xffF2F6F7),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
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
                        style: TextStyle(color: ColorConstant.midNight),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: Get.width * 0.24),
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
      ),
    );
  }
}
