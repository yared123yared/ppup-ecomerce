import 'dart:convert';
import 'dart:io';

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
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class BankingPage extends StatefulWidget {
  const BankingPage({Key? key}) : super(key: key);

  @override
  _BankingPageState createState() => _BankingPageState();
}

class _BankingPageState extends State<BankingPage> {
  String? bankingUrl;
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
    bankingUrl = null;
    isLoading = true;
    isPageStarted = false;
    isWebViewCreated = false;
    webViewController = null;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    checkSessionStatus();
    String? accessToken =
        HiveHelper.loginBox.get(HiveConstants.login)!.accessToken;
    bankingUrl = accessToken == null
        ? Env.BANKING_URL
        : Env.BANKING_URL + 'auth/v1/ppup/$accessToken';
  }

  checkSessionStatus() async {
    await getIt<CheckSessionStatusBloc>().checkSessionStatus(context);
  }

  onWebViewCreated(InAppWebViewController controller) {
    webViewController = controller;
    controller.clearCache();
    final cookieManager = CookieManager();
    cookieManager.deleteAllCookies();
    if (Platform.isAndroid) {
      Future.delayed(const Duration(milliseconds: 500)).then((value) async {
        if (!isWebViewCreated && mounted) {
          setState(() => isWebViewCreated = true);
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: Uri.parse(bankingUrl!)));
        }
      });
    } else {
      Future.delayed(const Duration(seconds: 1)).then((value) async {
        if (!isWebViewCreated && mounted) {
          setState(() => isWebViewCreated = true);
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: Uri.parse(bankingUrl!)));
        }
      });
    }
  }

  onProgressChanged(InAppWebViewController controller, int progress) {
    logger.log(title: 'WebView is loading progress: ', msg: '$progress%');
  }

  onLoadStart(InAppWebViewController controller, Uri? url) {
    if (bankingUrl == url.toString()) {
      setState(() {
        isLoading = true;
        isPageStarted = true;
      });
      logger.log(title: 'Page started loading: ', msg: url.toString());
    }
  }

  onLoadStop(InAppWebViewController controller, Uri? url) {
    logger.log(title: 'Page finished loading: ', msg: url.toString());
    if (isPageStarted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  onDownloadStart(InAppWebViewController controller, Uri url) async {
    String? data = url.data?.contentText;
    var bytes = base64Decode(data!);
    final Directory directory = await getTemporaryDirectory();
    final String filePath = directory.path + '/Agreement.pdf';
    final file = File(filePath);
    await file.writeAsBytes(bytes.buffer.asUint8List());
    OpenFile.open(filePath);
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
                return snapshot.data != 1
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
                            onDownloadStart: onDownloadStart,
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
