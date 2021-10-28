import 'package:flutter/material.dart';
import 'package:gigpoint/bloc/get_balance_bloc.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';

import 'details/details_page.dart';

class RewardsSummaryPage extends StatefulWidget {
  const RewardsSummaryPage({Key? key, this.initialIndex = 0}) : super(key: key);
  final int initialIndex;

  @override
  _RewardsSummaryPageState createState() => _RewardsSummaryPageState();
}

class _RewardsSummaryPageState extends State<RewardsSummaryPage>
// with TickerProviderStateMixin
{
  // late TabController _controller;
  @override
  void initState() {
    super.initState();
    getIt<GetBalanceBloc>().getBalance(isHome: true);
    // _controller = TabController(
    //   length: 2,
    //   vsync: this,
    //   initialIndex: widget.initialIndex,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppbarWidget(title: 'GigPoint Summary', actions: []),
      // body: Column(
      //   children: [
      //     Container(
      //       color: Colors.white,
      //       child: TabBar(
      //         labelStyle:
      //             Styles.semiBold(fontSize: 14, color: AppTheme.primaryColor),
      //         unselectedLabelStyle: Styles.semiBold(fontSize: 14),
      //         unselectedLabelColor: Colors.black,
      //         labelColor: AppTheme.primaryColor,
      //         indicatorColor: AppTheme.primaryColor,
      //         indicatorSize: TabBarIndicatorSize.label,
      //         indicatorWeight: 2,
      //         controller: _controller,
      //         // ignore: prefer_const_literals_to_create_immutables
      //         tabs: [
      //           const Tab(child: Text('DETAILS')),
      //           const Tab(child: Text('SUMMARY')),
      //         ],
      //       ),
      //     ),
      //     Expanded(
      //       child: TabBarView(
      //         controller: _controller,
      //         children: const [
      //           DetailsPage(),
      //           PageUnderConstruction(),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      body: DetailsPage(),
    );
  }
}
