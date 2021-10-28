import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gigpoint/bloc/cart/cart_bloc.dart';
import 'package:gigpoint/bloc/connectivity_listner_bloc.dart';
import 'package:gigpoint/model/product_details.dart';
import 'package:gigpoint/model/products.dart';
import 'package:gigpoint/screens/cart/cart_page.dart';
import 'package:gigpoint/screens/checkout/checkout_page.dart';
import 'package:gigpoint/screens/shop/products/productdetails/image_view.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/webservices/graphql_api_client.dart';
import 'package:gigpoint/webservices/queries/shop_queries.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';
import 'package:gigpoint/widgets/button_widget.dart';
import 'package:gigpoint/widgets/cache_image.dart';
import 'package:gigpoint/widgets/counter_widget.dart';
import 'package:gigpoint/widgets/errors_widget.dart';
import 'package:gigpoint/widgets/no_network_wrapper.dart';
import 'package:gigpoint/widgets/outline_button_widget.dart';
import 'package:gigpoint/widgets/points_widget.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'product_variants.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({Key? key, required this.productId})
      : super(key: key);
  final String productId;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductDetailsPage> {
  int qty = 1;
  ProductSkus? selectedVarient;
  late Product product;
  bool isAddedToCart = false;

  CartBloc cartBloc = getIt<CartBloc>();
  ConnectivityListnerBloc connectivityListnerBloc =
      getIt<ConnectivityListnerBloc>();

  @override
  void dispose() {
    cartBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
        stream: cartBloc.responseData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int index = snapshot.data!
                .indexWhere((element) => element.id == widget.productId);
            if (index == -1) {
              isAddedToCart = false;
            } else {
              isAddedToCart = true;
            }
          }
          return GraphQLProvider(
            client: getIt<GraphQLApiClient>().client,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: const AppbarWidget(
                title: 'Product Details',
              ),
              bottomNavigationBar: Query(
                  options: getIt<GraphQLApiClient>().queryOptions(
                      query: ShopQueries.getProductDetails,
                      variables: {
                        'productId': widget.productId,
                      }),
                  builder: (QueryResult result, {fetchMore, refetch}) {
                    return (result.isLoading || result.hasException)
                        ? const SizedBox()
                        : Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: AppTheme.boxShadow,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: OutlineButtonWidget(
                                      name: isAddedToCart
                                          ? 'Go to Cart'
                                          : 'Add to Cart',
                                      onTap: () {
                                        if (isAddedToCart) {
                                          pushNewScreen(
                                            context,
                                            screen: const CartPage(),
                                            withNavBar: false,
                                            pageTransitionAnimation:
                                                PageTransitionAnimation
                                                    .cupertino,
                                          );
                                        } else {
                                          product.qty = qty;
                                          product.selectedVariant =
                                              selectedVarient;
                                          cartBloc.addToCart(product);
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                      child: ButtonWidget(
                                    name: 'Buy Now',
                                    onTap: () {
                                      product.qty = qty;
                                      product.selectedVariant = selectedVarient;
                                      pushNewScreen(
                                        context,
                                        screen: CheckoutPage(
                                          products: [product],
                                          isFromCart: false,
                                        ),
                                        withNavBar: false,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                      );
                                    },
                                  ))
                                ],
                              ),
                            ),
                          );
                  }),
              body: NoNetworkWrapper(
                onRefresh: () {
                  connectivityListnerBloc.refresh().then((value) {
                    if (value) {
                      setState(() {});
                    }
                  });
                },
                child: Query(
                    options: getIt<GraphQLApiClient>().queryOptions(
                        query: ShopQueries.getProductDetails,
                        variables: {
                          'productId': widget.productId,
                        }),
                    builder: (QueryResult result, {fetchMore, refetch}) {
                      if (result.isLoading && result.data == null) {
                        return const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (result.hasException) {
                        getIt<GraphQLApiClient>()
                            .handleExceptions(result.exception);
                        return ErrorsWidget(exception: result.exception);
                      } else {
                        ProductDetails productDetails =
                            ProductDetails.fromJson(result.data!);
                        ProductDetailsClass productDetailsClass =
                            productDetails.productDetails;
                        product = productDetailsClass.products;
                        List<ProductSkus> productSkus =
                            productDetailsClass.productSkus;
                        selectedVarient ??= productSkus[0];
                        return ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0,
                                  right: 25.0,
                                  bottom: 10.0,
                                  top: 25.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    style: Styles.bold(fontSize: 20),
                                  ),
                                  const SizedBox(height: 17),
                                  PointsWidget(
                                    text: 'Buy for: ',
                                    textSize: 13,
                                    points: selectedVarient?.finalCost ?? 0,
                                    fontSize: 20,
                                    iconSize: 20,
                                  ),
                                  const SizedBox(height: 40),
                                  // ProductGallery(
                                  //     imageUrl: selectedVarient!.imageHash,
                                  //     productId: product.id),
                                  GestureDetector(
                                    onTap: () {
                                      pushNewScreen(
                                        context,
                                        screen: ImageView(
                                          imageUrl: selectedVarient!.imageHash,
                                          heroTag: product.id,
                                        ),
                                        withNavBar: true,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                      );
                                    },
                                    child: Center(
                                      child: GestureDetector(
                                        child: CacheImage(
                                          imageUrl: selectedVarient!.imageHash,
                                          height: 224,
                                          width: 224,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                  // Text(
                                  //   product.content,
                                  //   style: Styles.regular(fontSize: 14),
                                  // ),
                                  // const SizedBox(height: 24),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemBuilder: (context, i) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text:
                                                'Select ${product.productParameters?[i].name}: ',
                                            style: Styles.semiBold(
                                                fontSize: 14,
                                                color: AppTheme
                                                    .textSecondaryColor),
                                            children: [
                                              if (selectedVarient!
                                                  .options.isNotEmpty)
                                                TextSpan(
                                                  text: selectedVarient!
                                                          .options[i].size ??
                                                      selectedVarient!
                                                          .options[i].color,
                                                  style:
                                                      Styles.bold(fontSize: 14),
                                                )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 17),
                                        SizedBox(
                                          height: 130,
                                          child: ListView.separated(
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(width: 12),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: productSkus.length,
                                            itemBuilder: (context, index) =>
                                                ProductVariants(
                                              variant: productSkus[index],
                                              varientIndex: i,
                                              isSelected: selectedVarient!.id ==
                                                      productSkus[index].id
                                                  ? true
                                                  : false,
                                              onTap: () {
                                                setState(() {
                                                  selectedVarient =
                                                      productSkus[index];
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 20),
                                    itemCount:
                                        product.productParameters?.length ?? 0,
                                  ),
                                  if (!isAddedToCart)
                                    const SizedBox(height: 22),
                                  if (!isAddedToCart)
                                    Text(
                                      'Select Quantity',
                                      style: Styles.semiBold(fontSize: 14),
                                    ),
                                  if (!isAddedToCart)
                                    const SizedBox(height: 13),
                                  if (!isAddedToCart)
                                    CounterWidget(
                                      quantity: qty,
                                      onAddTap: () {
                                        setState(() {
                                          qty += 1;
                                        });
                                      },
                                      onRemoveTap: () {
                                        if (qty != 1) {
                                          setState(() {
                                            qty -= 1;
                                          });
                                        }
                                      },
                                    ),
                                  const SizedBox(height: 36),
                                  // const ProductSpecifications(),
                                  Text(
                                    'Description',
                                    style: Styles.semiBold(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18.0, right: 18.0, bottom: 18.0),
                              child:
                                  Html(data: product.content, shrinkWrap: true),
                            ),
                            /*
                          Text(
                            product.content ?? '',
                            style: Styles.regular(fontSize: 14),
                          ),
                           */
                          ],
                        );
                      }
                    }),
              ),
            ),
          );
        });
  }
}
