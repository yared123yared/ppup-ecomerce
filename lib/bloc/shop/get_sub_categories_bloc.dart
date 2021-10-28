import 'package:gigpoint/model/categories.dart';
import 'package:gigpoint/webservices/repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class GetSubCategoriesBloc {
  final Repository repository;

  GetSubCategoriesBloc(this.repository);

  var subject = BehaviorSubject<List<Category>>();
  Stream<List<Category>> get responseData => subject.stream;

  ///Call this method to get the categories.
  getSubCategories(String category) async {
    subject.sink.addError('loading');
    QueryResult result = await repository.getSubCategories(category);
    if (result.hasException) {
      subject.sink.addError(result.exception!.graphqlErrors[0].message);
    } else {
      Categories data = Categories.fromJson(result.data!);
      List<Category> categories = data.categoriesByStore.categories;
      subject.sink.add(categories);
    }
  }

  @disposeMethod
  dispose() async {
    await subject.drain();
    subject.close();
  }
}
