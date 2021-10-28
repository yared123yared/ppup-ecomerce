import 'package:flutter/material.dart';
import 'package:gigpoint/dialog/confirmation_dialog.dart';
import 'package:gigpoint/dialog/loading_dialog.dart';
import 'package:gigpoint/model/contact_us.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/webservices/repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class ContactUsBloc {
  final Repository repository;
  ContactUsBloc(this.repository);

  var subject = PublishSubject<List<ContactUsList>>();
  Stream<List<ContactUsList>> get responseData => subject.stream;

  ///Call this method to get the ContactUs List.
  getContactUsList() async {
    QueryResult result = await repository.getContactUsList();

    if (result.hasException) {
      subject.sink.addError(result.exception!.graphqlErrors[0].message);
    } else {
      ContactUs contactUs = ContactUs.fromJson(result.data!);
      List<ContactUsList> contactUsList = contactUs.contactUsList ?? [];

      subject.sink.add(contactUsList);
    }
  }

  ///Call this method to submit the Issue.
  Future<bool> submitContactUs(
      BuildContext context, int id, String subject, String body) async {
    ///Show Loading Dialog.
    AppUtils.dialogBuilder(context, const LoadingDialog());

    QueryResult result = await repository.submitContactUs(id, subject, body);

    ///Dismiss Loading Dialog.
    Navigator.of(context, rootNavigator: true).pop();

    if (result.hasException) {
      return false;
    } else {
      AppUtils.dialogBuilder(context, const ConfirmationDialog());
      return true;
    }
  }

  @disposeMethod
  dispose() async {
    await subject.drain();
    subject.close();
  }
}
