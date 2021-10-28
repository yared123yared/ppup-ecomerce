import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gigpoint/bloc/helpers/pagination_loading_bloc.dart';
import 'package:gigpoint/bloc/shop/search_products_bloc.dart';
import 'package:gigpoint/model/products.dart';
import 'package:gigpoint/screens/shop/product_search/search_widget.dart';
import 'package:gigpoint/screens/shop/products/product_card.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';

import 'search_suggestions_widget.dart';

class ProductSearchPage extends StatefulWidget {
  const ProductSearchPage({Key? key}) : super(key: key);

  @override
  _ProductSearchPageState createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  final FocusNode focusNode = FocusNode();
  List<Product> products = [];
  String searchKeyword = '';
  SearchProductsBloc searchProductsBloc = getIt<SearchProductsBloc>();
  int startItem = 1, totalItems = 0;
  bool viewAllProducts = false;

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          viewAllProducts = false;
        });
      }
    });
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (totalItems == Constants.DEFAULT_PAGINATION_COUNT &&
            startItem != products.length + 1) {
          getIt<PaginationLoadingBloc>().showLoading();
          Future.delayed(const Duration(microseconds: 100)).then((value) {
            startItem = products.length + 1;
            searchProductsBloc.getProducts(startItem, searchKeyword);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.25),
      appBar: const AppbarWidget(title: 'Search Product', actions: []),
      body: StreamBuilder<List<Product>>(
        stream: searchProductsBloc.responseData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (startItem == 1) {
              products.clear();
            }
            List<Product> temp = snapshot.data ?? [];
            totalItems = temp.length;
            products.addAll(temp);
            products = products.toSet().toList();
          }
          return Container(
            color: AppTheme.cardBackgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SearchWidget(
                    isFromSearch: true,
                    controller: _controller,
                    focusNode: focusNode,
                    onChanged: (value) {
                      searchKeyword = value;
                      startItem = 1;
                      if (value.isEmpty) {
                        searchProductsBloc.clearResults();
                      } else {
                        searchProductsBloc.getProducts(
                            startItem, searchKeyword);
                      }
                    },
                  ),
                ),
                if (snapshot.hasError &&
                    snapshot.error == 'loading' &&
                    !viewAllProducts &&
                    products.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                if (snapshot.error != 'loading' &&
                    _controller.text.isNotEmpty &&
                    !viewAllProducts)
                  SizedBox(
                    height: 250,
                    child: SearchSuggestionsWidget(
                      products: products,
                      onViewAllPressed: () {
                        focusNode.unfocus();
                        viewAllProducts = true;
                        setState(() {});
                      },
                    ),
                  ),
                if (viewAllProducts)
                  Expanded(
                    child: ListView(
                      controller: _scrollController,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        if (_controller.text.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 12),
                            child: Row(
                              children: [
                                Text('Showing results for ',
                                    style: Styles.semiBold(fontSize: 14)),
                                Text('“${_controller.text}”',
                                    style: Styles.bold(fontSize: 14)),
                              ],
                            ),
                          ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
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
                        if (totalItems == Constants.DEFAULT_PAGINATION_COUNT)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: StreamBuilder<bool>(
                              stream:
                                  getIt<PaginationLoadingBloc>().responseData,
                              builder: (context, loadingSnapshot) {
                                if (loadingSnapshot.hasData) {
                                  bool showLoading =
                                      loadingSnapshot.data ?? false;
                                  return showLoading
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : const SizedBox();
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          ),
                      ],
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
