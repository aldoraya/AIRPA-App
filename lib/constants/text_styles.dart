import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';

class TextStyles {
  final BuildContext context;

  TextStyles(this.context);

  TextStyle getTitleStyle() {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: 24,
          color: AppTheme.primaryTextColor,
        );
  }

  TextStyle getDescriptionStyle() {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: AppTheme.secondaryTextColor,
        );
  }

  TextStyle getRegularStyle() {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 16,
          color: AppTheme.primaryTextColor,
        );
  }

  TextStyle getBoldStyle() {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: 14,
          color: AppTheme.primaryTextColor,
        );
  }
}