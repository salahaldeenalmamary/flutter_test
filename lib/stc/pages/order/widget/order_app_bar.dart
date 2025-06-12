import 'package:flutter/material.dart';
import '../../../theme/app_styles.dart';

class OrderAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OrderAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorTheme.background,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: ColorTheme.textPrimary),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text('Order',
          style: FontTheme.title.copyWith(color: ColorTheme.textPrimary)),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
