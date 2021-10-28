import 'package:flutter/material.dart';
import 'package:gigpoint/bloc/connectivity_listner_bloc.dart';
import 'package:gigpoint/bloc/helpers/pagination_loading_bloc.dart';
import 'package:gigpoint/bloc/shop/filters_bloc.dart';
import 'package:gigpoint/bloc/shop/get_products_bloc.dart';
import 'package:gigpoint/model/products.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';
import 'package:gigpoint/widgets/no_network_wrapper.dart';
import 'package:gigpoint/widgets/no_products_for_points.dart';
import 'package:gigpoint/widgets/svg_image.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../filter_drawer.dart';
import 'product_card.dart';

class ProductsListPage extends StatefulWidget {
  final String title;
  final bool fromViewAll;
  final String sortBy;
  final String? id;
  final String sortOrder;
  final String? category;
  final double? startPrice;
  final double? endPrice;
  final List<String> subCategories;
  const ProductsListPage({
    Key? key,
    required this.title,
    this.fromViewAll = false,
    required this.sortBy,
    this.category,
    this.sortOrder = 'asc',
    this.id,
    this.startPrice,
    this.endPrice,
    required this.subCategories,
  }) : super(key: key);

  @override
  _ListProductCategoryPageState createState() =>
      _ListProductCategoryPageState();
}

class _ListProductCategoryPageState extends State<ProductsListPage> {
  GetProductsBloc getProductsBloc = getIt<GetProductsBloc>();
  final ScrollController _scrollController = ScrollController();

  FiltersBloc filtersBloc = getIt<FiltersBloc>();
  ConnectivityListnerBloc connectivityListnerBloc =
      getIt<ConnectivityListnerBloc>();

  List<Product> products = [];
  int startItem = 1, totalItems = 0;
  String? sortBy, sortOrder;
  String? category, categoryName;
  double? startPrice, endPrice;
  List<String> subCategories = [];

  @override
  void initState() {
    super.initState();
    sortBy = widget.sortBy;
    sortOrder = widget.sortOrder;
    category = widget.category;
    categoryName = widget.title;
    startPrice = widget.startPrice;
    endPrice = widget.endPrice;
    subCategories = widget.subCategories;

    /*print('Products List');
    print(widget.startPrice);
    print(widget.endPrice);*/

    filtersBloc.applyFilters(
        context,
        Filters(
          id: widget.id,
          categoryName: widget.title,
          categoryId: category,
          sortBy: sortBy,
          sortOrder: sortOrder,
          startPrice: widget.startPrice,
          endPrice: widget.endPrice,
          subCategories: widget.subCategories,
        ),
        isFromProducts: true);

    getProductsBloc.getProducts(
      startItem: startItem,
      sortBy: sortBy,
      sortDirection: sortOrder,
      category: category,
      startPrice: startPrice,
      endPrice: endPrice,
      subCategories: subCategories,
    );

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (totalItems == Constants.DEFAULT_PAGINATION_COUNT &&
            startItem != products.length + 1) {
          getIt<PaginationLoadingBloc>().showLoading();
          Future.delayed(const Duration(microseconds: 100)).then((value) {
            startItem = products.length + 1;
            getProductsBloc.getProducts(
              startItem: startItem,
              sortBy: sortBy,
              sortDirection: sortOrder,
              category: category,
              startPrice: startPrice,
              endPrice: endPrice,
              subCategories: subCategories,
            );
          });
        }
      }
    });
  }

  @override
  void dispose() {
    getProductsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        leading: !widget.fromViewAll
            ? GestureDetector(
                onTap: () async {
                  final result = await pushNewScreen(
                    context,
                    screen: const FilterDrawer(isFromProductsList: true),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.slideRight,
                  );
                  if (result == 'close') {
                    Navigator.pop(context);
                  } else if (result != null) {
                    startItem = 1;
                    category = result.categoryId;
                    sortBy = result.sortBy;
                    sortOrder = result.sortOrder;
                    categoryName = result.categoryName;
                    startPrice = result.startPrice;
                    endPrice = result.endPrice;
                    subCategories = result.subCategories;

                    getProductsBloc.getProducts(
                      startItem: startItem,
                      sortBy: sortBy,
                      sortDirection: sortOrder,
                      category: category,
                      startPrice: startPrice,
                      endPrice: endPrice,
                      subCategories: subCategories,
                    );
                    setState(() {});
                  }
                },
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: SvgImage(asset: Images.filter),
                    ),
                    StreamBuilder<Filters>(
                        stream: filtersBloc.responseData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            int count = 0;
                            if (snapshot.data?.categoryId != null &&
                                snapshot.data!.categoryId!.isNotEmpty) {
                              count += 1;
                            }
                            if (snapshot.data?.subCategories != null &&
                                snapshot.data!.subCategories!.isNotEmpty) {
                              count += 1;
                            }
                            if (snapshot.data?.startPrice != null &&
                                    snapshot.data?.startPrice?.toInt() != 0 ||
                                (snapshot.data?.endPrice != null &&
                                    snapshot.data?.endPrice?.toInt() !=
                                        Constants.MAX_PRICE_RANGE)) {
                              count += 1;
                            }
                            if (snapshot.data?.sortBy != null) {
                              count += 1;
                            }
                            return Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                height: 18,
                                width: 18,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme.redColor,
                                ),
                                child: Text(
                                  '$count',
                                  style: Styles.bold(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        }),
                  ],
                ),
              )
            : null,
        title: categoryName ?? 'Shop',
        actions: widget.fromViewAll
            ? null
            : [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                    onTap: () {
                      filtersBloc.clearFilters();
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ],
      ),
      body: NoNetworkWrapper(
        onRefresh: () {
          connectivityListnerBloc.refresh().then((value) {
            if (value) {
              getProductsBloc.getProducts(
                startItem: startItem,
                sortBy: sortBy,
                sortDirection: sortOrder,
                category: category,
                startPrice: widget.startPrice,
                endPrice: widget.endPrice,
                subCategories: widget.subCategories,
              );
            }
          });
        },
        child: StreamBuilder<List<Product>>(
            stream: getProductsBloc.responseData,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                totalItems = snapshot.data?.length ?? 0;
                if (startItem == 1) {
                  products.clear();
                }
                List<Product> temp = snapshot.data ?? [];
                products.addAll(temp);

                return products.isEmpty
                    ? const NoProductsForYourPoints()
                    : Scrollbar(
                        controller: _scrollController,
                        child: ListView(
                          controller: _scrollController,
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            GridView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              primary: false,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 20),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 2,
                                mainAxisExtent: 210,
                              ),
                              itemCount: products.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ProductCard(product: products[index]);
                              },
                            ),
                            if (totalItems ==
                                Constants.DEFAULT_PAGINATION_COUNT)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 50),
                                child: StreamBuilder<bool>(
                                  stream: getIt<PaginationLoadingBloc>()
                                      .responseData,
                                  builder: (context, loadingSnapshot) {
                                    if (loadingSnapshot.hasData) {
                                      bool showLoading =
                                          loadingSnapshot.data ?? false;
                                      return showLoading
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : const SizedBox();
                                    }
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  },
                                ),
                              ),
                          ],
                        ),
                      );
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
