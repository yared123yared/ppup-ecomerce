import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/webservices/repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

import '../error_handler_bloc.dart';

@lazySingleton
class CheckSessionStatusBloc {
  final Repository repository;

  CheckSessionStatusBloc(this.repository);

  ///Call the Terms API.
  Future<bool> checkSessionStatus(BuildContext context) async {
    QueryResult result = await repository.checkSessionStatus();

    ///Check if the result has any errors.
    if (result.hasException) {
      AppUtils.showErrorSnackbar(
          context, result.exception!.graphqlErrors[0].message);
      return false;
    } else {
      bool isSessionActive = result.data?['isSessionActive']['status'];
      if (!isSessionActive) {
        getIt<ErrorHandlerBloc>().navigateToLogin();
      }
      return isSessionActive;
    }
  }

  @disposeMethod
  dispose() async {}
}
