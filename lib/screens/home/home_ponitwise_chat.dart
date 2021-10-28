import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:gigpoint/bloc/get_rewards_summary_bloc.dart';
import 'package:gigpoint/model/home_reward_points.dart';
import 'package:gigpoint/screens/home/rewards/rewards_summary_page.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/utils/hive_helper.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/no_data_widget.dart';
import 'package:gigpoint/widgets/points_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomePointWiseChart extends StatefulWidget {
  const HomePointWiseChart({Key? key}) : super(key: key);

  @override
  _HomePointWiseChartState createState() => _HomePointWiseChartState();
}

class _HomePointWiseChartState extends State<HomePointWiseChart> {
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';
  bool isWeekly = true;

  GetRewardSummaryBloc getRewardSummaryBloc = getIt<GetRewardSummaryBloc>();

  int? userId;

  @override
  void initState() {
    super.initState();
    if (isWeekly) {
      getRewardSummaryBloc.getRewardSummaryPoints(
          AppUtils.getCurrentDate, AppUtils.getWeeklyDate,
          type: 'weekly');
    } else {
      getRewardSummaryBloc.getRewardSummaryPoints(
          AppUtils.getCurrentDate, AppUtils.getMonthlyDate,
          type: 'monthly');
    }
    userId = HiveHelper.loginBox.get(HiveConstants.login)?.id;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 12),
      child: SizedBox(
        height: 350,
        child: GestureDetector(
          onTap: () {
            pushNewScreen(
              context,
              screen: const RewardsSummaryPage(initialIndex: 1),
              withNavBar: true,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
          child: Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            margin: const EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ValueListenableBuilder<Box<RewardsSummary>>(
                  valueListenable: HiveHelper.rewardSummaryBox.listenable(),
                  builder: (context, snapshot, widget) {
                    RewardsSummary? rewardsSummary =
                        snapshot.get(isWeekly ? 'weekly' : 'monthly');
                    List<PointsTransaction> pointsTransactions = [];
                    if (rewardsSummary != null) {
                      pointsTransactions =
                          rewardsSummary.pointsTransactions ?? [];
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GigPoint Summary',
                          style: Styles.semiBold(fontSize: 14),
                        ),
                        const SizedBox(height: 18),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0XFFECECEC),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  isWeekly = true;
                                  setState(() {});
                                  getRewardSummaryBloc.getRewardSummaryPoints(
                                      AppUtils.getCurrentDate,
                                      AppUtils.getWeeklyDate,
                                      type: 'weekly');
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: isWeekly
                                          ? AppTheme.primaryColor
                                          : const Color(0XFFECECEC),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    'Weekly',
                                    style: Styles.semiBold(
                                        fontSize: 12,
                                        color: isWeekly
                                            ? AppTheme.cardBackgroundColor
                                            : AppTheme.textPrimaryColor),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  isWeekly = false;
                                  setState(() {});
                                  getRewardSummaryBloc.getRewardSummaryPoints(
                                      AppUtils.getCurrentDate,
                                      AppUtils.getMonthlyDate,
                                      type: 'monthly');
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: isWeekly
                                          ? const Color(0XFFECECEC)
                                          : AppTheme.primaryColor,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    'Monthly',
                                    style: Styles.semiBold(
                                        fontSize: 12,
                                        color: isWeekly
                                            ? AppTheme.textPrimaryColor
                                            : AppTheme.cardBackgroundColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 23),
                        PointsWidget(
                          points: rewardsSummary == null
                              ? 0
                              : rewardsSummary.totalPoints ?? 0,
                          fontSize: 22,
                          iconSize: 20,
                          pointsColor: AppTheme.textPrimaryColor,
                        ),
                        (isWeekly)
                            ? Text(
                                'Earned this Week',
                                style: Styles.semiBold(
                                    fontSize: 12,
                                    color: AppTheme.textSecondaryColor),
                              )
                            : Text(
                                'Earned this Month',
                                style: Styles.semiBold(
                                    fontSize: 12,
                                    color: AppTheme.textSecondaryColor),
                              ),
                        Expanded(
                          child: rewardsSummary == null
                              ? const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : rewardsSummary.pointsTransactions?.isEmpty ??
                                      false
                                  ? NoDataWidget(
                                      msg: isWeekly
                                          ? 'No Earnings for this Week'
                                          : 'No Earnings for this Month',
                                    )
                                  : AbsorbPointer(
                                      absorbing: true,
                                      child: charts.TimeSeriesChart(
                                        (isWeekly)
                                            ? _createWeeklyData(
                                                pointsTransactions)
                                            : _createMonthlyData(
                                                pointsTransactions),
                                        animate: false,
                                        primaryMeasureAxis:
                                            const charts.NumericAxisSpec(
                                          tickProviderSpec: charts
                                              .BasicNumericTickProviderSpec(
                                            desiredMinTickCount: 7,
                                            desiredTickCount: 7,
                                          ),
                                        ),
                                        secondaryMeasureAxis:
                                            const charts.NumericAxisSpec(
                                          tickProviderSpec: charts
                                              .BasicNumericTickProviderSpec(
                                            desiredMinTickCount: 5,
                                          ),
                                        ),
                                        domainAxis: charts.DateTimeAxisSpec(
                                          showAxisLine: false,
                                          tickFormatterSpec: charts
                                              .AutoDateTimeTickFormatterSpec(
                                            day: (isWeekly)
                                                ? const charts
                                                    .TimeFormatterSpec(
                                                    format: 'E',
                                                    transitionFormat: 'E',
                                                  )
                                                : const charts
                                                    .TimeFormatterSpec(
                                                    format: 'dd',
                                                    transitionFormat: 'dd',
                                                  ),
                                          ),
                                        ),
                                        // Set the default renderer to a bar renderer.
                                        // This can also be one of the custom renderers of the time series chart.
                                        defaultRenderer: charts
                                            .BarRendererConfig<DateTime>(),
                                        // It is recommended that default interactions be turned off if using bar
                                        // renderer, because the line point highlighter is the default for time
                                        // series chart.
                                        defaultInteractions: false,
                                        // If default interactions were removed, optionally add select nearest
                                        // and the domain highlighter that are typical for bar charts.
                                        behaviors: [
                                          charts.SelectNearest(),
                                          charts.DomainHighlighter()
                                        ],
                                      ),
                                    ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }

  int daysInMonth(DateTime date) =>
      DateUtils.getDaysInMonth(date.year, date.month);

  /// Create monthly data.
  List<charts.Series<TimeSeriesSales, DateTime>> _createMonthlyData(
      List<PointsTransaction> pointsTransactions) {
    List<TimeSeriesSales> data = [];

    for (int i = 1; i <= daysInMonth(AppUtils.getCurrentDate); i++) {
      DateTime currentDay = DateTime(
          AppUtils.getCurrentDate.year, AppUtils.getCurrentDate.month, i);
      PointsTransaction transaction = pointsTransactions.singleWhere(
          (element) => AppUtils.dateWithoutTime(element.date!)
              .isAtSameMomentAs(AppUtils.dateWithoutTime(currentDay)),
          orElse: () => PointsTransaction());
      if (transaction.date == null) {
        data.add(TimeSeriesSales(
            currentDay, 0, DateFormat('EEEE').format(currentDay)));
      } else {
        data.add(TimeSeriesSales(
            transaction.date!,
            transaction.numPoints!.toInt(),
            DateFormat('EEEE').format(transaction.date!)));
      }
    }
    if (!mounted) setState(() {});
    return [
      charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.Color.fromHex(code: '#E87722'),
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
        fillColorFn: (_, __) => charts.Color.fromHex(code: '#E87722'),
      )
        // Set series to use the secondary measure axis.
        ..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId),
    ];
  }

  /// Create weekly data.
  List<charts.Series<TimeSeriesSales, DateTime>> _createWeeklyData(
      List<PointsTransaction> pointsTransactions) {
    List<TimeSeriesSales> data = [];
    int diffDays =
        AppUtils.getCurrentDate.difference(AppUtils.getWeeklyDate).inDays;
    for (int i = 0; i <= diffDays; i++) {
      DateTime currentDay = AppUtils.dateWithoutTime(
          AppUtils.getWeeklyDate.add(Duration(days: i)));
      PointsTransaction transaction = pointsTransactions.singleWhere(
          (element) => AppUtils.dateWithoutTime(element.date!)
              .isAtSameMomentAs(currentDay),
          orElse: () => PointsTransaction());
      if (transaction.date == null) {
        data.add(TimeSeriesSales(
            currentDay, 0, DateFormat('EEE').format(currentDay)));
      } else {
        data.add(TimeSeriesSales(
            transaction.date!,
            transaction.numPoints!.toInt(),
            DateFormat('EEE').format(transaction.date!)));
      }
    }
    if (!mounted) setState(() {});

    return [
      charts.Series<TimeSeriesSales, DateTime>(
        id: 'Weekly',
        colorFn: (_, __) => charts.Color.fromHex(code: '#E87722'),
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
        fillColorFn: (_, __) => charts.Color.fromHex(code: '#E87722'),
      )
        // Set series to use the secondary measure axis.
        ..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId),
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;
  final String day;

  TimeSeriesSales(this.time, this.sales, this.day);
}
