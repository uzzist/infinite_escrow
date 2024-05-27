import 'package:flutter/material.dart';
import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/routes/routes.dart';
import '../../../../core/messages.dart';
import 'fund_milestone.dart';
import 'model/milestone_model.dart';

class MilestonelistScreen extends StatefulWidget {
  final int id;
  const MilestonelistScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<MilestonelistScreen> createState() => _MilestonelistScreenState();
}

class _MilestonelistScreenState extends State<MilestonelistScreen> {
  List<MilestoneModel> listModels = [];

  @override
  void initState() {
    super.initState();
    fetchMilestones();
  }

  void fetchMilestones() async {
    var http = HttpRequest();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SnackBarMessage.showLoading(context);
      print(widget.id);
      var response = await http.getMilestonesList(widget.id);
      print(response);
      Navigator.pop(context); // Hide loading indicator
      if (response.success == true) {
        setState(() {
          // Extract the list of milestones from the response
          listModels = MilestoneModel.fromList(response.data['milestones']);
        });
      } else {
        // Handle error if needed
        print(response.message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                navigateToPage(NewMileStoneScreen(
                    id: widget.id?? 0));
              },
              icon: Icon(Icons.add,color:Colors.blue),

            ),
            SizedBox(width: 8),
            Text(
              "Milestones",
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        actions: [
          // Add other actions here if needed
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: listModels.length,
                itemBuilder: (context, index) {
                  return MilestoneItemWidget(milestone: listModels[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MilestoneItemWidget extends StatelessWidget {
  final MilestoneModel milestone;

  const MilestoneItemWidget({required this.milestone});

  @override
    Widget build(BuildContext context) {
      return Card(
        child: ListTile(
          title: Text(milestone.note),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Created At: ${milestone.createdAt.toString()}"),
              SizedBox(height: 3),
              Text("Payment Status: ${milestone.getStatusString()}"),
            ],
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${milestone.methodCurrency}${milestone.amount}"),
              SizedBox(height: 2),
              ElevatedButton(
                onPressed: milestone.getStatusString() == 'Unfunded'
                    ? () {
                  navigateToPage(FundMileStoneScreen(
                      id: milestone.milestoneid?? 0));
                  // Handle Pay Now action
                }
                    : null,
                child: Text("Pay Now"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Theme.of(context).primaryColor, // Text color
                ),
              ),
            ],
          ),
        ),
      );
    }

  }
