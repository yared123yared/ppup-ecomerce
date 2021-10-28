import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gigpoint/dialog/loading_dialog.dart';
import 'package:gigpoint/model/login.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/hive_helper.dart';
import 'package:gigpoint/webservices/repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateTermsBloc {
  final Repository repository;

  UpdateTermsBloc(this.repository);

  ///Call the Terms API.
  updateTermsAndConditions(BuildContext context, bool isAccepted) async {
    ///Show Loading Dialog.
    AppUtils.dialogBuilder(context, const LoadingDialog());
    QueryResult result = await repository.updateTermsAndConditions(isAccepted);

    ///Dismiss Loading Dialog.
    Navigator.of(context, rootNavigator: true).pop();

    ///Check if the result has any errors.
    if (result.hasException) {
      AppUtils.showErrorSnackbar(
          context, result.exception!.graphqlErrors[0].message);
    } else {
      LoginClass login = HiveHelper.loginBox.get(HiveConstants.login)!;
      login.termsAndConditionsAccepted = true;
      login.firstTimeBonus =
          double.tryParse('${result.data?['updateProfile']['firstTimeBonus']}');
      login.isFirstTime = true;

      ///Save Login Data to local storage
      await HiveHelper.loginBox.put(HiveConstants.login, login);

      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.dashboard, (Route<dynamic> route) => false);
    }
  }

  @disposeMethod
  dispose() async {}
}
