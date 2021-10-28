import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/webservices/repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class FiltersBloc {
  final Repository repository;
  FiltersBloc(this.repository);

  var subject = BehaviorSubject<Filters>();
  Stream<Filters> get responseData => subject.stream;

  ///Initialize the Filters variable.
  ///Storing selected filters in local variable to access.
  Filters filters = Filters(sortBy: 'popularity', sortOrder: 'asc', id: '0');

  ///Call this method when user selects new filter.
  addFilters(Filters _filters) {
    subject.sink.add(_filters);
  }

  ///Call this method to apply the filters.
  applyFilters(BuildContext context, Filters _filters,
      {bool isFromProducts = false}) async {
    /*print('Filter bloc');
    print(_filters.startPrice);
    print(_filters.endPrice);*/
    filters = _filters;

    subject.sink.add(filters);
    if (!isFromProducts) {
      ///Send the result back to the page.
      Navigator.pop(context, filters);
    }
  }

  ///Call this method to reset all the filters.
  clearFilters() {
    filters = Filters(
      sortBy: 'popularity',
      sortOrder: 'asc',
      startPrice: 0,
      endPrice: Constants.MAX_PRICE_RANGE,
      subCategories: [],
    );
    subject.sink.add(filters);
  }

  ///Call this method to get applied filters.
  Filters getFilters() {
    subject.sink.add(filters);
    return filters;
  }

  @disposeMethod
  dispose() async {
    await subject.drain();
    subject.close();
  }
}

class Filters {
  Filters({
    this.categoryName,
    this.categoryId,
    this.sortBy,
    this.sortOrder,
    this.id,
    this.startPrice,
    this.endPrice,
    this.subCategories,
  });

  String? categoryName;
  String? categoryId;
  String? sortBy;
  String? sortOrder;
  String? id;
  double? startPrice;
  double? endPrice;
  List<String>? subCategories;

  Filters copyWith({
    String? categoryName,
    String? categoryId,
    String? sortBy,
    String? sortOrder,
    String? id,
    double? startPrice,
    double? endPrice,
    List<String>? subCategories,
  }) =>
      Filters(
        categoryName: categoryName ?? this.categoryName,
        categoryId: categoryId ?? this.categoryId,
        sortBy: sortBy ?? this.sortBy,
        sortOrder: sortOrder ?? this.sortOrder,
        id: id ?? this.id,
        endPrice: this.endPrice,
        startPrice: this.startPrice,
        subCategories: this.subCategories,
      );
}
