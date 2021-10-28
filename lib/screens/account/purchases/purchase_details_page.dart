import 'package:flutter/material.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';

import 'tracking_card.dart';
import 'trackorderpage/order_info_card.dart';
import 'trackorderpage/product_card.dart';
import 'trackorderpage/shipment_address_card.dart';

class PurchaseDetailsPage extends StatefulWidget {
  final int? orderStatus;
  const PurchaseDetailsPage({Key? key, this.orderStatus}) : super(key: key);

  @override
  _PurchaseDetailsPageState createState() => _PurchaseDetailsPageState();
}

class _PurchaseDetailsPageState extends State<PurchaseDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(
        title: 'Order Details',
        actions: [],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        children: [
          const TrackProductCard(),
          const SizedBox(height: 12),
          OrderInfoCard(orderStatus: widget.orderStatus),
          const SizedBox(height: 12),
          const TrackingCard(),
          const SizedBox(height: 12),
          const ShipmentAddressCard(),
        ],
      ),
    );
  }
}
