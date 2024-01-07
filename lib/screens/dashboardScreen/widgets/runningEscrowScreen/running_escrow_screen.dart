import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/routes/routes.dart';

import '../../../../core/messages.dart';
import '../../../transactionScreen/models/transaction.dart';

class RuningEscrowScreen extends StatefulWidget {
  const RuningEscrowScreen({super.key});

  @override
  State<RuningEscrowScreen> createState() => _RuningEscrowScreenState();
}

class _RuningEscrowScreenState extends State<RuningEscrowScreen> {
  List<TransactionModel> listModels = [];

  bool loading = false;

  @override
  void initState() {
    super.initState();
    var http = HttpRequest();
    setState(() {
      loading = true;
    });
    http.getEscrowAcceptedList().then((value) {
      setState(() {
        loading = false;
      });
      if (value.success == true) {
        setState(() {
          listModels = TransactionModel.fromJsonToList(
              value.data['data']['escrows']['data']);
        });
      } else {
        SnackBarMessage.errorSnackbar(context, value.message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Runing Escrow",
        isActionsShow: true,
        actions: [
          InkWell(
              onTap: () {
                navigateToPage(NewEscrowScreen());
              },
              child: SvgPicture.asset(ImageConstant.plus)),
          SizedBox(width: 10)
        ],
      ),
      body: listModels.isEmpty
          ? Center(
        child: loading
            ? CircularProgressIndicator(
          color: ColorConstant.darkestGrey,
        )
            : Image.asset(
          ImageConstant.noRunningEscrow,
          width: 153,
        ),
      ): SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i in listModels)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: customDepositHistoryContainer(
                    title: i.title,
                    price: i.amount.toString(),
                    containerColor: i.getStatusColor(),
                    sId: i.id.toString(),
                    containerTitle: i.getStatusString(),
                    currencyName: i.currency,
                    id: i.id,
                    date: i.createdAt,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
