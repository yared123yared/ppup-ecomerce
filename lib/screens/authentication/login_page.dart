import 'package:flutter/material.dart';
import 'package:gigpoint/bloc/auth/login_bloc.dart';
import 'package:gigpoint/bloc/connectivity_listner_bloc.dart';
import 'package:gigpoint/config/env.dart';
import 'package:gigpoint/config/validations.dart';
import 'package:gigpoint/dialog/exit_dialog.dart';
import 'package:gigpoint/dialog/login_alert_info.dart';
import 'package:gigpoint/dialog/verify_email_dialog.dart';
import 'package:gigpoint/screens/general/webview_page.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/utils/validations.dart';
import 'package:gigpoint/widgets/button_widget.dart';
import 'package:gigpoint/widgets/outline_button_widget.dart';
import 'package:gigpoint/widgets/svg_image.dart';
import 'package:gigpoint/widgets/textfield_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool obscureText = true;
  bool hasEmailError = false;
  bool hasPasswordError = false;

  LoginBloc loginBloc = getIt<LoginBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    loginBloc.dispose();
    super.dispose();
  }

  Future<bool> _onBackPressed() {
    AppUtils.dialogBuilder(context, const ExitDialog());
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
          body: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              const SizedBox(height: 60),
              const SvgImage(asset: Images.logo, width: 64, height: 64),
              const SizedBox(height: 15),
              Text(
                'Hi, Welcome',
                textAlign: TextAlign.center,
                style: Styles.semiBold(fontSize: 21, letterSpacing: 0),
              ),
              const SizedBox(height: 6),
              Text(
                'Welcome to GigPoint. Sign in with your Point Pickup Driver email account and password',
                textAlign: TextAlign.center,
                style: Styles.semiBold(fontSize: 14, letterSpacing: 0),
              ),
              const SizedBox(height: 43),
              TextFieldWidget(
                title: 'Email',
                controller: _emailController,
                focusNode: _emailFocus,
                nextFocus: _passwordFocus,
                textCapitalization: TextCapitalization.words,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                hasError: hasEmailError,
                errorText: Validations.EMAIL_VALIDATION,
                suffixIcon: IconButton(
                  splashRadius: 1,
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    showLoginAlertDialog();
                  },
                  icon: const Icon(
                    Icons.info_outline,
                    color: AppTheme.primaryColor,
                  ),
                ),
                onFocusChange: (bool value) {
                  setState(() {
                    if (_emailController.text.isNotEmpty) {
                      hasEmailError = !_emailController.text.isValidEmail();
                    }
                  });
                },
              ),
              const SizedBox(height: 12),
              TextFieldWidget(
                title: 'Password',
                controller: _passwordController,
                focusNode: _passwordFocus,
                obscureText: obscureText,
                nextFocus: FocusNode(),
                textCapitalization: TextCapitalization.none,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                hasError: hasPasswordError,
                errorText: Validations.PASSWORD_VALIDATION,
                suffixIcon: IconButton(
                  splashRadius: 1,
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: Icon(
                    !obscureText
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.grey,
                  ),
                ),
                onFocusChange: (bool value) {
                  setState(() {
                    if (_passwordController.text.isNotEmpty) {
                      hasPasswordError = _passwordController.text.isEmpty;
                    }
                  });
                },
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => onForgotPasswordTap(),
                  child: Text(
                    'I Forgot My Password',
                    style: Styles.semiBold(fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              ButtonWidget(
                  name: 'Sign In',
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    login();
                  }),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'OR',
                  textAlign: TextAlign.center,
                  style: Styles.semiBold(fontSize: 14),
                ),
              ),
              OutlineButtonWidget(
                name: 'Sign Up with Point Pickup',
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  AppUtils.openDriverApp();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onForgotPasswordTap() {
    FocusScope.of(context).requestFocus(FocusNode());
    getIt<ConnectivityListnerBloc>().getNetworkStatus().then((value) {
      if (value) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    WebviewPage(url: Env.FORGOT_PASSWORD_URL)));
      } else {
        AppUtils.showErrorSnackbar(context, Validations.NO_NETWORK);
      }
    });
  }

  void login() {
    setState(() {
      hasEmailError = !_emailController.text.isValidEmail();
      hasPasswordError = _passwordController.text.isEmpty;
    });
    if (!hasEmailError && !hasPasswordError) {
      getIt<ConnectivityListnerBloc>().getNetworkStatus().then((value) {
        if (value) {
          loginBloc.login(context, _emailController.text.toLowerCase(),
              _passwordController.text);
        } else {
          AppUtils.showErrorSnackbar(context, Validations.NO_NETWORK);
        }
      });
    }
  }

  void showLoginAlertDialog() {
    AppUtils.dialogBuilder(context, const LoginAlertInfo());
  }

  void showVerifyEmailDialog() {
    AppUtils.dialogBuilder(context, const VerifyEmailDialog());
  }
}
