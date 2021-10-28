import 'package:flutter/material.dart';
import 'package:gigpoint/utils/styles.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key, this.msg = 'No Data Available'})
      : super(key: key);
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            msg,
            textAlign: TextAlign.center,
            style: Styles.semiBold(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
