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
                  var http = HttpRequest();
                  var body = {
                    'escrow_id': widget.id.toString(),
                    'amount': controller.value.value,
                    'note': controller.title.value
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loading? CircularProgressIndicator(color: Colors.white,): Text("Submit",
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
        appBar: customAppBar(title: "New Milestone (Fund Escrow)"),
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
                        color: ColorConstant.midNight,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customTextFieldWithoutIcon(hintText: "Title", onChange: (e){
                    controller.title.value = e;
                  }),
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
                              context, controller.coin, "Pay Milestone",(){
                                setState(() {

                                });
                          });
                        },
                        child: Text(
                          controller.coin.value,
                          style: TextStyle(
                              color: ColorConstant.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
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
            ],
          ),
        ),
      ),
    );
  }
}
