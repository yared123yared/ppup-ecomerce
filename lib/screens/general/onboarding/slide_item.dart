import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gigpoint/model/slide.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/svg_image.dart';

class SlideItem extends StatelessWidget {
  final int index;
  final Slide slide;
  final Color titleColor;

  const SlideItem(
      {Key? key,
      required this.index,
      required this.slide,
      this.titleColor = AppTheme.primaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2.2,
            color: AppTheme.primaryLightColor,
            padding: const EdgeInsets.all(30),
            child: SvgImage(
              asset: slide.image,
              boxFit: BoxFit.contain,
            )),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                slide.title,
                textAlign: TextAlign.center,
                style: Styles.bold(fontSize: 20, color: titleColor),
              ),
              if (slide.desc.isNotEmpty) const SizedBox(height: 8),
              if (slide.desc.isNotEmpty)
                Html(
                    data:
                        '<p style="font-size:14px; font-weight: 500; color:black; text-align:center; font-family: Open Sans; line-height: 20px">${slide.desc}</p>',
                    shrinkWrap: true)
              // Text(
              //   slide.desc,
              //   textAlign: TextAlign.center,
              //   style: Styles.semiBold(fontSize: 14, color: Colors.black),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
