import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gigpoint/screens/account/purchases/empty_purchase.dart';
import 'package:gigpoint/screens/account/purchases/purchase_card.dart';
import 'package:gigpoint/screens/home/rewards/filter_card.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';
import 'package:gigpoint/widgets/filter_modal_sheet.dart';

class PurchasesPage extends StatefulWidget {
  const PurchasesPage({Key? key}) : super(key: key);
  @override
  _PurchasesPageState createState() => _PurchasesPageState();
}

class _PurchasesPageState extends State<PurchasesPage> {
  String orderType = 'All';
  String duration = 'Duration';
  bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(
        title: 'My Purchases',
        actions: [],
      ),
      // bottomNavigationBar: isEmpty
      //     ? Padding(
      //         padding: const EdgeInsets.all(12.0),
      //         child: ButtonWidget(
      //           name: 'Shop Now',
      //           onTap: () {
      //             setState(() {
      //               isEmpty = false;
      //             });
      //           },
      //         ),
      //       )
      //     : null,
      body: isEmpty
          ? const EmptyPurchasesPage()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FilterCard(
                        title: orderType,
                        onTap: () => showOrderTypeFilter(),
                      ),
                      const SizedBox(width: 10),
                      FilterCard(
                        title: duration,
                        onTap: () => showDurationFilter(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: 4,
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
                    itemBuilder: (context, index) => PurchaseCard(index: index),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                  ),
                ),
              ],
            ),
    );
  }

  showOrderTypeFilter() async {
    List<Filter> filterOptions = [
      Filter('All', 'All'),
      Filter('Pending', 'Pending'),
      Filter('Delivered', 'Delivered'),
      Filter('Cancelled', 'Cancelled'),
      Filter('Returned', 'Returned'),
    ];
    final result = await FilterModalSheet.filterBy(
        context, 'Order Type', filterOptions, orderType);

    setState(() {
      orderType = result;
    });
  }

  showDurationFilter() async {
    List<Filter> filterOptions = [
      Filter('Last 6 Months', 'Last 6 Months'),
      Filter('Last 1 Year', 'Last 1 Year'),
      Filter('2022', '2022'),
      Filter('2021', '2021'),
    ];
    final result = await FilterModalSheet.filterBy(
        context, 'Select Duration', filterOptions, duration);

    setState(() {
      duration = result;
    });
  }
}
