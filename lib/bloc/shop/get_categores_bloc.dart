import 'package:gigpoint/model/categories.dart';
import 'package:gigpoint/webservices/repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class GetCategoriesBloc {
  final Repository repository;
  GetCategoriesBloc(this.repository);

  var subject = BehaviorSubject<List<Category>>();
  Stream<List<Category>> get responseData => subject.stream;

  ///Call this method to get the categories.
  getCategories() async {
    QueryResult result = await repository.getCategories();
    if (result.hasException) {
      subject.sink.addError(result.exception!.graphqlErrors[0].message);
    } else {
      Categories categories = Categories.fromJson(result.data!);
      subject.sink.add(categories.categoriesByStore.categories);
    }
  }

  @disposeMethod
  dispose() async {
    await subject.drain();
    subject.close();
  }
}
