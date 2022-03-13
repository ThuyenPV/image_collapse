import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_collapse/gallery_item.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'gallery_helper.dart';
import 'gallery_view_wrapper.dart';

class GalleryThumbnail extends StatelessWidget {
  const GalleryThumbnail({
    Key? key,
    required this.galleryItem,
    this.onTap,
  }) : super(key: key);

  final GalleryItem galleryItem;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: galleryItem.id,
        child: Visibility(
          visible: isImage(galleryItem.imageUrl),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: galleryItem.imageUrl,
            placeholder: (_, __) => const CupertinoActivityIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}

class GalleryRemainder extends StatelessWidget {
  const GalleryRemainder({
    Key? key,
    required this.indexOfImage,
    required this.galleryList,
    required this.remainNumber,
    required this.remainderStyle,
  }) : super(key: key);

  final List<GalleryItem> galleryList;
  final int indexOfImage;
  final int remainNumber;
  final TextStyle? remainderStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapFullScreenView(
        context,
        indexOfImage: indexOfImage,
        galleryList: galleryList,
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.expand,
        children: [
          GalleryThumbnail(
            galleryItem: galleryList[indexOfImage],
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
            alignment: Alignment.center,
            child: Text(
              "+$remainNumber",
              style: remainderStyle ??
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

void onTapFullScreenView(
  context, {
  required int indexOfImage,
  required List<GalleryItem> galleryList,
  Color? appBarColor,
  String? titleGallery,
  BoxDecoration? backgroundDecoration,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return GalleryViewWrapper(
        appBarColor: appBarColor,
        titleGallery: titleGallery,
        galleryItem: galleryList,
        backgroundDecoration: backgroundDecoration ?? const BoxDecoration(color: Color(0xff374056)),
        initialIndex: indexOfImage,
        scrollDirection: Axis.horizontal,
      );
    }),
  );
}
