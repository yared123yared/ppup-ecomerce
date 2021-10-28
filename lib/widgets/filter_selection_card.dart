import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/svg_image.dart';

class FilterSelectionCard extends StatelessWidget {
  const FilterSelectionCard({
    Key? key,
    required this.onTap,
    required this.isSelected,
    this.asset,
    required this.title,
    required this.fontSize,
  }) : super(key: key);

  final GestureTapCallback onTap;
  final bool isSelected;
  final String? asset;
  final String title;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isSelected ? AppTheme.primaryColor : Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color:
                  !isSelected ? AppTheme.disabledColor : AppTheme.primaryColor,
            ),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: asset == null ? 0 : 12, horizontal: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (asset != null)
                SvgImage(
                  asset: asset ?? '',
                  width: 16,
                  height: 16,
                  color:
                      isSelected ? Colors.white : AppTheme.textSecondaryColor,
                ),
              if (asset != null) const SizedBox(width: 7),
              Flexible(
                child: Text(title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.semiBold(
                      fontSize: fontSize,
                      color:
                          isSelected ? Colors.white : AppTheme.textPrimaryColor,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
