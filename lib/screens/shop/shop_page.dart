import 'package:flutter/material.dart';
import 'package:gigpoint/bloc/connectivity_listner_bloc.dart';
import 'package:gigpoint/bloc/shop/get_categores_bloc.dart';
import 'package:gigpoint/model/categories.dart';
import 'package:gigpoint/model/products.dart';
import 'package:gigpoint/screens/shop/categories_widget.dart';
import 'package:gigpoint/screens/shop/filter_drawer.dart';
import 'package:gigpoint/screens/shop/product_search/search_widget.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/webservices/graphql_api_client.dart';
import 'package:gigpoint/webservices/queries/shop_queries.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';
import 'package:gigpoint/widgets/errors_widget.dart';
import 'package:gigpoint/widgets/no_network_wrapper.dart';
import 'package:gigpoint/widgets/svg_image.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'products/popular_products.dart';
import 'products/products_list_page.dart';
import 'products_carousel.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  GraphQLApiClient graphQLApiClient = getIt<GraphQLApiClient>();
  ConnectivityListnerBloc connectivityListnerBloc =
      getIt<ConnectivityListnerBloc>();

  @override
  void initState() {
    super.initState();
    getIt<GetCategoriesBloc>().getCategories();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppbarWidget(
        leading: InkWell(
          onTap: () async {
            AppUtils.removeFocus();
            final filters = await pushNewScreen(
              context,
              screen: const FilterDrawer(isFromProductsList: false),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.slideRight,
            );

            if (filters != null) {
              pushNewScreen(
                context,
                withNavBar: true,
                screen: ProductsListPage(
                  id: filters.id,
                  title: filters.categoryName ?? 'Shop',
                  category: filters.categoryId,
                  sortBy: filters.sortBy ?? 'popularity',
                  sortOrder: filters.sortOrder ?? 'asc',
                  startPrice: filters.startPrice,
                  endPrice: filters.endPrice,
                  subCategories: filters.subCategories ?? [],
                ),
              );
            }
          },
          child: const Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
            child: SvgImage(asset: Images.filter),
          ),
        ),
        title: 'Shop',
      ),
      body: NoNetworkWrapper(
        onRefresh: () {
          connectivityListnerBloc.refresh().then((value) {
            if (value) {
              getIt<GetCategoriesBloc>().getCategories();
              setState(() {});
            }
          });
        },
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(12, 20, 12, 10),
                child: SearchWidget(isFromSearch: false),
              ),
            ),
            Expanded(
              child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  Card(
                    margin: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                          child: Text(
                            'Categories',
                            style: Styles.bold(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Query(
                              options: graphQLApiClient.queryOptions(
                                  query: ShopQueries.getCategories),
                              builder: (QueryResult result,
                                  {fetchMore, refetch}) {
                                if (result.isLoading && result.data == null) {
                                  return const SizedBox();
                                } else if (result.hasException) {
                                  graphQLApiClient
                                      .handleExceptions(result.exception);
                                  return ErrorsWidget(
                                      exception: result.exception);
                                } else {
                                  Categories data =
                                      Categories.fromJson(result.data!);
                                  return CategoriesWidget(
                                      categories:
                                          data.categoriesByStore.categories);
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                  Query(
                    options: graphQLApiClient.queryOptions(
                        query: ShopQueries.getProducts,
                        variables: {
                          'start': 1,
                          'maxRows': 5,
                          'sortBy': 'recommended',
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
                        graphQLApiClient.handleExceptions(result.exception);
                        return ErrorsWidget(exception: result.exception);
                      } else {
                        Products data = Products.fromJson(result.data!);

                        return Container(
                            height: 160,
                            color: const Color.fromRGBO(235, 235, 235, 1),
                            child: ProductsCarousel(
                                addBoxShadow: false,
                                products: data.productByStore.products));
                      }
                    },
                  ),
                  Query(
                      options: graphQLApiClient.queryOptions(
                          query: ShopQueries.getProducts,
                          variables: {
                            'start': 1,
                            'maxRows': 10,
                            'sortBy': 'popularity',
                            'sortDirection': 'asc'
                          }),
                      builder: (QueryResult result, {fetchMore, refetch}) {
                        if (result.isLoading && result.data == null) {
                          return const SizedBox();
                        } else if (result.hasException) {
                          graphQLApiClient.handleExceptions(result.exception);
                          return ErrorsWidget(exception: result.exception);
                        } else {
                          Products data = Products.fromJson(result.data!);
                          return PopularProducts(
                              products: data.productByStore.products);
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
