import 'package:flutter/material.dart';

class IncDecWidget extends StatelessWidget {
  const IncDecWidget({Key? key, required this.isAdd, required this.onTap})
      : super(key: key);
  final bool isAdd;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              spreadRadius: 0,
              blurRadius: 7,
              offset: Offset(0.1, 0.1),
            ),
          ],
        ),
        child: Icon(
          isAdd ? Icons.add : Icons.remove,
          size: 18,
          color: const Color.fromRGBO(135, 133, 154, 1),
        ),
      ),
    );
  }
}
