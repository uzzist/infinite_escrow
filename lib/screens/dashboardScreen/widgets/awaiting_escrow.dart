import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/routes/routes.dart';

import '../../../core/messages.dart';
import '../../transactionScreen/models/transaction.dart';

class AwaitingEscrowScreen extends StatefulWidget {
  const AwaitingEscrowScreen({super.key});

  @override
  State<AwaitingEscrowScreen> createState() => _AwaitingEscrowScreenState();
}

class _AwaitingEscrowScreenState extends State<AwaitingEscrowScreen> {
  List<TransactionModel> listModels = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    var http = HttpRequest();
    setState(() {
      loading = true;
    });
    http.getEscrowNotAcceptedList().then((value) {
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
          title: "Awaiting Escrow",
          titleColor: Theme.of(context).colorScheme.tertiary,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          iconColor: Theme.of(context).colorScheme.tertiary,
          isActionsShow: true, actions: [
        InkWell(
            onTap: () {
              navigateToPage(NewEscrowScreen());
            },
            child: SvgPicture.asset(ImageConstant.plus, color: Theme.of(context).colorScheme.primary,)),
        SizedBox(width: 10)
      ]),
      body: listModels.isEmpty
          ? Center(
              child: loading
                  ? CircularProgressIndicator(
                      color: ColorConstant.darkestGrey,
                    )
                  : Image.asset(
                      ImageConstant.noAwaitingEscrow,
                      width: 160,
                    ),
            )
          : SingleChildScrollView(
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
                          containerTitle: i.getStatusString(),
                          currencyName: i.currency,
                          id: i.id,
                          sId: i.id.toString(),
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
