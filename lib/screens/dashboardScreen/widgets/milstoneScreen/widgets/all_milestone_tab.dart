import 'package:infinite_escrow/routes/routes.dart';

import '../model/milestone_model.dart';


class AllMilestoneTab extends StatelessWidget {
  List<MilestoneModel> list = [];
  AllMilestoneTab({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for(var i in list) Padding(padding: EdgeInsets.only(bottom: 10), child:
          customMilestoneContainer(
            containerColor:i.getStatusColor(),
            containerTitle: i.getStatusString(),
            price: i.amount, currency: i.methodCurrency,
            date: i.createdAt, note: i.note, id: i.id,
          ),)
        ],
      ),
    );
  }
}
