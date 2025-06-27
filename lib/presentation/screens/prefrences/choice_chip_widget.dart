import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/colors_manager.dart';

class ChoiceChipWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const ChoiceChipWidget({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(text),
      selected: isSelected,
      onSelected: onSelected,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: FontWeight.w500,
      ),
      backgroundColor: Colors.grey.shade200,
      selectedColor: ColorsManger.newSecondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.r),
        side: BorderSide(
          color: isSelected
              ? ColorsManger.newSecondaryColor
              : Colors.grey.shade400,
        ),
      ),
      padding: REdgeInsets.symmetric(horizontal: 12, vertical: 8),
      showCheckmark: false,
    );
  }
}
