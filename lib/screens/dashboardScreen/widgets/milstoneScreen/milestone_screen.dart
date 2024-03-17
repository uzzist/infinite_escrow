import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/routes/routes.dart';

import '../../../../core/messages.dart';
import 'model/milestone_model.dart';

class MilestoneScreen extends StatefulWidget {

  const MilestoneScreen({super.key});

  @override
  State<MilestoneScreen> createState() => _MilestoneScreenState();
}

class _MilestoneScreenState extends State<MilestoneScreen> {
  List<MilestoneModel> listModels = [];
  List<MilestoneModel> listPendingModels = [];
  void initState() {
    super.initState();
    var http = HttpRequest();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SnackBarMessage.showLoading(context);
      var all = http.getMilestoneList();
      var pending = http.getMilestonePendingList();
      Future.wait([all, pending]).then((value) {
        Navigator.pop(context);
        if (value[0].success == true) {
          setState(() {
            listModels = MilestoneModel.fromList(value[0].data['data']['data']);
            listPendingModels = MilestoneModel.fromList(value[1].data['data']['data']);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: customAppBar(
          title: "Milestones",
          isActionsShow: true,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            titleColor: Theme.of(context).colorScheme.tertiary,
            iconColor: Theme.of(context).colorScheme.tertiary
        ),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 36,
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: ColorConstant.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TabBar(
                      indicator: BoxDecoration(
                        color: ColorConstant.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      unselectedLabelColor: ColorConstant.black,
                      labelColor: ColorConstant.black,
                      labelStyle: TextStyle(
                          color: ColorConstant.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                      tabs: [
                        Tab(
                          child: Text(
                            "All",
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Unfunded",
                          ),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: TabBarView(
                        children: [AllMilestoneTab(list: listModels), UnfundedMilestoneTab(list: listPendingModels)])),
              ],
            )),
      ),
    );
  }
}
