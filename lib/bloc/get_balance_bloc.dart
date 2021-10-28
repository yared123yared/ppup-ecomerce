import 'package:gigpoint/webservices/repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class GetBalanceBloc {
  final Repository repository;
  GetBalanceBloc(this.repository);

  var subject = BehaviorSubject<double?>();
  Stream<double?> get responseData => subject.stream;
  double pointBalance = 0;

  ///Call this method to get the balance.
  getBalance({bool isHome = false}) async {
    if (!isHome) {
      subject.sink.addError('loading');
    }
    QueryResult result = await repository.getBalance();
    if (result.hasException) {
      subject.sink.addError(result.exception!.graphqlErrors[0].message);
    } else {
      pointBalance = result.data?['balance']['balance'] ?? 0;
      subject.sink.add(pointBalance);
    }
  }

  @disposeMethod
  dispose() async {
    await subject.drain();
    subject.close();
  }
}
