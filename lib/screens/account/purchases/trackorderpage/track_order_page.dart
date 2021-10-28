import 'package:flutter/material.dart';
import 'package:gigpoint/screens/account/purchases/trackorderpage/cancel_card.dart';
import 'package:gigpoint/screens/account/purchases/trackorderpage/order_info_card.dart';
import 'package:gigpoint/screens/account/purchases/trackorderpage/product_card.dart';
import 'package:gigpoint/screens/account/purchases/trackorderpage/shipment_address_card.dart';
import 'package:gigpoint/screens/account/purchases/trackorderpage/track_card.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';

class TrackOrderPage extends StatefulWidget {
  const TrackOrderPage({Key? key}) : super(key: key);

  @override
  _TrackOrderPageState createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(
        title: 'Track Package',
        actions: [],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        children: [
          const TrackProductCard(),
          const SizedBox(height: 12),
          const TrackCard(),
          const SizedBox(height: 32),
          Text(
            'Order Info',
            style: Styles.bold(fontSize: 20),
          ),
          const SizedBox(height: 24),
          const OrderInfoCard(),
          const SizedBox(height: 12),
          const CancelCard(),
          const SizedBox(height: 24),
          Text(
            'Shipment Address',
            style: Styles.semiBold(fontSize: 16),
          ),
          const SizedBox(height: 12),
          const ShipmentAddressCard()
        ],
      ),
    );
  }
}
