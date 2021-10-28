import 'package:flutter/cupertino.dart';
import 'package:gigpoint/dialog/loading_dialog.dart';
import 'package:gigpoint/model/address.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/webservices/repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class AddressBloc {
  final Repository repository;
  AddressBloc(this.repository);

  var subject = PublishSubject<List<AddressList>>();
  Stream<List<AddressList>> get responseData => subject.stream;

  ///Call this method to get the Address List.
  getAddress() async {
    ///We are using addError for displaying loading in the UI.
    subject.sink.addError('loading');
    QueryResult result = await repository.getAddress();

    if (result.hasException) {
      subject.sink.addError(result.exception!.graphqlErrors[0].message);
    } else {
      Address address = Address.fromJson(result.data!);
      List<AddressList> addressList = address.addressList ?? [];

      subject.sink.add(addressList);
    }
  }

  ///Call this method to add the Address.
  Future<void> addAddress(BuildContext context, AddressList addressList) async {
    ///Show Loading Dialog.
    AppUtils.dialogBuilder(context, const LoadingDialog());

    QueryResult result = await repository.addAddress(addressList);

    ///Dismiss Loading Dialog.
    Navigator.of(context, rootNavigator: true).pop();

    if (result.hasException) {
      subject.sink.addError(result.exception!.graphqlErrors[0].message);
    } else {
      if (result.data?['addAddress']['id'] == null) {
        AppUtils.showErrorSnackbar(
            context, result.data?['addAddress']['message']);
      } else {
        Navigator.pop(context);
        getAddress();
      }
    }
  }

  ///Call this method to edit the Address.
  Future<void> editAddress(
      BuildContext context, AddressList addressList) async {
    ///Show Loading Dialog.
    AppUtils.dialogBuilder(context, const LoadingDialog());

    QueryResult result = await repository.editAddress(addressList);

    ///Dismiss Loading Dialog.
    Navigator.of(context, rootNavigator: true).pop();

    if (result.hasException) {
      subject.sink.addError(result.exception!.graphqlErrors[0].message);
    } else {
      if (result.data?['updateAddress']['id'] == null) {
        AppUtils.showErrorSnackbar(
            context, result.data?['updateAddress']['message']);
      } else {
        Navigator.pop(context);
        getAddress();
      }
    }
  }

  ///Call this method to delete the Address.
  deleteAddress(BuildContext context, int id) async {
    ///Show Loading Dialog.
    AppUtils.dialogBuilder(context, const LoadingDialog());

    QueryResult result = await repository.deleteAddress(id);

    ///Dismiss Loading Dialog.
    Navigator.of(context, rootNavigator: true).pop();

    if (result.hasException) {
      return false;
    } else {
      getAddress();
      return true;
    }
  }

  @disposeMethod
  dispose() async {
    await subject.drain();
    subject.close();
  }
}
