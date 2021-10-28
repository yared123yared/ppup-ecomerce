import 'package:gigpoint/model/product_details.dart';
import 'package:gigpoint/webservices/repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class GetProductDetailsBloc {
  final Repository repository;
  GetProductDetailsBloc(this.repository);

  var subject = PublishSubject<ProductDetails>();
  Stream<ProductDetails> get responseData => subject.stream;

  ///Call this method to get the product details.
  getProductDetails(String productId) async {
    QueryResult result = await repository.getProductDetails(productId);
    if (result.hasException) {
      subject.sink.addError(result.exception!.graphqlErrors[0].message);
    } else {
      ProductDetails product = ProductDetails.fromJson(result.data!);
      subject.sink.add(product);
    }
  }

  @disposeMethod
  dispose() async {
    await subject.drain();
    subject.close();
  }
}
