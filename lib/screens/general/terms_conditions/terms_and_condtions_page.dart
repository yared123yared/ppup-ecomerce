import 'package:flutter/material.dart';
import 'package:gigpoint/bloc/auth/update_terms_bloc.dart';
import 'package:gigpoint/bloc/connectivity_listner_bloc.dart';
import 'package:gigpoint/config/env.dart';
import 'package:gigpoint/config/validations.dart';
import 'package:gigpoint/dialog/exit_dialog.dart';
import 'package:gigpoint/screens/general/terms_conditions/acceptance_widget.dart';
import 'package:gigpoint/screens/general/webview_page.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class TermsAndCondtionsPage extends StatefulWidget {
  const TermsAndCondtionsPage({Key? key, this.isFirstTime = true})
      : super(key: key);
  final bool isFirstTime;

  @override
  _TermsAndCondtionsPageState createState() => _TermsAndCondtionsPageState();
}

class _TermsAndCondtionsPageState extends State<TermsAndCondtionsPage> {
  bool isAccepted = false;

  Future<bool> _onBackPressed() {
    if (widget.isFirstTime) {
      AppUtils.dialogBuilder(context, const ExitDialog());
    } else {
      Navigator.pop(context);
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => _onBackPressed(),
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: AppTheme.primaryColor),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(30),
              child: Text(
                'Terms & Conditions',
                textAlign: TextAlign.center,
                style: Styles.bold(fontSize: 20),
              ),
            ),
          ),
          bottomNavigationBar: widget.isFirstTime
              ? AcceptanceWidget(
                  isAccepted: isAccepted,
                  onAcceptTap: () async {
                    getIt<ConnectivityListnerBloc>()
                        .getNetworkStatus()
                        .then((value) {
                      if (value) {
                        getIt<UpdateTermsBloc>()
                            .updateTermsAndConditions(context, isAccepted);
                      } else {
                        AppUtils.showErrorSnackbar(
                            context, Validations.NO_NETWORK);
                      }
                    });
                  },
                  onChanged: (val) {
                    setState(() {
                      isAccepted = val;
                    });
                  },
                )
              : null,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (widget.isFirstTime)
                  Text(
                    'BY CLICKING "ACCEPT", you confirm that you have read, understood, and agreed to the GigPoint\'s Terms & Conditions and Privacy Policy. Please click on the below link to read the details.',
                    style: Styles.regular(fontSize: 16),
                  ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        pushNewScreen(
                          context,
                          screen: WebviewPage(url: Env.TERMS_AND_CONDITIONS),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Text('GigPoint Terms and Conditions',
                          style: Styles.semiBold(
                              fontSize: 16, color: AppTheme.primaryColor)),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        pushNewScreen(
                          context,
                          screen: WebviewPage(url: Env.PRIVACY_POLICY),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Text(
                        'GigPoint Privacy Policy',
                        style: Styles.semiBold(
                            fontSize: 16, color: AppTheme.primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
