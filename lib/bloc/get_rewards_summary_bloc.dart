import 'package:gigpoint/model/home_reward_points.dart';
import 'package:gigpoint/utils/hive_helper.dart';
import 'package:gigpoint/webservices/repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class GetRewardSummaryBloc {
  final Repository repository;
  GetRewardSummaryBloc(this.repository);

  var subject = PublishSubject<RewardsSummary>();
  Stream<RewardsSummary> get responseData => subject.stream;
  RewardsSummary? rewardsSummary;

  DateTime _currentDate = DateTime.now(), _startDate = DateTime.now();
  String filterType = 'weekly';

  ///Call this method to get the reward points details.
  getRewardSummaryPoints(DateTime currentDate, DateTime startDate,
      {String type = 'weekly'}) async {
    _currentDate = currentDate;
    _startDate = startDate;
    filterType = type;
    QueryResult result = await repository.getRewardsSummery(
        startDate.millisecondsSinceEpoch, currentDate.millisecondsSinceEpoch);

    if (result.hasException) {
      subject.sink.addError(result.exception!.graphqlErrors[0].message);
    } else {
      HomeRewardPoints rewardPoints = HomeRewardPoints.fromJson(result.data!);
      rewardsSummary = rewardPoints.rewardsSummary;
      await HiveHelper.rewardSummaryBox.put(type, rewardsSummary!);
      subject.sink.add(rewardsSummary!);
    }
  }

  ///Call this method to get the reward points details.
  refreshData() async {
    RewardsSummary? _rewardsSummary =
        HiveHelper.rewardSummaryBox.get(filterType);
    if (_rewardsSummary != null) {
      subject.sink.add(_rewardsSummary);
    }
    await getRewardSummaryPoints(_currentDate, _startDate, type: filterType);
  }

  @disposeMethod
  dispose() async {
    await subject.drain();
    subject.close();
  }
}
