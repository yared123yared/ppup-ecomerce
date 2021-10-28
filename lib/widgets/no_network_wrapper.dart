import 'package:flutter/material.dart';
import 'package:gigpoint/bloc/connectivity_listner_bloc.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/button_widget.dart';
import 'package:gigpoint/widgets/svg_image.dart';

class NoNetworkWrapper extends StatelessWidget {
  const NoNetworkWrapper(
      {Key? key, required this.onRefresh, required this.child})
      : super(key: key);
  final GestureTapCallback onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: getIt<ConnectivityListnerBloc>().responseData,
      builder: (context, snapshot) {
        return (snapshot.hasData && !snapshot.data!)
            ? NoInternetWidget(
                onTap: onRefresh,
              )
            : child;
      },
    );
  }
}

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({Key? key, required this.onTap}) : super(key: key);
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ButtonWidget(
            name: 'Refresh',
            onTap: onTap,
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SvgImage(asset: Images.noInternet),
                const SizedBox(height: 30),
                Text(
                  'Whooops! No active internet',
                  style: Styles.bold(fontSize: 20),
                ),
                const SizedBox(height: 15),
                Text(
                  'Check your connection',
                  style: Styles.regular(fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
