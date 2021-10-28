import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gigpoint/bloc/connectivity_listner_bloc.dart';
import 'package:gigpoint/bloc/shop/filters_bloc.dart';
import 'package:gigpoint/bloc/shop/get_categores_bloc.dart';
import 'package:gigpoint/bloc/shop/get_sub_categories_bloc.dart';
import 'package:gigpoint/model/categories.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/webservices/graphql_api_client.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';
import 'package:gigpoint/widgets/button_widget.dart';
import 'package:gigpoint/widgets/custom_checkbox.dart';
import 'package:gigpoint/widgets/custom_radio_button.dart';
import 'package:gigpoint/widgets/filter_modal_sheet.dart';
import 'package:gigpoint/widgets/filter_selection_card.dart';
import 'package:gigpoint/widgets/no_data_widget.dart';
import 'package:gigpoint/widgets/no_network_wrapper.dart';
import 'package:gigpoint/widgets/outline_button_widget.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'categories_widget.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({Key? key, required this.isFromProductsList})
      : super(key: key);

  final bool isFromProductsList;

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  Filters appliedFilters = Filters();
  ConnectivityListnerBloc connectivityListnerBloc =
      getIt<ConnectivityListnerBloc>();

  FiltersBloc filtersBloc = getIt<FiltersBloc>();
  GraphQLApiClient graphQLApiClient = getIt<GraphQLApiClient>();
  List<String> selectedSubCategories = [];
  bool showViewAll = false;
  final List<Filter> sortByList = [
    Filter('popularity', 'Popularity', '0'), //For Descending
    Filter('finalCost', 'Points- Ascending', '1'), //For Ascending
    Filter('finalCost', 'Points- Descending', '2'), //For Descending
    Filter('sortableTitle.keyword', 'A-Z', '3'), //For Ascending
    Filter('sortableTitle.keyword', 'Z-A', '4'), //For Descending
  ];

  bool viewAll = false;

  RangeValues _currentRangeValues = const RangeValues(0, 25000);

  @override
  void initState() {
    super.initState();
    Filters data = filtersBloc.getFilters();
    _currentRangeValues = RangeValues(
        data.startPrice ?? Constants.MIN_PRICE_RANGE,
        data.endPrice ?? Constants.MAX_PRICE_RANGE);
    selectedSubCategories = data.subCategories ?? [];
    if (data.categoryId != null) {
      getIt<GetSubCategoriesBloc>().getSubCategories(data.categoryId!);
    }
    if (!widget.isFromProductsList) {
      selectedSubCategories = [];
      _currentRangeValues = const RangeValues(
          Constants.MIN_PRICE_RANGE, Constants.MAX_PRICE_RANGE);
      filtersBloc.clearFilters();
    }
  }

  Future<bool> _onBackPressed() async {
    if (!hasFilters && widget.isFromProductsList) {
      Navigator.pop(context, 'close');
    } else {
      Navigator.pop(context);
    }
    appliedFilters.subCategories = selectedSubCategories;
    filtersBloc.addFilters(appliedFilters);
    return Future.value(false);
  }

  applyFilters() {
    Filters filters = Filters();
    filters.id = appliedFilters.id;
    filters.categoryId = appliedFilters.categoryId;
    filters.categoryName = appliedFilters.categoryName;
    filters.sortBy = appliedFilters.sortBy ?? 'popularity';
    filters.sortOrder = appliedFilters.sortOrder ?? 'asc';
    filters.startPrice = _currentRangeValues.start;
    filters.endPrice = _currentRangeValues.end;
    filters.subCategories = appliedFilters.subCategories;
    filtersBloc.addFilters(filters);

    filtersBloc.applyFilters(context, filters);
  }

  resetFilters() {
    selectedSubCategories = [];
    _currentRangeValues = const RangeValues(0, Constants.MAX_PRICE_RANGE);
    filtersBloc.clearFilters();
  }

  Widget categoriesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Category',
            style: Styles.bold(fontSize: 18),
          ),
          const SizedBox(height: 20),
          StreamBuilder<List<Category>>(
              stream: getIt<GetCategoriesBloc>().responseData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      for (var i = 0; i < snapshot.data!.length; i++)
                        FilterSelectionCard(
                          title: snapshot.data![i].title,
                          asset: categoryImages[i],
                          fontSize: 14,
                          isSelected: appliedFilters.categoryId ==
                              snapshot.data![i].name,
                          onTap: () {
                            appliedFilters.categoryId = snapshot.data![i].name;
                            appliedFilters.categoryName =
                                snapshot.data![i].title;
                            filtersBloc.addFilters(appliedFilters);
                            appliedFilters.subCategories = [];
                            selectedSubCategories = [];
                            getIt<GetSubCategoriesBloc>()
                                .getSubCategories(snapshot.data![i].name);
                          },
                        )
                    ],
                  );
                } else if (snapshot.hasError && snapshot.error == 'loading') {
                  return const LinearProgressIndicator();
                }
                return const LinearProgressIndicator();
              })
        ],
      ),
    );
  }

  Widget subCategoriesSection() {
    return StreamBuilder<List<Category>>(
        stream: getIt<GetSubCategoriesBloc>().responseData,
        builder: (context, snapshot) {
          List<Category> subCategories = [];
          if (snapshot.hasData) {
            subCategories = snapshot.data ?? [];
            showViewAll = subCategories.length > 6 ? true : false;
          }
          return Padding(
            padding: const EdgeInsets.fromLTRB(6, 0, 16, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sub Category',
                          style: Styles.bold(fontSize: 18),
                        ),
                        if (appliedFilters.categoryId != null && showViewAll)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                viewAll = !viewAll;
                              });
                            },
                            child: Text(
                              viewAll ? 'View Less' : 'View All',
                              style: Styles.bold(
                                  fontSize: 14, color: AppTheme.primaryColor),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                (appliedFilters.categoryId == null)
                    ? Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          'Select a Category first',
                          style: Styles.semiBold(
                              fontSize: 14, color: AppTheme.textSecondaryColor),
                        ),
                      )
                    : snapshot.hasData
                        ? subCategories.isEmpty
                            ? const NoDataWidget(
                                msg: 'No Sub Categories Found',
                              )
                            : Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                alignment: WrapAlignment.start,
                                direction: Axis.horizontal,
                                children: [
                                  for (int i = 0;
                                      i < subCatLength(subCategories);
                                      i++)
                                    CustomCheckbox(
                                      title: subCategories[i].title,
                                      value: appliedFilters.subCategories!
                                          .contains(subCategories[i].name),
                                      onChanged: (val) {
                                        onSubCategoryChange(
                                            subCategories[i].name);
                                      },
                                      onTap: () {
                                        onSubCategoryChange(
                                            subCategories[i].name);
                                      },
                                    )
                                ],
                              )
                        : (snapshot.hasError && snapshot.error == 'loading')
                            ? const LinearProgressIndicator()
                            : Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  'Select a Category first',
                                  style: Styles.semiBold(
                                      fontSize: 14,
                                      color: AppTheme.textSecondaryColor),
                                ),
                              )
              ],
            ),
          );
        });
  }

  void onSubCategoryChange(String subCatId) {
    ///Get all the selected Sub Cats from filters.
    List<String> data = appliedFilters.subCategories?.toList() ?? [];
    if (data.contains(subCatId)) {
      data.remove(subCatId);
    } else {
      data.add(subCatId);
    }
    appliedFilters.subCategories = data;
    filtersBloc.addFilters(appliedFilters);
  }

  int subCatLength(List<Category> subCats) {
    int count = subCats.length;
    return (count > 6 && !viewAll) ? 6 : count;
  }

  Widget pointsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Points',
            style: Styles.bold(fontSize: 18),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
              child: Row(
                children: [
                  Text(
                    _currentRangeValues.start.round().toString(),
                    style: Styles.semiBold(fontSize: 14),
                  ),
                  Expanded(
                    child: RangeSlider(
                      values: _currentRangeValues,
                      min: 0,
                      max: Constants.MAX_PRICE_RANGE,
                      divisions: Constants.MAX_PRICE_RANGE.toInt(),
                      activeColor: AppTheme.primaryColor,
                      onChanged: (RangeValues values) {
                        setState(() {
                          _currentRangeValues = values;
                        });
                      },
                    ),
                  ),
                  Text(
                    _currentRangeValues.end.round().toString(),
                    style: Styles.semiBold(fontSize: 14),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget sortSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Sort By',
              style: Styles.bold(fontSize: 18),
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            children: [
              for (Filter item in sortByList)
                CustomRadioButton(
                  title: item.value,
                  value: item.id!,
                  groupValue: appliedFilters.id ?? '0',
                  onChanged: (val) => onSortByChange(val),
                  onTap: () => onSortByChange(item.id!),
                ),
            ],
          )
        ],
      ),
    );
  }

  void onSortByChange(String value) {
    appliedFilters.id = value;
    appliedFilters.sortBy =
        sortByList.singleWhere((element) => element.id == value).key;

    appliedFilters.sortOrder = (value == '1' || value == '3') ? 'asc' : 'desc';

    filtersBloc.addFilters(appliedFilters);
  }

  bool get hasFilters {
    return (appliedFilters.categoryId != null ||
            _currentRangeValues.start != 0 ||
            _currentRangeValues.end != Constants.MAX_PRICE_RANGE ||
            appliedFilters.sortBy != 'popularity')
        ? true
        : false;
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: getIt<GraphQLApiClient>().client,
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: StreamBuilder<Filters>(
            stream: filtersBloc.responseData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                appliedFilters = snapshot.data!.copyWith();
              }
              return SafeArea(
                top: false,
                child: Scaffold(
                  appBar: AppbarWidget(
                    title: 'Filter',
                    leading: GestureDetector(
                        onTap: () => _onBackPressed(),
                        child: Icon(Platform.isAndroid
                            ? Icons.arrow_back
                            : Icons.arrow_back_ios)),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: TextButton(
                          onPressed: hasFilters
                              ? () {
                                  resetFilters();
                                }
                              : null,
                          child: Text(
                            'Reset',
                            style: Styles.bold(
                              fontSize: 14,
                              color: hasFilters
                                  ? AppTheme.primaryColor
                                  : AppTheme.disabledColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  bottomNavigationBar: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlineButtonWidget(
                              name: 'Close',
                              onTap: () => _onBackPressed(),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ButtonWidget(
                              name: 'Apply',
                              isActive: hasFilters,
                              onTap: () {
                                applyFilters();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  body: NoNetworkWrapper(
                    onRefresh: () {
                      connectivityListnerBloc.refresh().then((value) {
                        if (value) {
                          getIt<GetCategoriesBloc>().getCategories();
                        }
                      });
                    },
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        const SizedBox(height: 28),
                        categoriesSection(),
                        const SizedBox(height: 36),
                        subCategoriesSection(),
                        const SizedBox(height: 36),
                        pointsSection(),
                        const SizedBox(height: 36),
                        sortSection()
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
