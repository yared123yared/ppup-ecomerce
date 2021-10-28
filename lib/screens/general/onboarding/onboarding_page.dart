import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gigpoint/dialog/exit_dialog.dart';
import 'package:gigpoint/model/slide.dart';
import 'package:gigpoint/screens/general/onboarding/slide_dots.dart';
import 'package:gigpoint/screens/general/onboarding/slide_item.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';
import 'package:gigpoint/widgets/button_widget.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  Future<bool> _onBackPressed() {
    if (_currentPage == 0) {
      AppUtils.dialogBuilder(context, const ExitDialog());
    } else {
      prevPage();
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
            appBar: AppbarWidget(
              title: '',
              leading: _currentPage == 0
                  ? null
                  : GestureDetector(
                      onTap: () => _onBackPressed(),
                      child: Icon(Platform.isAndroid
                          ? Icons.arrow_back
                          : Icons.arrow_back_ios)),
              actions: [
                if (_currentPage != (sliderList.length - 1))
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    child: TextButton(
                      onPressed: () {
                        goToLoginPage();
                      },
                      child: Text(
                        'Sign In',
                        style: Styles.bold(
                            fontSize: 16, color: AppTheme.primaryColor),
                      ),
                    ),
                  )
              ],
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < sliderList.length; i++)
                        if (i == _currentPage)
                          const SlideDots(isActive: true)
                        else
                          const SlideDots(isActive: false)
                    ],
                  ),
                  const SizedBox(height: 50),
                  ButtonWidget(
                    name: _currentPage != (sliderList.length - 1)
                        ? 'Next'
                        : 'Go to Sign In',
                    onTap: () => nextPage(),
                  ),
                ],
              ),
            ),
            body: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: sliderList.length,
              itemBuilder: (ctx, i) => SlideItem(
                index: i,
                slide: sliderList[i],
              ),
            )),
      ),
    );
  }

  void nextPage() {
    if (_currentPage != (sliderList.length - 1)) {
      _pageController.animateToPage(_pageController.page!.toInt() + 1,
          duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
    } else {
      goToLoginPage();
    }
  }

  void prevPage() {
    if (_currentPage != 0) {
      _pageController.animateToPage(_pageController.page!.toInt() - 1,
          duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
    }
  }

  void goToLoginPage() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.login, (Route<dynamic> route) => false);
  }
}
