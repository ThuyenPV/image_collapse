import 'package:flutter/material.dart';

const GALLERY = 'Gallery';

class GalleryAppBar extends StatelessWidget implements PreferredSizeWidget {
  GalleryAppBar({
    this.title = GALLERY,
    this.color,
  });

  final String? title;
  final Color? color;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        padding: EdgeInsets.zero,
        icon: BackButtonIcon(),
        color: Colors.white,
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: color ?? Color(0xff374056),
      title: Text(
        title ?? '',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ); // Your custom widget implementation.
  }
}
