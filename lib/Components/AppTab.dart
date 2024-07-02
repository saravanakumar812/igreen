import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../forms/theme.dart';

class AppTab extends StatelessWidget {
  final EdgeInsets? margin, padding;
  final bool isSelected;
  final String title;
  final Function() onClick;
  final bool disable;

  const AppTab({
    this.margin,
    this.padding,
    this.isSelected = false,
    this.title = '',
    required this.onClick,
    this.disable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !disable,
      child: GestureDetector(
        onTap: () => onClick(),
        child: Container(
          padding: padding ?? EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          margin: margin ?? EdgeInsets.symmetric(horizontal: 12, vertical: 1),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.secondaryColor : Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? AppTheme.secondaryColor :AppTheme.liteGray,
            ),
          ),
          height: 39,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
