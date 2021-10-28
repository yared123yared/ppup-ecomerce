import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gigpoint/bloc/error_handler_bloc.dart';
import 'package:gigpoint/dialog/loading_dialog.dart';
import 'package:gigpoint/model/login.dart';
import 'package:gigpoint/screens/general/terms_conditions/terms_and_condtions_page.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/hive_helper.dart';
import 'package:gigpoint/webservices/repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class LoginBloc {
  final Repository repository;
  LoginBloc(this.repository);

  var subject = BehaviorSubject<Login>();
  Stream<Login> get responseData => subject.stream;

  ///Call the Login API.
  login(BuildContext context, String email, String password) async {
    ///Show Loading Dialog.
    AppUtils.dialogBuilder(context, const LoadingDialog());
    QueryResult result = await repository.login(email, password);

    ///Dismiss Loading Dialog.
    Navigator.of(context, rootNavigator: true).pop();

    ///Check if the result has any errors.
    if (result.hasException) {
      subject.sink.addError(result.exception!.graphqlErrors[0].message);
    } else {
      await HiveHelper.clearUserSession();
      Login _login = Login.fromJson(result.data!);
      if (_login.login.statusCode == 200) {
        ///Reset the Session value in the ErrorHandlerBloc to handle further 401 errors.
        getIt<ErrorHandlerBloc>().resetSessionValue();

        ///Save Login Data to local storage
        await HiveHelper.loginBox.put(HiveConstants.login, _login.login);
        if (_login.login.termsAndConditionsAccepted ?? false) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.dashboard, (Route<dynamic> route) => false);
        } else {
          ///After sucessful login, navigate to Terms and Conditions Page.
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const TermsAndCondtionsPage()));
        }
        subject.sink.add(_login);
      } else {
        AppUtils.showErrorSnackbar(
            context, 'Invalid Credentials. Please try again');
      }
    }
  }

  @disposeMethod
  dispose() async {
    await subject.drain();
    subject.close();
  }
}
