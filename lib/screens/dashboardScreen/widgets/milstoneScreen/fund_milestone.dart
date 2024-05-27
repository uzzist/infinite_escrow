import 'package:flutter/material.dart';
import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/core/messages.dart';
import 'package:infinite_escrow/routes/routes.dart';
import 'package:infinite_escrow/screens/dashboardScreen/widgets/milstoneScreen/widgets/customCurrencyBottomSheetForMilestone.dart';

class FundMileStoneScreen extends StatefulWidget {
  int id;
  FundMileStoneScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<FundMileStoneScreen> createState() => _FundMileStoneScreenState();
}

class _FundMileStoneScreenState extends State<FundMileStoneScreen> {
  MilestoneController controller = MilestoneController();
  bool loading = false;
  int selectedIndex=0;
  List<String> optn = ['Wallet'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Call the function to open the dialog box
      _openDialogBox();
    });
  }

  void _openDialogBox() {
    showDialog(
      context: context,
      builder: (context) {
        String selectedOption = "Wallet";
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            title: Text("Select an option"),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButton<String>(
                    value: selectedOption,
                    onChanged: (newValue) {
                      setState(() {
                        selectedOption = newValue!;
                        selectedIndex = optn.indexWhere(
                                (option) => option == newValue);
                        print(selectedIndex);
                      });
                    },
                    items: optn
                        .map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                  ),
                  Spacer(),
                  Container(
                    height: 56,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorConstant.lightGreen),
                    child: TextButton(
                      onPressed: loading
                          ? () {}
                          : () {
                        if (controller.value.value == '') {
                          Navigator.of(context).pop();
                          SnackBarMessage.errorSnackbar(
                              context, "Amount is required");
                          return;
                        }
                        setState(() {
                          loading = true;
                        });

                        print(widget.id);
                        var http = HttpRequest();
                        var body = {
                          'milestone_id': widget.id.toString(),
                          'pay_via': selectedIndex.toString(),

                        };
                        http.payMilestone(body).then(
                              (value) {
                            setState(() {
                              loading = false;
                              print(value);
                            });
                            if (value.success) {
                              Navigator.of(context).pop();
                              SnackBarMessage
                                  .errorSnackbar(
                                  context,
                                  "Milstone Funded Successfully");
                            } else {
                              Navigator.of(context).pop();
                              SnackBarMessage.errorSnackbar(
                                  context, value.message);
                            }
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          loading
                              ? CircularProgressIndicator()
                              : Text(
                            "Submit",
                            style: TextStyle(
                              color: ColorConstant.midNight,
                              fontSize: 17,
                              fontFamily:
                              FontConstant.jakartaSemiBold,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 10),
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 4.0),
                            child: Icon(
                              Icons.arrow_forward,
                              color: ColorConstant.midNight,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: "New Milestone (Fund Escrow)",
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          titleColor: Theme.of(context).colorScheme.tertiary,
          iconColor: Theme.of(context).colorScheme.tertiary),
      body: Container(),
    );
  }
}
