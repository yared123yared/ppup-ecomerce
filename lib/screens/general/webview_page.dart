import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gigpoint/bloc/connectivity_listner_bloc.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/logger.dart';
import 'package:gigpoint/widgets/no_network_wrapper.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  bool isLoading = true;
  bool isPageStarted = false;
  bool isWebViewCreated = false;
  final DevelopmentLogger logger = getIt<DevelopmentLogger>();
  ConnectivityListnerBloc connectivityListnerBloc =
      getIt<ConnectivityListnerBloc>();
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

  InAppWebViewController? webViewController;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  onWebViewCreated(InAppWebViewController controller) {
    if (!isWebViewCreated && mounted) {
      setState(() => isWebViewCreated = true);
      webViewController = controller;
      controller.clearCache();
      final cookieManager = CookieManager();
      cookieManager.deleteAllCookies();
      webViewController?.loadUrl(
          urlRequest: URLRequest(url: Uri.parse(widget.url)));
    }
  }

  onProgressChanged(InAppWebViewController controller, int progress) {
    logger.log(title: 'WebView is loading progress: ', msg: '$progress%');
  }

  onLoadStart(InAppWebViewController controller, Uri? url) {
    if (widget.url == url.toString()) {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NoNetworkWrapper(
          onRefresh: () {
            connectivityListnerBloc.refresh().then((value) {
              if (value) {
                webViewController?.loadUrl(
                    urlRequest: URLRequest(url: Uri.parse(widget.url)));
              }
            });
          },
          child: IndexedStack(
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
                      action: PermissionRequestResponseAction.GRANT);
                },
                onLoadError: (controller, url, code, message) {},
                onUpdateVisitedHistory: (controller, url, androidIsReload) {},
                onConsoleMessage: (controller, consoleMessage) {},
              ),
              const Center(child: CircularProgressIndicator())
            ],
          ),
        ),
      ),
    );
  }
}
