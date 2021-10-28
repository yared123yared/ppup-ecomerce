import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/svg_image.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PointwiseChart extends StatefulWidget {
  const PointwiseChart({Key? key}) : super(key: key);

  @override
  _PointwiseChartState createState() => _PointwiseChartState();
}

class _PointwiseChartState extends State<PointwiseChart> {
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 12),
      child: SizedBox(
        height: 320,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.all(0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Point wise',
                  style: Styles.bold(fontSize: 18),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SvgImage(
                      asset: Images.coin,
                      width: 28,
                      height: 28,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '32,000',
                      style: Styles.bold(fontSize: 22),
                    ),
                  ],
                ),
                Text(
                  'Total Pickup points',
                  style: Styles.semiBold(
                      fontSize: 12, color: AppTheme.textSecondaryColor),
                ),
                Expanded(
                  child: charts.TimeSeriesChart(
                    _createSampleData(),
                    animate: true,
                    domainAxis: const charts.DateTimeAxisSpec(
                      tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                        day: charts.TimeFormatterSpec(
                          format: 'dd',
                          transitionFormat: 'dd',
                        ),
                      ),
                    ),
                    // Set the default renderer to a bar renderer.
                    // This can also be one of the custom renderers of the time series chart.
                    defaultRenderer: charts.BarRendererConfig<DateTime>(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    List<TimeSeriesSales> data = [];
    for (var i = 1; i <= 31; i++) {
      data.add(TimeSeriesSales(DateTime(2021, 8, i), Random().nextInt(100)));
    }

    return [
      charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.Color.fromHex(code: '#E87722'),
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
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

  TimeSeriesSales(this.time, this.sales);
}
