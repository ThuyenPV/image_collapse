library image_collapse;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_collapse/src/model/gallery.dart';
import 'package:image_collapse/src/widgets/gallery_overview.dart';

enum DisplayType {
  ListView,
  StaggeredGridView,
}

class ImageCollapse extends StatefulWidget {
  final List<String> imageUrls;
  final String? titleGallery;
  final TextStyle? remainNumberStyle;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final BoxDecoration? backgroundImageView;
  final Color? fadingColorCollapse;
  final Color? appBarColor;
  final DisplayType displayType;
  final Size imageSize;
  final EdgeInsetsGeometry? padding;

  const ImageCollapse({
    Key? key,
    required this.imageUrls,
    this.titleGallery,
    this.remainNumberStyle,
    this.crossAxisCount = 6,
    this.mainAxisSpacing = 4.0,
    this.crossAxisSpacing = 4.0,
    this.backgroundImageView,
    this.fadingColorCollapse,
    this.appBarColor,
    this.displayType = DisplayType.StaggeredGridView,
    this.imageSize = const Size(double.infinity, 150),
    this.padding,
  }) : super(key: key);

  @override
  _ImageCollapseState createState() => _ImageCollapseState();
}

class _ImageCollapseState extends State<ImageCollapse> {
  static final _galleryItems = <Gallery>[];

  @override
  void initState() {
    convertToGalleryModel(widget.imageUrls);
    super.initState();
  }

  convertToGalleryModel(List<String> imageUrls) {
    _galleryItems.clear();
    var imageName, tagId;
    for (var imageUrl in imageUrls) {
      imageName = imageUrl.split('/').last;
      tagId = DateTime.now().microsecondsSinceEpoch;
      _galleryItems.add(
        Gallery(
          id: '$imageName-$tagId',
          url: imageUrl,
        ),
      );
    }
  }

  Widget _buildGalleryCollapse() {
    switch (widget.displayType) {
      case DisplayType.ListView:
        return GalleryListView(
          key: const ValueKey('2ff0118c-cf6b-11ec-9d64-0242ac120002'),
          galleryList: _galleryItems,
          padding: widget.padding,
          imageSize: widget.imageSize,
        );
      case DisplayType.StaggeredGridView:
      default:
        return GalleryStaggeredGridView(
          key: const ValueKey('7f749548-cf70-11ec-9d64-0242ac120002'),
          galleryList: _galleryItems,
          crossAxisCount: widget.crossAxisCount,
          mainAxisSpacing: widget.mainAxisSpacing,
          crossAxisSpacing: widget.crossAxisSpacing,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _galleryItems.isEmpty
        ? const CupertinoActivityIndicator(
            key: ValueKey('037a00ea-cf6b-11ec-9d64-0242ac120002'),
          )
        : _buildGalleryCollapse();
  }
}
