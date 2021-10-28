import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gigpoint/screens/shop/product_search/product_search_page.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget(
      {Key? key,
      required this.isFromSearch,
      this.onChanged,
      this.controller,
      this.focusNode})
      : super(key: key);

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool isFromSearch;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      color: AppTheme.scaffoldBackground,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: Styles.semiBold(fontSize: 14),
        readOnly: !isFromSearch,
        autofocus: isFromSearch,
        autocorrect: false,
        enableSuggestions: false,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp('^\\s+|\\s+\$/gm')),
        ],
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        onChanged: onChanged,
        onSubmitted: (val) => focusNode?.unfocus(),
        onTap: isFromSearch
            ? null
            : () {
                Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    maintainState: true,
                    pageBuilder: (BuildContext context, _, __) =>
                        const ProductSearchPage()));
              },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search Products',
          hintStyle: Styles.semiBold(
            fontSize: 14,
            color: AppTheme.textPrimaryColor,
          ),
          prefixIcon: Icon(
            CupertinoIcons.search,
            color: isFromSearch ? Colors.black54 : AppTheme.primaryColor,
          ),
        ),
      ),
    );
  }
}
