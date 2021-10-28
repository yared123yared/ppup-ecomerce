import 'package:gigpoint/model/address.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/hive_helper.dart';
import 'package:gigpoint/webservices/graphql_api_client.dart';
import 'package:gigpoint/webservices/queries/address_queries.dart';
import 'package:gigpoint/webservices/queries/authentication_queries.dart';
import 'package:gigpoint/webservices/queries/contact_us_queries.dart';
import 'package:gigpoint/webservices/queries/reward_queries.dart';
import 'package:gigpoint/webservices/queries/shop_queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class Repository {
  final GraphQLApiClient client;
  Repository(this.client);

  Future<QueryResult> login(String email, String password) async {
    final QueryResult result = await client.query(
      query: AuthQueries.login,
      variables: {
        'email': email,
        'password': password,
      },
    );
    return result;
  }

  Future<QueryResult> updateTermsAndConditions(bool isAccepted) async {
    final QueryResult result = await client.query(
      query: AuthQueries.updateTermsAndConditions,
      variables: {
        'userId': HiveHelper.loginBox.get(HiveConstants.login)?.id,
        'isAccepted': isAccepted,
      },
    );
    return result;
  }

  Future<QueryResult> getBalance() async {
    final QueryResult result = await client.query(
      query: RewardQueries.getBalance,
      variables: {
        'userId': HiveHelper.loginBox.get(HiveConstants.login)?.id,
      },
    );
    return result;
  }

  Future<QueryResult> getPoints(int startDate, int endDate) async {
    final QueryResult result = await client.query(
      query: RewardQueries.getPoints,
      variables: {
        'userId': HiveHelper.loginBox.get(HiveConstants.login)?.id,
        'startDate': startDate,
        'endDate': endDate,
      },
    );
    return result;
  }

  Future<QueryResult> getCategories() async {
    final QueryResult result =
        await client.query(query: ShopQueries.getCategories);
    return result;
  }

  Future<QueryResult> getSubCategories(String category) async {
    final QueryResult result = await client.query(
      query: ShopQueries.getSubCategories,
      variables: {
        'cat1': category,
      },
    );
    return result;
  }

  Future<QueryResult> getProducts({
    required int startItem,
    String? sortBy,
    String? sortDirection,
    String? category,
    int? startPrice,
    int? endPrice,
    List<String>? subCategories,
  }) async {
    final QueryResult result = await client.query(
      query: category != null
          ? ShopQueries.getProductsByCategory
          : ShopQueries.getProducts,
      variables: {
        'start': startItem,
        'maxRows': Constants.DEFAULT_PAGINATION_COUNT,
        'sortBy': sortBy ?? 'popularity',
        'sortDirection': sortDirection ?? 'asc',
        'categories': subCategories!.isNotEmpty
            ? subCategories.join(',')
            : category ?? '',
        'startPrice': startPrice ?? Constants.MIN_PRICE_RANGE,
        'endPrice': endPrice ?? Constants.MAX_PRICE_RANGE
      },
    );
    return result;
  }

  Future<QueryResult> getProductDetails(String productId) async {
    final QueryResult result = await client.query(
      query: ShopQueries.getProductDetails,
      variables: {'productId': productId},
    );
    return result;
  }

  Future<QueryResult> searchProducts(int startItem, String keyword) async {
    final QueryResult result = await client.query(
      query: ShopQueries.getSearchedProduct,
      variables: {
        'search': keyword,
        'start': startItem,
        'maxRows': Constants.DEFAULT_PAGINATION_COUNT,
      },
    );
    return result;
  }

  Future<QueryResult> getAddress() async {
    final QueryResult result = await client.query(
      query: AddressQueries.getAddress,
      variables: {
        'userId': HiveHelper.loginBox.get(HiveConstants.login)?.id,
      },
    );
    return result;
  }

  Future<QueryResult> addAddress(AddressList addressList) async {
    addressList.userId = HiveHelper.loginBox.get(HiveConstants.login)?.id;
    final QueryResult result = await client.query(
      query: AddressQueries.addAddress,
      variables: addressList.toJson(),
    );
    return result;
  }

  Future<QueryResult> editAddress(AddressList addressList) async {
    addressList.userId = HiveHelper.loginBox.get(HiveConstants.login)?.id;
    final QueryResult result = await client.query(
      query: AddressQueries.editAddress,
      variables: addressList.toJson(),
    );
    return result;
  }

  Future<QueryResult> deleteAddress(int id) async {
    final QueryResult result = await client.query(
      query: AddressQueries.deleteAddress,
      variables: {
        'userId': HiveHelper.loginBox.get(HiveConstants.login)?.id,
        'id': id
      },
    );
    return result;
  }

  Future<QueryResult> getStateList(String country) async {
    final QueryResult result = await client.query(
      query: AddressQueries.getStateList,
      variables: {
        'country': country,
      },
    );
    return result;
  }

  Future<QueryResult> checkSessionStatus() async {
    final QueryResult result = await client.query(
      query: AuthQueries.checkSessionStatus,
    );
    return result;
  }

  Future<QueryResult> getRewardsSummery(int startDate, int endDate) async {
    final QueryResult result = await client.query(
      query: RewardQueries.getRewardsSummery,
      variables: {
        'userId': HiveHelper.loginBox.get(HiveConstants.login)?.id,
        'startDate': startDate,
        'endDate': endDate,
      },
    );
    return result;
  }

  Future<QueryResult> getContactUsList() async {
    final QueryResult result =
        await client.query(query: ContactUsQueries.getContactUsList);
    return result;
  }

  Future<QueryResult> submitContactUs(
      int id, String subject, String body) async {
    final QueryResult result = await client.query(
      query: ContactUsQueries.submitContactUs,
      variables: {
        'id': id,
        'subject': subject,
        'body': body,
      },
    );
    return result;
  }
}
