import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gigpoint/bloc/connectivity_listner_bloc.dart';
import 'package:gigpoint/bloc/get_balance_bloc.dart';
import 'package:gigpoint/bloc/get_rewards_summary_bloc.dart';
import 'package:gigpoint/dialog/first_time_bonus_dialog.dart';
import 'package:gigpoint/model/home_reward_points.dart';
import 'package:gigpoint/model/login.dart';
import 'package:gigpoint/screens/home/profile_info_widget.dart';
import 'package:gigpoint/screens/home/reward_points_widget.dart';
import 'package:gigpoint/screens/home/unlock_rewards_widget.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/utils/hive_helper.dart';
import 'package:gigpoint/widgets/no_network_wrapper.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'categories_section.dart';
import 'home_ponitwise_chat.dart';
import 'in_demand_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? userId;
  GetBalanceBloc getBalanceBloc = getIt<GetBalanceBloc>();
  GetRewardSummaryBloc getRewardSummaryBloc = getIt<GetRewardSummaryBloc>();
  ConnectivityListnerBloc connectivityListnerBloc =
      getIt<ConnectivityListnerBloc>();

  @override
  void initState() {
    super.initState();
    LoginClass? login = HiveHelper.loginBox.get(HiveConstants.login);
    bool isFirstTimeUser = login?.isFirstTime ?? false;
    userId = login?.id;

    SchedulerBinding.instance?.addPostFrameCallback((_) async {
      Future.delayed(const Duration(seconds: 1), () {
        if (isFirstTimeUser) {
          AppUtils.dialogBuilder(context, const FirstTimeBonusDialog());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return NoNetworkWrapper(
      onRefresh: () {
        connectivityListnerBloc.refresh().then((value) {
          if (value) {
            getBalanceBloc.getBalance();
          }
        });
      },
      child: SafeArea(
        child: Scaffold(
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 5, 12, 0),
                child: Column(
                  children: [
                    const ProfileInfoWidget(),
                    const SizedBox(height: 20),
                    StreamBuilder<double?>(
                        stream: getIt<GetBalanceBloc>().responseData,
                        builder: (context, snapshot) {
                          getRewardSummaryBloc.refreshData();
                          return RewardPointsWidget(points: snapshot.data ?? 0);
                        }),
                    ValueListenableBuilder<Box<RewardsSummary>>(
                        valueListenable:
                            HiveHelper.rewardSummaryBox.listenable(),
                        builder: (context, box, _) {
                          return box.isEmpty
                              ? const SizedBox()
                              : (box.values.first.isFirstTimeUser ?? false)
                                  ? const SizedBox()
                                  : const HomePointWiseChart();
                        }),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
              const CategoriesSection(),
              const SizedBox(height: 36),
              const UnlockRewardsWidget(),
              const SizedBox(height: 36),
              const InDemandWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
