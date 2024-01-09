import 'package:infinite_escrow/core/messages.dart';
import 'package:infinite_escrow/routes/routes.dart';

class NewEscrowScreen extends StatefulWidget {
  const NewEscrowScreen({super.key});

  @override
  State<NewEscrowScreen> createState() => _NewEscrowScreenState();
}

class _NewEscrowScreenState extends State<NewEscrowScreen> {
  String coin = 'Naira';
  NewEscrowController newEscrowController = NewEscrowController();
  TextEditingController textEditingController = TextEditingController();
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
                onPressed: () {
                  if (newEscrowController.type.value == '') {
                    SnackBarMessage.errorSnackbar(context, "Type is required");
                  } else if (newEscrowController.value == '') {
                    SnackBarMessage.errorSnackbar(context, "price is required");
                  } else {
                    if(coin == 'Naira') {
                      if(int.parse(newEscrowController.value) < 10000) {
                        newEscrowController.charge = '250';
                      } else if(int.parse(newEscrowController.value) > 10000) {
                        newEscrowController.charge = (int.parse(newEscrowController.value) * 0.03).toStringAsFixed(3);
                      }
                    } else {
                      if(int.parse(newEscrowController.value) < 100) {
                        newEscrowController.charge = '2';
                      } else if(int.parse(newEscrowController.value) > 100) {
                        newEscrowController.charge = (int.parse(newEscrowController.value) * 0.03).toStringAsFixed(3);
                      }
                    }
                    navigateToPage(SellerInfoScreen(
                        newEscrowController: newEscrowController, coin: coin, escrowType: textEditingController.text,));
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Next",
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
        appBar: customAppBar(title: ""),
        backgroundColor: ColorConstant.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.2),
                SizedBox(
                    height: 40, child: Image.asset(ImageConstant.writingHand)),
                Text(
                  "New Escrow",
                  style: TextStyle(
                      color: ColorConstant.midNight,
                      fontWeight: FontWeight.w700,
                      fontFamily: FontConstant.jakartaBold,
                      fontSize: 32),
                ),
                Text(
                  "Start your new escrow and other texts here",
                  style: TextStyle(
                      color: ColorConstant.midNight,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Obx(() => customNewEscrowContainer(
                        isActive: newEscrowController.isSeller,
                        title: "I'm Seller",
                        onPressed: () {
                          newEscrowController.isSeller.value = true;
                          newEscrowController.isBuyer.value = false;
                        })),
                    Obx(() => customNewEscrowContainer(
                        isActive: newEscrowController.isBuyer,
                        title: "I'm Buyer",
                        onPressed: () {
                          newEscrowController.isBuyer.value = true;
                          newEscrowController.isSeller.value = false;
                        }))
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 56,
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorConstant.grey,
                    ),
                  ),
                  child: TextFormField(
                    onTap: () {
                      customCurrencyBottomSheetForEscrow(
                          context,
                          newEscrowController.type,
                          "Select Escrow type", (e, label) {
                        newEscrowController.coin.value = e;
                        textEditingController.text = label;

                      });
                    },
                    readOnly: true,
                    controller: textEditingController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: () {
                          customCurrencyBottomSheetForEscrow(
                              context,
                              newEscrowController.type,
                              "Select Escrow type", (e, label) {
                            newEscrowController.coin.value = e;
                            textEditingController.text = label;
                          });
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: ColorConstant.darkestGrey,
                        ),
                      ),
                      hintText: "Select Escrow type",
                      hintStyle: TextStyle(
                          color: ColorConstant.darkestGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 56,
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorConstant.grey,
                    ),
                  ),
                  child: TextFormField(
                    onChanged: (e) {
                      newEscrowController.value = e;
                    },
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "For",
                          style: TextStyle(
                              color: ColorConstant.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      suffixIcon: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(currencyImageByName[coin]!),
                          IconButton(
                              onPressed: () {
                                customCurrencyBottomSheet(
                                    context,
                                    newEscrowController.coin,
                                    "Select currency type", (e) {
                                  setState(() {
                                    newEscrowController.coin.value = e;
                                    coin = e;
                                  });
                                });
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: ColorConstant.darkestGrey,
                              ))
                        ],
                      ),
                      hintText: "Amount",
                      hintStyle: TextStyle(
                          color: ColorConstant.darkestGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
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
