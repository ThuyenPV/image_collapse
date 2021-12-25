import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'gallery_item.dart';

class GalleryViewWrapper extends StatefulWidget {
  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final int? initialIndex;
  final PageController pageController;
  final List<GalleryItem> galleryItem;
  final Axis scrollDirection;
  final String? titleGallery;
  final Color? appBarColor;

  GalleryViewWrapper({
    this.loadingBuilder,
    this.titleGallery,
    this.backgroundDecoration,
    this.initialIndex,
    required this.galleryItem,
    this.appBarColor,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex ?? 0);

  @override
  State<StatefulWidget> createState() => _GalleryViewWrapperState();
}

class _GalleryViewWrapperState extends State<GalleryViewWrapper> {
  final minScale = PhotoViewComputedScale.contained * 0.8;
  final maxScale = PhotoViewComputedScale.covered * 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: const EdgeInsets.all(0),
          icon: BackButtonIcon(),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: widget.appBarColor ?? Color(0xff374056),
        title: Text(
          widget.titleGallery ?? 'Gallery',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: _buildImage,
          itemCount: widget.galleryItem.length,
          loadingBuilder: widget.loadingBuilder,
          backgroundDecoration: widget.backgroundDecoration,
          pageController: widget.pageController,
          scrollDirection: widget.scrollDirection,
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildImage(BuildContext context, int index) {
    final gallery = widget.galleryItem[index];
    return PhotoViewGalleryPageOptions.customChild(
      minScale: minScale,
      maxScale: maxScale,
      initialScale: PhotoViewComputedScale.contained,
      heroAttributes: PhotoViewHeroAttributes(tag: gallery.id),
      child: CachedNetworkImage(
        imageUrl: gallery.imageUrl,
        placeholder: (_, __) => const CupertinoActivityIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
