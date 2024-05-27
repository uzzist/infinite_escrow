import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/core/messages.dart';
import 'package:infinite_escrow/routes/routes.dart';
import 'package:infinite_escrow/screens/dashboardScreen/widgets/milstoneScreen/widgets/customCurrencyBottomSheetForMilestone.dart';

class NewMileStoneScreen extends StatefulWidget {
  int id;
  NewMileStoneScreen({super.key, required this.id});

  @override
  State<NewMileStoneScreen> createState() => _NewMileStoneScreenState();
}

class _NewMileStoneScreenState extends State<NewMileStoneScreen> {
  MilestoneController controller = MilestoneController();
  bool loading = false;
  List<String> optn =['Wallet'];
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
                onPressed: loading? (){}: () {
                  if(controller.value.value == ''){
                    SnackBarMessage.errorSnackbar(context, "Amount is required");
                    return;
                  }
                  setState(() {
                    loading = true;
                  });
                  print(controller.coin.value.toString());
                  var http = HttpRequest();
                  var body = {
                    'escrow_id': widget.id.toString(),
                    'amount': controller.value.value,
                    'note': controller.title.value,
                    'currency_sym': controller.coin.value.toString()
                  };
                  http.submitMilestone(body).then((value) {
                    setState(() {
                      loading = false;
                    });
                    if(value.success){
                      navigateToOffAllNextPage(NewWithdrawLOGScreen(title: 'New Milestone (Fund Escrow)'));
                    }else{
                      SnackBarMessage.errorSnackbar(context, value.message);
                    }
                  });
                },
                // onPressed: () {
                //   showDialog(
                //       context: context,
                //       builder: (context) {
                //     String selectedOption = "Wallet";
                //     return StatefulBuilder(
                //       builder: (context, setState) => AlertDialog(
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.zero,
                //         ),
                //         title: Text("Select an option"),
                //         content: Container(
                //           height: MediaQuery.of(context).size.height * 0.4,
                //           width: MediaQuery.of(context).size.width,
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.stretch,
                //             children: [
                //               DropdownButton<String>(
                //                 value: selectedOption,
                //                 onChanged: (newValue) {
                //                   setState(() {
                //                     selectedOption = newValue!;
                //                     int selectedIndex = optn.indexWhere((option) => option == newValue);
                //                     print(selectedIndex);
                //                   });
                //                 },
                //                 items: optn
                //                     .map<DropdownMenuItem<String>>((String value) {
                //                   return DropdownMenuItem<String>(
                //                     value: value,
                //                     child: Text(value),
                //                   );
                //                 }).toList(),
                //               ),
                //               Spacer(),
                //             Container(
                //               height: 56,
                //               width: double.infinity,
                //               decoration: BoxDecoration(color: ColorConstant.lightGreen),
                //               child: TextButton(
                //                 onPressed: loading? (){
                //                 }: () {
                //                   if(controller.value.value == ''){
                //                     Navigator.of(context).pop();
                //                     SnackBarMessage.errorSnackbar(context, "Amount is required");
                //                     return;
                //                   }
                //                   setState(() {
                //                     loading = true;
                //                   });
                //                   var http = HttpRequest();
                //                   var body = {
                //                     'escrow_id': widget.id.toString(),
                //                     'amount': controller.value.value,
                //                     'note': controller.title.value
                //                   };
                //                   http.submitMilestone(body).then((value) {
                //                     setState(() {
                //                       loading = false;
                //                     });
                //                     if(value.success){
                //                       navigateToOffAllNextPage(NewWithdrawLOGScreen(title: 'New Milestone (Fund Escrow)'));
                //                     }else{
                //                       Navigator.of(context).pop();
                //                       SnackBarMessage.errorSnackbar(context, value.message);
                //                     }
                //                   });
                //                 },
                //                   child: Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 loading ? CircularProgressIndicator() : Text("Submit",
                //                     style: TextStyle(
                //                         color: ColorConstant.midNight,
                //                         fontSize: 17,
                //                         fontFamily: FontConstant.jakartaSemiBold,
                //                         fontWeight: FontWeight.w700)),
                //                 SizedBox(width: 10),
                //                 Padding(
                //                   padding: const EdgeInsets.only(top: 4.0),
                //                   child: Icon(
                //                     Icons.arrow_forward,
                //                     color: ColorConstant.midNight,
                //                   ),
                //                 )
                //               ],
                //                                       )),
                //             ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     );
                //   });
                // },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loading? CircularProgressIndicator(color: Colors.white,): Text("Create Milestone",
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
        appBar: customAppBar(title: "New Milestone (Fund Escrow)", backgroundColor: Theme.of(context).appBarTheme.backgroundColor, titleColor: Theme.of(context).colorScheme.tertiary, iconColor: Theme.of(context).colorScheme.tertiary),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customTextFieldWithoutIcon(hintText: "Title", onChange: (e){
                    controller.title.value = e;
                  }, hintTextColor: Theme.of(context).colorScheme.secondary),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorConstant.grey,
                  ),
                ),
                child: TextFormField(
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),
                  onChanged: (e){
                    controller.value.value = e;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: InkWell(
                        onTap: () {
                          customCurrencyBottomSheetForMilestone(
                              context, controller.coin, "Select Currency",(){
                                setState(() {

                                });
                          });
                        },
                        child: Text(
                          controller.coin.value,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    hintText: "Amount",
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
