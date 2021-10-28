import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gigpoint/bloc/auth/check_session_status_bloc.dart';
import 'package:gigpoint/bloc/connectivity_listner_bloc.dart';
import 'package:gigpoint/bloc/render_widget_bloc.dart';
import 'package:gigpoint/config/env.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/hive_helper.dart';
import 'package:gigpoint/utils/logger.dart';
import 'package:gigpoint/widgets/no_network_wrapper.dart';

class InsurancePage extends StatefulWidget {
  const InsurancePage({Key? key}) : super(key: key);

  @override
  _InsurancePageState createState() => _InsurancePageState();
}

class _InsurancePageState extends State<InsurancePage> {
  String? insuranceUrl;
  ConnectivityListnerBloc connectivityListnerBloc =
      getIt<ConnectivityListnerBloc>();

  bool isLoading = true;
  bool isPageStarted = false;
  bool isWebViewCreated = false;
  final DevelopmentLogger logger = getIt<DevelopmentLogger>();
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
      useOnDownloadStart: true,
      clearCache: true,
      cacheEnabled: false,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  double progress = 0;
  InAppWebViewController? webViewController;

  @override
  void dispose() {
    insuranceUrl = null;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    checkSessionStatus();
    String? accessToken =
        HiveHelper.loginBox.get(HiveConstants.login)!.accessToken;
    insuranceUrl = accessToken == null
        ? Env.INSURANCE_URL
        : Env.INSURANCE_URL + 'ppup/landing?token=$accessToken';
  }

  checkSessionStatus() async {
    await getIt<CheckSessionStatusBloc>().checkSessionStatus(context);
  }

  onWebViewCreated(InAppWebViewController controller) {
    Future.delayed(const Duration(microseconds: 500)).then((value) {
      if (!isWebViewCreated && mounted) {
        setState(() => isWebViewCreated = true);
        webViewController = controller;
        controller.clearCache();
        final cookieManager = CookieManager();
        cookieManager.deleteAllCookies();
        webViewController?.loadUrl(
            urlRequest: URLRequest(url: Uri.parse(insuranceUrl!)));
      }
    });
  }

  onProgressChanged(InAppWebViewController controller, int progress) {
    logger.log(title: 'WebView is loading progress: ', msg: '$progress%');
  }

  onLoadStart(InAppWebViewController controller, Uri? url) {
    logger.log(title: 'Page started loading: ', msg: url.toString());
  }

  onLoadStop(InAppWebViewController controller, Uri? url) {
    logger.log(title: 'Page finished loading: ', msg: url.toString());
    if (isWebViewCreated) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NoNetworkWrapper(
          onRefresh: () {
            connectivityListnerBloc.refresh().then((value) {
              if (value) {
                checkSessionStatus();
              }
            });
          },
          child: StreamBuilder<int>(
              stream: getIt<RenderWidgetBloc>().responseData,
              builder: (context, snapshot) {
                return snapshot.data != 2
                    ? const SizedBox()
                    : IndexedStack(
                        index: isLoading ? 1 : 0,
                        children: [
                          InAppWebView(
                            initialOptions: options,
                            onWebViewCreated: onWebViewCreated,
                            onProgressChanged: onProgressChanged,
                            onLoadStart: onLoadStart,
                            onLoadStop: onLoadStop,
                            androidOnPermissionRequest:
                                (controller, origin, resources) async {
                              return PermissionRequestResponse(
                                  resources: resources,
                                  action:
                                      PermissionRequestResponseAction.GRANT);
                            },
                            onLoadError: (controller, url, code, message) {},
                            onUpdateVisitedHistory:
                                (controller, url, androidIsReload) {},
                            onConsoleMessage: (controller, consoleMessage) {},
                          ),
                          const Center(child: CircularProgressIndicator())
                        ],
                      );
              }),
        ),
      ),
    );
  }
}
