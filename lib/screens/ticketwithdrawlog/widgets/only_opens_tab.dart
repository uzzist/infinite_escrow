import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/routes/routes.dart';

import '../models/ticket_model.dart';

class OnlyOpensTab extends StatefulWidget {
  const OnlyOpensTab({super.key});

  @override
  State<OnlyOpensTab> createState() => _OnlyOpensTabState();
}

class _OnlyOpensTabState extends State<OnlyOpensTab> {
  bool loading = false;
  List<TicketsModel> list = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    var http = HttpRequest();
    http.getTickets(only: true).then((value) {
      setState(() {
        loading = false;
      });
      if (value.success == true) {
        setState(() {
          list = TicketsModel.fromJson(value.data['data']['my_ticket']['data']);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: list.isEmpty
          ? Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: MediaQuery.of(context).size.height / 4),
              child: Center(
                child: loading
                    ? CircularProgressIndicator(
                        color: ColorConstant.darkestGrey,
                      )
                    : Image.asset(
                        ImageConstant.noTicket,
                        width: 103,
                      ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i in list)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: customTickerContainer(
                        containerWidth: 101,
                        ticketNo: i.ticket,
                        containerColor: i.getStatusColor(),
                        subject: i.subject,
                        containerTitle: i.getStatusString(),
                        dividercolor: Color(0xffFF5732),
                        replayTime: i.lastReply,
                        id: i.id),
                  )
              ],
            ),
    );
  }
}
