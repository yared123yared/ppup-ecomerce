import 'package:gigpoint/model/products.dart';
import 'package:gigpoint/webservices/repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class SearchProductsBloc {
  final Repository repository;
  SearchProductsBloc(this.repository);

  var subject = PublishSubject<List<Product>>();
  Stream<List<Product>> get responseData => subject.stream.distinct();

  ///Call this method to get the products.
  getProducts(int startItem, String keyword) async {
    if (keyword.length == 1) {
      subject.sink.addError('loading');
    }
    QueryResult result = await repository.searchProducts(startItem, keyword);
    if (result.hasException) {
      subject.sink.addError(result.exception!.graphqlErrors[0].message);
    } else {
      Products products = Products.fromJson(result.data!);
      subject.sink.add(products.productByStore.products);
    }
  }

  clearResults() => subject.sink.add([]);

  @disposeMethod
  dispose() async {
    await subject.drain();
    subject.close();
  }
}
