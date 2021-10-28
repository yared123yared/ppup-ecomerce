import 'package:gigpoint/model/country_states.dart';
import 'package:gigpoint/webservices/repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class CountryStateBloc {
  final Repository repository;
  CountryStateBloc(this.repository);

  var subject = PublishSubject<List<StatesList>>();
  Stream<List<StatesList>> get responseData => subject.stream;
  List<StatesList> stateList = [];

  ///Call this method to get the State List.
  getStateList(String country) async {
    QueryResult result = await repository.getStateList(country);

    if (result.hasException) {
      subject.sink.addError(result.exception!.graphqlErrors[0].message);
    } else {
      CountryStates _stateList = CountryStates.fromJson(result.data!);
      stateList = _stateList.statesList!;

      subject.sink.add(stateList);
    }
  }

  @disposeMethod
  dispose() async {
    await subject.drain();
    subject.close();
  }
}
