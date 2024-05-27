import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/routes/routes.dart';
import '../../core/messages.dart';
import '../../core/models/all_transaction_model.dart';
import '../../core/state/api.dart';
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
          print(listModels);

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
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.tertiary,
        ),
        elevation: 0,
        title: Text('Transactions',
            style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 15,
                fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: [
          SvgPicture.asset(
            currencyImageByName[coin.value]!,
            color: Theme.of(context).colorScheme.primary,
          ),
          IconButton(
              onPressed: () {
                customCurrencyBottomSheet(
                    context, coin, "Select currency wallet??", (e) {
                  setState(() {
                    coin.value = e;
                    if (coin.value == "Naira") {
                      filteredListModel = listModels.where((element) {
                        return element.currency == 'NGN';
                      }).toList();
                    } else if (coin.value == "Dollar") {
                      filteredListModel = listModels.where((element) {
                        return element.currency == 'USD';
                      }).toList();
                    } else if (coin.value == "USDC") {
                      filteredListModel = listModels.where((element) {
                        return element.currency == 'USDC';
                      }).toList();
                    } else if (coin.value == "Ethereum") {
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
                color: Theme.of(context).colorScheme.secondary,
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
                    FutureBuilder<ShowAllTransactions>(
                      future: AppApi().getAllTransactions(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError || snapshot.data == null) {
                          // Handle the error or the case where data is null
                          // For example, you can return an error message or an empty widget
                          return Center(child: Text('Error loading data'));
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                snapshot.data?.data?.transactions?.data?.length,
                            itemBuilder: (context, index) {
                              var data = snapshot
                                  .data?.data?.transactions?.data?[index];
                              var value = data?.postBalance.toString();
                              double parsedValue = double.parse(value!);
                              String roundedString =
                                  parsedValue.toStringAsFixed(1);
                              var amount = data?.amount.toString();
                              double parsedValuee = double.parse(value!);
                              String roundedAmount =
                              parsedValuee.toStringAsFixed(1);
                              double remainingBalance = double.parse(value) - double.parse(amount.toString());
                              String rbalance =
                              remainingBalance.toStringAsFixed(1);
                              print("******");


                              print(rbalance);
                              print(rbalance);
//
//                             // Access the "created_at" field
//                             String createdAtString = data!.createdAt.toString();

// // Convert the string into a DateTime object
//                             DateTime createdAt =
//                                 DateTime.parse(createdAtString);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: customTransactionContainer(
                                  title: data?.currencySym.toString(),
                                  price: roundedString,
                                  // containerColor: Color(0xffFFF2D8),
                                  // containerTitle: "Completed",
                                  currencyName: data?.currencySym
                                      .toString(), //data.currencySym.toString(),
                                  id: data?.id?.toInt(),
                                  // date: DateTime.now(),
                                  trx:data?.trx.toString(),
                                  profit:amount.toString(),
                                  trxType:data?.trxType.toString(),
                                    details:data?.details.toString(),
                                  trxColor: data?.trxType=="+"?Colors.green:Colors.red,
                                    remainingBalance:rbalance,
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                    // for (var i in filteredListModel)
                    //   Padding(
                    //     padding: const EdgeInsets.only(bottom: 10),
                    //     child: customTransactionContainer(
                    //       title: i.title,
                    //       price: i.amount.toString(),
                    //       containerColor: i.getStatusColor(),
                    //       containerTitle: i.getStatusString(),
                    //       currencyName: i.currency,
                    //       id: i.id,
                    //       date: i.createdAt,
                    //     ),
                    //   )
                  ],
                ),
              ),
            ),
    );
  }
}
