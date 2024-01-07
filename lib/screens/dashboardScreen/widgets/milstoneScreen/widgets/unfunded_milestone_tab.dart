import 'package:flutter/material.dart';
import 'package:infinite_escrow/screens/dashboardScreen/widgets/milstoneScreen/widgets/custom_milestone_container.dart';

import '../model/milestone_model.dart';

class UnfundedMilestoneTab extends StatelessWidget {
  List<MilestoneModel> list = [];
  UnfundedMilestoneTab({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
