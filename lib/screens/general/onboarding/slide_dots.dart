import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';

class SlideDots extends StatelessWidget {
  final bool isActive;
  const SlideDots({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3.3),
      height: 15,
      width: 15,
      decoration: BoxDecoration(
        color: isActive ? AppTheme.primaryColor : Colors.white,
        border: !isActive
            ? Border.all(
                color: Colors.grey,
              )
            : Border.all(
                color: Colors.transparent,
              ),
        borderRadius: const BorderRadius.all(Radius.circular(50)),
      ),
    );
  }
}
