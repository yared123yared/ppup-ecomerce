import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';
import 'package:gigpoint/widgets/button_widget.dart';
import 'package:gigpoint/widgets/cache_image.dart';
import 'package:gigpoint/widgets/page_under_construction.dart';
import 'package:gigpoint/widgets/textfield_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarWidget(
          title: isVisible ? 'Edit Profile' : 'My Profile',
          actions: const [],
        ),
        bottomNavigationBar: isVisible
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: ButtonWidget(
                  name: 'Save',
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                ),
              )
            : null,
        body: 1 == 1
            ? const PageUnderConstruction()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    const SizedBox(height: 59),
                    Stack(children: [
                      const CacheImage(
                        imageUrl:
                            'https://www.w3schools.com/w3images/avatar2.png',
                        isCircle: false,
                        height: 92,
                        width: 96,
                      ),
                      Positioned(
                          bottom: 0,
                          right: 2,
                          child: Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                color: AppTheme.primaryColor),
                            height: 24,
                            width: 24,
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ))
                    ]),
                    const SizedBox(height: 24),
                    Text(
                      'Tim Koorbush',
                      style: Styles.bold(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Male${','} 15-05-1990',
                      style: Styles.semiBold(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'timkoorbush@gmail.com',
                      style: Styles.semiBold(fontSize: 16),
                    ),
                    const SizedBox(height: 55),
                    isVisible ? const numberTextField() : button()
                  ],
                ),
              ));
  }

  Widget button() {
    return ButtonWidget(
        name: 'Change Mobile Number',
        onTap: () {
          setState(() {
            isVisible = !isVisible;
          });
        });
  }
}

// ignore: camel_case_types
class numberTextField extends StatefulWidget {
  const numberTextField({Key? key}) : super(key: key);

  @override
  _numberTextFieldState createState() => _numberTextFieldState();
}

// ignore: camel_case_types
class _numberTextFieldState extends State<numberTextField> {
  TextEditingController zipcodeController = TextEditingController();

  FocusNode zipcodeFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      controller: zipcodeController,
      focusNode: zipcodeFocus,
      nextFocus: FocusNode(),
      maxLength: 15,
      onFocusChange: (val) {
        setState(() {});
      },
      title: 'Mobile Number',
      hasError: false,
      errorText: 'Invalid data. Please re-enter',
      textInputType: TextInputType.number,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
    );
  }
}
