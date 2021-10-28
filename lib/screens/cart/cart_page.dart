import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gigpoint/bloc/cart/cart_bloc.dart';
import 'package:gigpoint/model/products.dart';
import 'package:gigpoint/screens/cart/cart_item.dart';
import 'package:gigpoint/screens/checkout/checkout_page.dart';
import 'package:gigpoint/screens/dashboard/dashboard_page.dart';
import 'package:gigpoint/screens/shop/products/productdetails/product_details_page.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';
import 'package:gigpoint/widgets/button_widget.dart';
import 'package:gigpoint/widgets/svg_image.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'empty_cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartBloc cartBloc = getIt<CartBloc>();
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    cartBloc.getCart();
  }

  @override
  void dispose() {
    cartBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: StreamBuilder<List<Product>>(
          stream: cartBloc.responseData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              products = snapshot.data ?? [];
            }
            return Scaffold(
              appBar: const AppbarWidget(
                title: 'My Cart',
                actions: [],
              ),
              bottomNavigationBar: products.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ButtonWidget(
                        name: 'Shop Now',
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            CupertinoPageRoute(
                              builder: (BuildContext context) {
                                return const DashboardPage(index: 3);
                              },
                            ),
                            (_) => false,
                          );
                        },
                      ),
                    )
                  : Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 5),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Cart value',
                                  style: Styles.bold(fontSize: 16),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 12, right: 5),
                                  child: SvgImage(
                                    asset: Images.coin,
                                    width: 16,
                                    height: 16,
                                  ),
                                ),
                                Text(
                                  '$calculateCartValue',
                                  style: Styles.bold(
                                      fontSize: 16,
                                      color: AppTheme.primaryColor),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),
                            ButtonWidget(
                              name: 'Checkout',
                              onTap: () {
                                pushNewScreen(
                                  context,
                                  screen: CheckoutPage(
                                    products: products,
                                    isFromCart: true,
                                  ),
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
              body: products.isEmpty
                  ? const EmptyCart()
                  : Scrollbar(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 20),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              AppUtils.removeFocus();
                              pushNewScreen(
                                context,
                                screen: ProductDetailsPage(
                                    productId: products[index].id),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: CartItem(
                              variant: products[index].selectedVariant!,
                              content: products[index].content ?? '',
                              qty: products[index].qty,
                              onAddTap: () {
                                products[index].qty += 1;
                                cartBloc.updateProduct(products[index]);
                              },
                              onSubTap: () {
                                if (products[index].qty > 1) {
                                  products[index].qty -= 1;
                                  cartBloc.updateProduct(products[index]);
                                }
                              },
                              onRemoveTap: () {
                                cartBloc.removeProduct(products[index]);
                              },
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemCount: products.length,
                        shrinkWrap: true,
                      ),
                    ),
            );
          }),
    );
  }

  ///Calculate the total cart value.
  double get calculateCartValue {
    double cartValue = 0;
    for (Product product in products) {
      double price = product.selectedVariant!.finalCost;
      int qty = product.qty;
      cartValue += price * qty;
    }
    return double.parse(cartValue.toStringAsFixed(2));
  }
}
