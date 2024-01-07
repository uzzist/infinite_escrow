import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/routes/routes.dart';

import '../../../core/messages.dart';
import '../models/ticket_model.dart';

class AllTickerTab extends StatefulWidget {
  const AllTickerTab({super.key});

  @override
  State<AllTickerTab> createState() => _AllTickerTabState();
}

class _AllTickerTabState extends State<AllTickerTab> {
  bool loading = false;
  List<TicketsModel> list = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    var http = HttpRequest();
    http.getTickets().then((value) {
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
                        containerTitle: i.getStatusString(),
                        subject: i.subject,
                        dividercolor: Color(0xffFF5732),
                        replayTime: i.lastReply,
                        id: i.id),
                  ),
              ],
            ),
    );
  }
}
