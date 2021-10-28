import 'package:flutter/cupertino.dart';
import 'package:gigpoint/config/validations.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ErrorsWidget extends StatelessWidget {
  const ErrorsWidget({Key? key, this.msg, this.exception}) : super(key: key);
  final String? msg;
  final OperationException? exception;

  @override
  Widget build(BuildContext context) {
    String error = '';
    if (exception != null && exception!.graphqlErrors.isNotEmpty) {
      error = exception?.graphqlErrors[0].message ?? '';
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            Validations.DEFAULT_ERROR,
            textAlign: TextAlign.center,
            style: Styles.semiBold(fontSize: 16, color: AppTheme.redColor),
          ),
          const SizedBox(height: 10),
          if (exception != null)
            Text(
              error,
              textAlign: TextAlign.center,
              style: Styles.regular(fontSize: 10),
            ),
          if (msg != null)
            Text(
              msg ?? '',
              textAlign: TextAlign.center,
              style: Styles.regular(fontSize: 10),
            ),
        ],
      ),
    );
  }
}
