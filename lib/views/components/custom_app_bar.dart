import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String title;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const CustomAppBar({
    super.key,
    this.leading,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: BounceInDown(child: Text(title)),
      centerTitle: true,
      actions: actions,
    );
  }
}
