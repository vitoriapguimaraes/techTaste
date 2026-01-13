import 'package:flutter/material.dart';
import 'package:tech_taste/ui/_core/app_colors.dart';
import 'package:tech_taste/ui/_core/app_text_styles.dart';

class CategoryWidget extends StatelessWidget {
  final String category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryWidget({
    super.key,
    required this.category,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.mainColor.withOpacity(0.2) : AppColors.cardColor,
      borderRadius: BorderRadius.circular(16.0),
      elevation: isSelected ? 4.0 : 2.0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          width: 100,
          height: 100,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: isSelected
                ? Border.all(color: AppColors.mainColor, width: 2.0)
                : null,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8.0,
            children: [
              Image.asset(
                "assets/categories/${category.toLowerCase()}.png",
                height: 48,
                color: isSelected ? AppColors.mainColor : null,
                colorBlendMode: isSelected ? BlendMode.modulate : null,
              ),
              Text(
                category,
                style: AppTextStyles.bodySecondary.copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? AppColors.mainColor : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
