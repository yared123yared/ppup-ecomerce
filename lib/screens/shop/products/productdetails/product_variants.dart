import 'package:flutter/material.dart';
import 'package:gigpoint/model/product_details.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/cache_image.dart';

class ProductVariants extends StatelessWidget {
  const ProductVariants(
      {Key? key,
      required this.variant,
      required this.isSelected,
      required this.onTap,
      required this.varientIndex})
      : super(key: key);
  final ProductSkus variant;
  final bool isSelected;
  final GestureTapCallback onTap;
  final int varientIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: SizedBox(
            width: 82,
            height: 92,
            child: Card(
                color: isSelected
                    ? const Color.fromRGBO(241, 241, 241, 1)
                    : Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CacheImage(
                    imageUrl: variant.imageHash,
                  ),
                )),
          ),
        ),
        const SizedBox(height: 7),
        if (variant.options.isNotEmpty)
          Text(
            variant.options[varientIndex].color ??
                variant.options[varientIndex].size ??
                '',
            style: Styles.semiBold(fontSize: 12),
          ),
      ],
    );
  }
}
