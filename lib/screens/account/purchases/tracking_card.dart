import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:timelines/timelines.dart';

class TrackingCard extends StatelessWidget {
  const TrackingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Track Package',
              style: Styles.bold(fontSize: 18),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Goto Shipment',
                style:
                    Styles.semiBold(fontSize: 16, color: AppTheme.primaryColor),
              ),
            ),
            const SizedBox(height: 16),
            _DeliveryProcesses(processes: _data().deliveryProcesses),
          ],
        ),
      ),
    );
  }
}

class _DeliveryProcesses extends StatelessWidget {
  const _DeliveryProcesses({Key? key, required this.processes})
      : super(key: key);

  final List<_DeliveryProcess> processes;
  @override
  Widget build(BuildContext context) {
    return FixedTimeline.tileBuilder(
      theme: TimelineThemeData(
        nodePosition: 0,
        connectorTheme: const ConnectorThemeData(),
        indicatorTheme: const IndicatorThemeData(
          size: 15.0,
        ),
      ),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemCount: processes.length,
        contentsBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  processes[index].name,
                  style: Styles.semiBold(fontSize: 16),
                ),
                for (_DeliveryMessage item in processes[index].messages)
                  Text(
                    item.message,
                    style: Styles.regular(
                        fontSize: 12, color: AppTheme.textSecondaryColor),
                  )
              ],
            ),
          );
        },
        indicatorBuilder: (_, index) {
          return const DotIndicator(
            color: AppTheme.primaryColor,
            size: 12,
          );
        },
        connectorBuilder: (_, index, ___) => const SolidLineConnector(
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }
}

_OrderInfo _data() => _OrderInfo(
      date: DateTime.now(),
      deliveryProcesses: [
        const _DeliveryProcess(
          'Order Placed',
          messages: [
            _DeliveryMessage('8:30am',
                'Your order has been placed successfuly Mon, 21 May 2021'),
          ],
        ),
        const _DeliveryProcess(
          'Shipping Status',
          messages: [
            _DeliveryMessage('13:00pm',
                'Your order has been placed successfuly Mon, 22 May 2021'),
          ],
        ),
        const _DeliveryProcess(
          'Delivery Status',
          messages: [
            _DeliveryMessage('13:00pm', 'Not updated'),
          ],
        ),
        // _DeliveryProcess.complete(),
      ],
    );

class _OrderInfo {
  const _OrderInfo({
    required this.date,
    required this.deliveryProcesses,
  });

  final DateTime date;
  final List<_DeliveryProcess> deliveryProcesses;
}

class _DeliveryProcess {
  const _DeliveryProcess(
    this.name, {
    this.messages = const [],
  });

  final String name;
  final List<_DeliveryMessage> messages;

  bool get isCompleted => name == 'Done';
}

class _DeliveryMessage {
  const _DeliveryMessage(this.createdAt, this.message);

  final String createdAt; // final DateTime createdAt;
  final String message;

  @override
  String toString() {
    return '$createdAt $message';
  }
}
