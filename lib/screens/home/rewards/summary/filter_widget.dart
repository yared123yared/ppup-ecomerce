import 'package:flutter/material.dart';
import 'package:gigpoint/screens/home/rewards/filter_card.dart';
import 'package:gigpoint/widgets/filter_modal_sheet.dart';
import 'package:intl/intl.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  String filterBy = 'Earning';
  String sortBy = 'Monthly';
  DateTime? filterByMonth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FilterCard(
          title: filterBy,
          onTap: () {
            showFilterBy();
          },
        ),
        const SizedBox(width: 10),
        FilterCard(
          title: sortBy,
          onTap: () {
            showSortBy();
          },
        ),
        const SizedBox(width: 10),
        FilterCard(
          title: filterByMonth == null
              ? 'Month'
              : DateFormat('MMM').format(filterByMonth!),
          onTap: () {
            showFilterByMonth();
          },
        ),
      ],
    );
  }

  showFilterBy() async {
    List<Filter> filterOptions = [
      Filter('Earning', 'Earning'),
      Filter('Spending', 'Spending'),
    ];
    final result = await FilterModalSheet.filterBy(
        context, 'Filter By', filterOptions, filterBy);
    filterBy = result;
    setState(() {});
  }

  showFilterByMonth() async {
    final result = await FilterModalSheet.filterByMonth(context, filterByMonth);
    filterByMonth = result;
    setState(() {});
  }

  showSortBy() async {
    List<Filter> filterOptions = [
      Filter('Monthly', 'Month'),
      Filter('Weekly', 'Week'),
    ];
    final result = await FilterModalSheet.filterBy(
        context, 'Filter By', filterOptions, sortBy);
    sortBy = result;
    setState(() {});
  }
}
