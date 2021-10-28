import 'package:flutter/material.dart';
import 'package:gigpoint/model/products.dart';
import 'package:gigpoint/screens/shop/products/products_list_page.dart';
import 'package:gigpoint/screens/shop/products_carousel.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/strings.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/webservices/graphql_api_client.dart';
import 'package:gigpoint/webservices/queries/shop_queries.dart';
import 'package:gigpoint/widgets/errors_widget.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class InDemandWidget extends StatelessWidget {
  const InDemandWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(popularRewardsProductsString,
                      style: Styles.bold(fontSize: 16)),
                  TextButton(
                    onPressed: () {
                      pushNewScreen(
                        context,
                        screen: const ProductsListPage(
                          id: '0',
                          title: 'Popular Products',
                          sortBy: 'popularity',
                          fromViewAll: true,
                          subCategories: [],
                        ),
                        withNavBar: true,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    child: Text(
                      'View All',
                      style: Styles.semiBold(
                          fontSize: 16, color: AppTheme.primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Query(
                options: getIt<GraphQLApiClient>().queryOptions(
                    query: ShopQueries.getProducts,
                    variables: {
                      'start': 1,
                      'maxRows': 10,
                      'sortBy': 'popularity',
                      'sortDirection': 'asc'
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
                    Products data = Products.fromJson(result.data!);
                    return ProductsCarousel(
                      addBoxShadow: true,
                      products: data.productByStore.products,
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
