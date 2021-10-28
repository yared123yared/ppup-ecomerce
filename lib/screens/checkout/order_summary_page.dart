import 'package:flutter/material.dart';
import 'package:gigpoint/bloc/get_balance_bloc.dart';
import 'package:gigpoint/model/product_details.dart';
import 'package:gigpoint/model/products.dart';
import 'package:gigpoint/screens/checkout/order_confirmation_page.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/hive_helper.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';
import 'package:gigpoint/widgets/button_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'bill_details_card.dart';
import 'deliver_to_widget.dart';
import 'item_card.dart';

class OrderSummaryPage extends StatefulWidget {
  const OrderSummaryPage(
      {Key? key, required this.products, required this.isFromCart})
      : super(key: key);
  final List<Product> products;
  final bool isFromCart;

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<OrderSummaryPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: const AppbarWidget(
          title: 'Order Summary',
          actions: [],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: AppTheme.boxShadow,
          ),
          child: ButtonWidget(
            name: 'Complete Purchase',
            onTap: () async {
              if (widget.isFromCart) {
                await HiveHelper.cartBox.deleteAll(HiveHelper.cartBox.keys);
              }
              pushNewScreen(
                context,
                screen: const OrderConfirmationPage(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),
        ),
        body: StreamBuilder<double?>(
            stream: getIt<GetBalanceBloc>().responseData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        ProductSkus variant =
                            widget.products[index].selectedVariant!;
                        return ItemCard(
                          variant: variant,
                          content: widget.products[index].content ?? '',
                          qty: widget.products[index].qty,
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemCount: widget.products.length,
                    ),
                    const SizedBox(height: 12),
                    BillDetailsCard(
                      products: widget.products,
                      avaliablePoints: snapshot.data ?? 0,
                      balancePoints: getBalance(snapshot.data ?? 0),
                    ),
                    const SizedBox(height: 12),
                    const DeliverToWidget(),
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
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
