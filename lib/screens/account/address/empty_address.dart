import 'package:flutter/material.dart';
import 'package:gigpoint/utils/styles.dart';

class EmptyMyAddress extends StatelessWidget {
  const EmptyMyAddress({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'No Address Added Yet',
              style: Styles.bold(fontSize: 20),
            ),
            const SizedBox(height: 15),
            Text(
              'Looks like you haven’t added your address yet!',
              textAlign: TextAlign.center,
              style: Styles.regular(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
