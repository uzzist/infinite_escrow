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
  List<TransactionModel> filteredListModel = [];
  bool loading = false;
  RxString coin = "Naira".obs;

  @override
  void initState() {
    super.initState();
    var http = HttpRequest();
    var t = http.getCurrency();
    if (t != null) {
      setState(() {
        coin.value = t;
      });
    }
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

          filteredListModel = listModels.where((element) {
            return element.currency == 'NGN';
          }).toList();
        });
      } else {
        SnackBarMessage.errorSnackbar(context, value.message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.white,
        iconTheme: IconThemeData(
          color: ColorConstant.black,
        ),
        elevation: 0,
        title: Text('Transactions', style: TextStyle(
            color: ColorConstant.black,
            fontSize: 15,
            fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: [
          SvgPicture.asset(currencyImageByName[coin.value]!),
          IconButton(
              onPressed: () {
                customCurrencyBottomSheet(
                    context, coin, "Select currency wallet??", (e) {
                  setState(() {
                    coin.value = e;
                    if(coin.value == "Naira") {
                      filteredListModel = listModels.where((element) {
                        return element.currency == 'NGN';
                      }).toList();
                    } else if(coin.value == "Dollar") {
                      filteredListModel = listModels.where((element) {
                        return element.currency == 'USD';
                      }).toList();
                    } else if(coin.value == "USDC") {
                      filteredListModel = listModels.where((element) {
                        return element.currency == 'USDC';
                      }).toList();
                    } else if(coin.value == "Ethereum") {
                      filteredListModel = listModels.where((element) {
                        return element.currency == 'ETH';
                      }).toList();
                    } else {
                      filteredListModel = listModels.where((element) {
                        return element.currency == 'BTC';
                      }).toList();
                    }

                  });
                  Navigator.pop(context);
                });
              },
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: ColorConstant.darkestGrey,
              ))
        ],
      ),
      body: filteredListModel.length == 0
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
              for (var i in filteredListModel)
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