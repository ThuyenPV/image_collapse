import 'package:flutter/material.dart';
import 'package:image_collapse/src/core/app_constant.dart';

class GalleryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GalleryAppBar({
    this.title = AppConstant.APP_NAME,
    this.color,
  });

  final String? title;
  final Color? color;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        padding: EdgeInsets.zero,
        icon: const BackButtonIcon(),
        color: Colors.white,
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: color ?? const Color(0xff374056),
      title: Text(
        title ?? '',
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
