import 'package:flutter/material.dart';
import 'package:gigpoint/bloc/connectivity_listner_bloc.dart';
import 'package:gigpoint/bloc/get_points_bloc.dart';
import 'package:gigpoint/model/points.dart';
import 'package:gigpoint/screens/home/rewards/details/item_card.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/errors_widget.dart';
import 'package:gigpoint/widgets/filter_modal_sheet.dart';
import 'package:gigpoint/widgets/no_data_widget.dart';
import 'package:gigpoint/widgets/no_network_wrapper.dart';
import 'package:gigpoint/widgets/svg_image.dart';
import 'package:intl/intl.dart';

import '../filter_card.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String filterBy = 'All';
  DateTime? filterByMonth;
  String sortBy = 'Sort';

  List<PointsTransaction> transactionsList = [];

  GetPointsBloc getPointsBloc = getIt<GetPointsBloc>();
  ConnectivityListnerBloc connectivityListnerBloc =
      getIt<ConnectivityListnerBloc>();

  @override
  void initState() {
    super.initState();
    getPointsBloc.getPoints();
  }

  @override
  void dispose() {
    getPointsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NoNetworkWrapper(
      onRefresh: () {
        connectivityListnerBloc.refresh().then((value) {
          if (value) {
            getPointsBloc.getPoints();
          }
        });
      },
      child: StreamBuilder<List<PointsTransaction>>(
          stream: getPointsBloc.responseData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              transactionsList = snapshot.data ?? [];
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FilterCard(
                              title: filterBy,
                              isDefault: filterBy == 'All' ? true : false,
                              onTap: () {
                                showFilterBy();
                              },
                            ),
                            const SizedBox(width: 10),
                            FilterCard(
                              title: filterByMonth == null
                                  ? 'Month'
                                  : DateFormat('MMM').format(filterByMonth!),
                              isDefault: filterByMonth == null ? true : false,
                              onTap: () {
                                showFilterByMonth();
                              },
                            ),
                            const SizedBox(width: 10),
                            FilterCard(
                              title: sortBy,
                              isDefault: sortBy == 'Sort' ? true : false,
                              onTap: () {
                                showSortBy();
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          child: Card(
                            child: transactionsList.isEmpty
                                ? const NoDataWidget(msg: 'No Transactions')
                                : ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                      thickness: 1.2,
                                      indent: index == 0 ? 0 : 20,
                                      endIndent: index == 0 ? 0 : 20,
                                    ),
                                    itemCount: transactionsList.length + 1,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    itemBuilder: (context, index) => index == 0
                                        ? Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 0, 20, 8),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text('My Activity',
                                                      style: Styles.bold(
                                                          fontSize: 16)),
                                                ),
                                                Text(
                                                  'GigPoints',
                                                  style: Styles.semiBold(
                                                      fontSize: 14,
                                                      color: const Color(
                                                          0XFF222222)),
                                                ),
                                                const SizedBox(width: 8),
                                                const SvgImage(
                                                  asset: Images.logo,
                                                  width: 24,
                                                  height: 24,
                                                )
                                              ],
                                            ),
                                          )
                                        : ItemCard(
                                            reward:
                                                transactionsList[index - 1]),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (filterBy != 'All' ||
                      filterByMonth != null ||
                      sortBy != 'Sort')
                    Container(
                      height: 60,
                      color: Colors.black.withOpacity(0.7),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${transactionsList.length} Results are found',
                              style: Styles.semiBold(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              filterBy = 'All';
                              filterByMonth = null;
                              sortBy = 'Sort';
                              getPointsBloc.resetFilters();
                            },
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all(
                                  AppTheme.primaryColor),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4))),
                            ),
                            child: Text(
                              'Reset Filter',
                              style: Styles.bold(
                                  fontSize: 16, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                ],
              );
            } else if (snapshot.hasError && snapshot.error == 'loading') {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return ErrorsWidget(msg: snapshot.error.toString());
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  showFilterBy() async {
    List<Filter> filterOptions = [
      Filter('All', 'All'),
      Filter('Earned', 'Earned'),
      Filter('Spent', 'Spent'),
    ];
    final result = await FilterModalSheet.filterBy(
        context, 'Filter By', filterOptions, filterBy);

    filterBy = result;
    getPointsBloc.filteData(filterBy, filterByMonth, sortBy);
  }

  showFilterByMonth() async {
    final result = await FilterModalSheet.filterByMonth(context, filterByMonth);
    filterByMonth = result;
    filterByMonth = result;
    getPointsBloc.filteData(filterBy, filterByMonth, sortBy);
  }

  showSortBy() async {
    List<Filter> filterOptions = [
      Filter('Ascending', 'Points- Ascending'),
      Filter('Descending', 'Points- Descending'),
    ];
    final result = await FilterModalSheet.filterBy(
        context, 'Sort By', filterOptions, sortBy);
    sortBy = result;
    getPointsBloc.filteData(filterBy, filterByMonth, sortBy);
  }
}
