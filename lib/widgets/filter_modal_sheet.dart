import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:intl/intl.dart';

import 'filter_selection_card.dart';

class FilterModalSheet {
  static Future<String> filterBy(BuildContext context, String title,
      List<Filter> filterOptions, String selected) async {
    await showModalBottomSheet(
        context: context,
        isDismissible: false,
        useRootNavigator: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            )),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: Styles.semiBold(fontSize: 20),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  for (Filter item in filterOptions)
                    RadioListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(
                        item.value,
                        style: Styles.semiBold(fontSize: 16),
                      ),
                      value: item.key,
                      groupValue: selected,
                      onChanged: (val) {
                        selected = item.key;
                        Navigator.pop(context);
                      },
                    ),
                ],
              ),
            ),
          );
        });
    return selected;
  }

  static Future<List<String>> filterByMultiSelect(BuildContext context,
      String title, List<Filter> filterOptions, List<String> selected) async {
    await showModalBottomSheet(
        context: context,
        isDismissible: false,
        useRootNavigator: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            )),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: Styles.semiBold(fontSize: 20),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  for (Filter item in filterOptions)
                    GestureDetector(
                      onTap: () {
                        if (selected.contains(item.key)) {
                          selected.remove(item.key);
                        } else {
                          selected.add(item.key);
                        }
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: selected.contains(item.key) ? true : false,
                            onChanged: (val) {
                              if (selected.contains(item.key)) {
                                selected.remove(item.key);
                              } else {
                                selected.add(item.key);
                              }
                              Navigator.pop(context);
                            },
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                          Flexible(
                            child: Text(
                              item.value,
                              style: Styles.semiBold(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          );
        });
    return selected;
  }

  static Future<DateTime?> filterByMonth(
      BuildContext context, DateTime? selected) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filter By Month',
                        style: Styles.semiBold(fontSize: 20),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                GridView.builder(
                  itemCount: 12,
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final DateTime currentMonth =
                        DateTime(DateTime.now().year, index + 1, 1);
                    return FilterSelectionCard(
                      title: DateFormat('MMM').format(currentMonth),
                      fontSize: 16,
                      isSelected: selected == currentMonth,
                      onTap: () {
                        selected = currentMonth;
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ],
            ),
          );
        });
    return selected;
  }
}

class Filter {
  final String? id;
  final String key, value;

  Filter(this.key, this.value, [this.id]);
}
