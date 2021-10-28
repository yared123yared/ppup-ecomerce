import 'package:flutter/material.dart';
import 'package:gigpoint/bloc/address/address_bloc.dart';
import 'package:gigpoint/bloc/connectivity_listner_bloc.dart';
import 'package:gigpoint/dialog/delete_address_dialog.dart';
import 'package:gigpoint/model/address.dart';
import 'package:gigpoint/screens/account/address/add_address_page.dart';
import 'package:gigpoint/screens/account/address/empty_address.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';
import 'package:gigpoint/widgets/button_widget.dart';
import 'package:gigpoint/widgets/errors_widget.dart';
import 'package:gigpoint/widgets/no_network_wrapper.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'address_card.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key, required this.isSelection}) : super(key: key);
  final bool isSelection;

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  String selectedAddress = '0';
  String? showOptionsFor;
  bool showOptions = false;
  bool isEmpty = false;

  AddressBloc getAddressBloc = getIt<AddressBloc>();
  ConnectivityListnerBloc connectivityListnerBloc =
      getIt<ConnectivityListnerBloc>();

  @override
  void initState() {
    super.initState();
    getAddressBloc.getAddress();
  }

  @override
  void dispose() {
    getAddressBloc.getAddress();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppbarWidget(
          title: 'My Addresses',
          actions: [
            if (!isEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      showOptionsFor = null;
                      showOptions = false;
                    });
                    pushNewScreen(
                      context,
                      screen: const AddAddressPage(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  child: Text(
                    'New +',
                    style:
                        Styles.bold(fontSize: 14, color: AppTheme.primaryColor),
                  ),
                ),
              ),
          ],
        ),
        bottomNavigationBar: isEmpty
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: ButtonWidget(
                  name: 'Add a New Address +',
                  onTap: () {
                    setState(() {
                      isEmpty = false;
                    });
                  },
                ),
              )
            : widget.isSelection
                ? Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: AppTheme.boxShadow,
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: ButtonWidget(
                      name: 'Select',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                : null,
        body: NoNetworkWrapper(
          onRefresh: () {
            connectivityListnerBloc.refresh().then((value) {
              if (value) {
                getAddressBloc.getAddress();
              }
            });
          },
          child: StreamBuilder<List<AddressList>>(
              stream: getAddressBloc.responseData,
              builder: (context, AsyncSnapshot<List<AddressList>> snapshot) {
                if (snapshot.hasData) {
                  return (snapshot.data!.isEmpty)
                      ? const EmptyMyAddress()
                      : ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 12),
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) => AddressCard(
                            isSelection: widget.isSelection,
                            value: index.toString(),
                            selectedValue: selectedAddress,
                            onChanged: (showOptionsFor != null && showOptions)
                                ? null
                                : (val) {
                                    setState(() {
                                      selectedAddress = index.toString();
                                    });
                                  },
                            onTap: (showOptionsFor != null && showOptions)
                                ? null
                                : () {
                                    setState(() {
                                      selectedAddress = index.toString();
                                    });
                                  },
                            onOptionsTap:
                                (showOptionsFor != null && showOptions)
                                    ? null
                                    : () {
                                        setState(() {
                                          showOptionsFor = index.toString();
                                          showOptions = true;
                                        });
                                      },
                            showOptions: (showOptionsFor != null &&
                                    showOptionsFor == index.toString())
                                ? true
                                : false,
                            onCloseTap: () {
                              setState(() {
                                showOptionsFor = null;
                                showOptions = false;
                              });
                            },
                            onDeleteTap: () {
                              AppUtils.dialogBuilder(
                                context,
                                DeleteAddressDialog(
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                    getAddressBloc.deleteAddress(
                                        context, snapshot.data![index].id!);
                                  },
                                ),
                              );
                              setState(() {
                                showOptionsFor = null;
                                showOptions = false;
                              });
                            },
                            onEditTap: () {
                              setState(() {
                                showOptionsFor = null;
                                showOptions = false;
                              });
                              pushNewScreen(
                                context,
                                screen: AddAddressPage(
                                    address: snapshot.data![index]),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            addressList: snapshot.data![index],
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemCount: snapshot.data!.length,
                        );
                } else if (snapshot.hasError && snapshot.error == 'loading') {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  isEmpty = true;
                  return ErrorsWidget(msg: snapshot.error.toString());
                }

                return const Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }
}
