import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/routes/routes.dart';
import '../../core/messages.dart';
import 'models/transaction.dart';

class TransactionScreen extends StatefulWidget {
  final bool isIconShow;

  TransactionScreen({super.key, this.isIconShow = true});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<TransactionModel> listModels = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    var http = HttpRequest();
    setState(() {
      loading = true;
    });
    http.getEscrowList().then((value) {
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
        title: "Transactions",
        isIconShow: widget.isIconShow,
      ),
      body: listModels.length == 0
          ? Center(
              child: loading
                  ? CircularProgressIndicator(
                      color: ColorConstant.darkestGrey,
                    )
                  : Image.asset(
                      ImageConstant.noTransaction,
                      width: 127,
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
                        child: customTransactionContainer(
                          title: i.title,
                          price: i.amount.toString(),
                          containerColor: i.getStatusColor(),
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
