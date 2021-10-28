import 'package:flutter/material.dart';
import 'package:gigpoint/bloc/connectivity_listner_bloc.dart';
import 'package:gigpoint/bloc/get_balance_bloc.dart';
import 'package:gigpoint/model/products.dart';
import 'package:gigpoint/screens/checkout/bill_details_card.dart';
import 'package:gigpoint/screens/checkout/order_summary_page.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/strings.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';
import 'package:gigpoint/widgets/button_widget.dart';
import 'package:gigpoint/widgets/no_network_wrapper.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage(
      {Key? key, required this.products, required this.isFromCart})
      : super(key: key);
  final List<Product> products;
  final bool isFromCart;

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  GetBalanceBloc getBalanceBloc = getIt<GetBalanceBloc>();
  ConnectivityListnerBloc connectivityListnerBloc =
      getIt<ConnectivityListnerBloc>();

  bool isAddressAdded = false;

  @override
  void initState() {
    super.initState();
    getBalanceBloc.getBalance();
  }

  @override
  void dispose() {
    getBalanceBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: const AppbarWidget(
          title: 'Checkout',
          actions: [],
        ),
        bottomNavigationBar: StreamBuilder<double?>(
            stream: getBalanceBloc.responseData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (getBalance(snapshot.data ?? 0) < 0)
                      Container(
                        color: const Color.fromRGBO(253, 103, 94, 1),
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.sentiment_dissatisfied_outlined,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              youDontHaveEnoughPointsString,
                              textAlign: TextAlign.center,
                              style: Styles.semiBold(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: AppTheme.boxShadow,
                      ),
                      child: ButtonWidget(
                        name: 'Continue',
                        onTap: () {
                          pushNewScreen(
                            context,
                            screen: OrderSummaryPage(
                              products: widget.products,
                              isFromCart: widget.isFromCart,
                            ),
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                            withNavBar: false,
                          );
                        },
                        isActive: (getBalance(snapshot.data ?? 0) < 0 ||
                                !isAddressAdded)
                            ? false
                            : true,
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox();
            }),
        body: NoNetworkWrapper(
          onRefresh: () {
            connectivityListnerBloc.refresh().then((value) {
              if (value) {
                getBalanceBloc.getBalance();
              }
            });
          },
          child: StreamBuilder<double?>(
              stream: getBalanceBloc.responseData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 12),
                    children: [
                      // if (!isAddressAdded)
                      //   ButtonWidget(
                      //     name: 'Add Address',
                      //     onTap: () {
                      //       setState(() {
                      //         isAddressAdded = true;
                      //       });
                      //     },
                      //   ),
                      // if (isAddressAdded) const DeliverToWidget(),
                      // SizedBox(height: isAddressAdded ? 12 : 40),
                      BillDetailsCard(
                        products: widget.products,
                        avaliablePoints: snapshot.data ?? 0,
                        cartValue: calculateCartValue,
                        balancePoints: getBalance(snapshot.data ?? 0),
                      ),
                    ],
                  );
                } else if (snapshot.hasError && snapshot.error == 'loading') {
                  return const Center(child: CircularProgressIndicator());
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }

  ///Calculate the total cart value.
  double get calculateCartValue {
    double cartValue = 0;
    for (Product product in widget.products) {
      double price = product.selectedVariant!.finalCost;
      int qty = product.qty;
      cartValue += price * qty;
    }
    return double.parse(cartValue.toStringAsFixed(2));
  }

  ///Calculate the balance after deduction.
  double getBalance(double availabePoints) {
    return double.parse(
        (availabePoints - calculateCartValue).toStringAsFixed(2));
  }
}
