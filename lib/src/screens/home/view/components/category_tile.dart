import 'package:flutter/material.dart';

import '../../../../config/custom_colors.dart';

class CategoryTile extends StatelessWidget {
  final String category;
  final bool isSelected;
  final VoidCallback onPressed;

  const CategoryTile({
    Key? key,
    required this.category,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        borderRadius: BorderRadius.circular(30.0),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: isSelected
                ? CustomColors.customSwatchColor
                : Colors.transparent,
          ),
          child: Text(
            category,
            style: TextStyle(
              color:
                  isSelected ? Colors.white : CustomColors.customContrastColor,
              fontWeight: FontWeight.bold,
              fontSize: isSelected ? 16.0 : 14.0,
            ),
          ),
        ),
      ),
    );
  }
}
