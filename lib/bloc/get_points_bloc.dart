import 'package:gigpoint/model/points.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/webservices/repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class GetPointsBloc {
  final Repository repository;
  GetPointsBloc(this.repository);

  var subject = PublishSubject<List<PointsTransaction>>();
  Stream<List<PointsTransaction>> get responseData => subject.stream;
  List<PointsTransaction> pointsList = [];
  List<PointsTransaction> pointsList1 = [];

  ///Call this method to get the points details.
  getPoints() async {
    subject.sink.addError('loading');
    DateTime currentDate = AppUtils.getCurrentDate;
    DateTime startDate = DateTime(currentDate.year, 1, 1);

    QueryResult result = await repository.getPoints(
        startDate.millisecondsSinceEpoch, currentDate.millisecondsSinceEpoch);

    if (result.hasException) {
      subject.sink.addError(result.exception!.graphqlErrors[0].message);
    } else {
      Points points = Points.fromJson(result.data!);
      pointsList = points.points.pointsTransactions;

      pointsList.sort((a, b) => b.date!.compareTo(a.date!));

      subject.sink.add(pointsList);
    }
  }

  filteData(String filterBy, DateTime? filterByMonth, String sortBy) {
    List<PointsTransaction> filterData = [];

    if (filterBy == 'All') {
      filterData = pointsList;
    } else if (filterBy == 'Earned') {
      filterData =
          pointsList.where((element) => element.numPoints! > 0).toList();
    } else if (filterBy == 'Spent') {
      filterData =
          pointsList.where((element) => element.numPoints! < 0).toList();
    }

    if (filterByMonth != null) {
      filterData = filterData
          .where((element) => DateTime(element.date!.year, element.date!.month)
              .isAtSameMomentAs(
                  DateTime(filterByMonth.year, filterByMonth.month)))
          .toList();
    }

    if (sortBy == 'Ascending') {
      filterData.sort((a, b) {
        return a.numPoints!.compareTo(b.numPoints!);
      });
    } else if (sortBy == 'Descending') {
      filterData.sort((a, b) {
        return b.numPoints!.compareTo(a.numPoints!);
      });
    }

    subject.sink.add(filterData);
  }

  resetFilters() {
    pointsList.sort((a, b) => b.date!.compareTo(a.date!));
    subject.sink.add(pointsList);
  }

  @disposeMethod
  dispose() async {
    await subject.drain();
    subject.close();
  }
}
