import 'package:flutter/material.dart';
import 'package:gigpoint/screens/home/rewards/summary/pointwise_chart.dart';

import 'category_wise_earnings.dart';
import 'filter_widget.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const FilterWidget(),
        const PointwiseChart(),
        const CategoryWiseEarnings(),
      ],
    );
  }
}
