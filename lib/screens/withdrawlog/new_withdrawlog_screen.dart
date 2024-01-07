import 'package:infinite_escrow/routes/routes.dart';

class NewWithdrawlogScreen extends StatelessWidget {
  final String title;
  const NewWithdrawlogScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    NewDepositController depositController = NewDepositController();

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
                  navigateToOffAllNextPage(NewWithdrawLOGScreen(
                    title: title,
                  ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Submit",
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
        appBar: customAppBar(title: title),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 56,
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorConstant.grey,
                    ),
                  ),
                  child: Obx(
                    () => DropdownButton(
                      // Initial Value
                      value: depositController.dropdownvalue.value,
                      isExpanded: true,
                      underline: Container(),

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: depositController.items.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                                color: ColorConstant.darkestGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (newValue) {
                        depositController.dropdownvalue.value =
                            newValue as String;
                      },
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 56,
                padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorConstant.grey,
                  ),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "NGN",
                        style: TextStyle(
                            color: ColorConstant.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    hintText: "Amount",
                    hintStyle: TextStyle(
                        color: ColorConstant.darkestGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 136,
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Limit",
                            style: TextStyle(
                                color: ColorConstant.darkestGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: [
                              Text.rich(TextSpan(
                                children: [
                                  TextSpan(
                                    text: "0",
                                    style: TextStyle(
                                        color: ColorConstant.midNight,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: " NGN",
                                    style: TextStyle(
                                        color: ColorConstant.darkestGrey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )),
                              SizedBox(
                                width: 5,
                              ),
                              Text("-"),
                              SizedBox(
                                width: 5,
                              ),
                              Text.rich(TextSpan(
                                children: [
                                  TextSpan(
                                    text: "1000",
                                    style: TextStyle(
                                        color: ColorConstant.midNight,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: " NGN",
                                    style: TextStyle(
                                        color: ColorConstant.darkestGrey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Charge",
                            style: TextStyle(
                                color: ColorConstant.darkestGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          Text.rich(TextSpan(
                            children: [
                              TextSpan(
                                text: "12",
                                style: TextStyle(
                                    color: ColorConstant.midNight,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: " NGN",
                                style: TextStyle(
                                    color: ColorConstant.darkestGrey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payable",
                            style: TextStyle(
                                color: ColorConstant.darkestGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          Text.rich(TextSpan(
                            children: [
                              TextSpan(
                                text: "988",
                                style: TextStyle(
                                    color: ColorConstant.midNight,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: " NGN",
                                style: TextStyle(
                                    color: ColorConstant.darkestGrey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
