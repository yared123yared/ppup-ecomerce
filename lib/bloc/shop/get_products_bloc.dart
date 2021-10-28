import 'package:gigpoint/bloc/helpers/pagination_loading_bloc.dart';
import 'package:gigpoint/model/products.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/webservices/repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class GetProductsBloc {
  final Repository repository;
  GetProductsBloc(this.repository);

  var subject = PublishSubject<List<Product>>();
  Stream<List<Product>> get responseData => subject.stream.distinct();

  PaginationLoadingBloc paginationLoadingBloc = getIt<PaginationLoadingBloc>();

  ///Call this method to get the products.
  getProducts({
    required int startItem,
    String? sortBy,
    String? sortDirection,
    String? category,
    double? startPrice,
    double? endPrice,
    List<String>? subCategories,
  }) async {
    ///Here passing error to the stream.
    ///Use this as the loading status.
    ///Call this only if startItem is 1.
    if (startItem == 1) {
      subject.sink.addError('loading');
    } else {
      paginationLoadingBloc.showLoading();
    }
    QueryResult result = await repository.getProducts(
      startItem: startItem,
      sortBy: sortBy,
      sortDirection: sortDirection,
      category: category,
      startPrice: startPrice?.toInt(),
      endPrice: endPrice?.toInt(),
      subCategories: subCategories,
    );
    if (result.hasException) {
      subject.sink.addError(result.exception!.graphqlErrors[0].message);
      paginationLoadingBloc.stopLoading();
    } else {
      Products products = Products.fromJson(result.data!);
      subject.sink.add(products.productByStore.products);
      paginationLoadingBloc.stopLoading();
    }
  }

  @disposeMethod
  dispose() async {
    await subject.drain();
    subject.close();
  }
}
