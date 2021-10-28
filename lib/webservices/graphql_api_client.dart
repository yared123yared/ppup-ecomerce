import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gigpoint/bloc/connectivity_listner_bloc.dart';
import 'package:gigpoint/bloc/error_handler_bloc.dart';
import 'package:gigpoint/config/env.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/hive_helper.dart';
import 'package:gigpoint/utils/logger.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GraphQLApiClient {
  DevelopmentLogger logger = getIt<DevelopmentLogger>();

  ValueNotifier<GraphQLClient> get client => ValueNotifier<GraphQLClient>(
        GraphQLClient(
          cache: GraphQLCache(
            store: InMemoryStore(),
          ),
          link: HttpLink(
            Env.API_BASE_URL,
            // httpClient: LoggerHttpClient(http.Client()),
            defaultHeaders: {
              'x-api-key': Env.API_KEY,
              'Content-Type': 'application/graphql',
              'x-access-token':
                  '${HiveHelper.loginBox.get(HiveConstants.login)?.accessToken}',
              'x-user-id':
                  '${HiveHelper.loginBox.get(HiveConstants.login)?.id}',
            },
          ),
        ),
      );

  QueryOptions queryOptions(
          {required String query, Map<String, dynamic>? variables}) =>
      QueryOptions(
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        document: gql(query),
        variables: variables ?? {},
      );

  Future<QueryResult> query(
      {required String query, Map<String, dynamic>? variables}) async {
    final QueryOptions options = QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      variables: variables ?? {},
    );

    final QueryResult result = await client.value.query(options);

    if (result.hasException) handleExceptions(result.exception);

    return result;
  }

  Future<QueryResult> mutate(
      {required String query, Map<String, dynamic>? variables}) async {
    // logger.log(title: 'Query', msg: query);
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: variables ?? {},
      onCompleted: (doc) {},
      onError: (OperationException? exception) {
        handleExceptions(exception);
      },
    );
    final QueryResult result = await client.value.mutate(options);

    return result;
  }

  /// Handle all the generic exceptions.
  handleExceptions(OperationException? exception) async {
    if (exception?.linkException != null) {
      ///Check for SocketException
      if (exception?.linkException!.originalException is SocketException) {
        getIt<ConnectivityListnerBloc>().updateNetworkStatus(false);
      }
    }

    /// Any graphql errors returned from the operation
    else if (exception?.graphqlErrors.isNotEmpty ?? false) {
      try {
        var error = jsonDecode(exception!.graphqlErrors[0].message);
        if (error != null && error['statusCode'] == 401) {
          getIt<ErrorHandlerBloc>().navigateToLogin();
        }
      } catch (e) {
        logger.log(title: 'Parsing Error', msg: e.toString());
      }
    }
  }
}
