library image_collapse;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_collapse/gallery_item.dart';
import 'package:image_collapse/gallery_view_wrapper.dart';
import 'package:image_collapse/gallery_thumbnail.dart';

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
  static const NUM_IMAGE_COLLAPSE = 4;
  static final List<GalleryItem> _galleryItems = <GalleryItem>[];
  static const MAX_LOAD_MORE = 10;

  @override
  void initState() {
    bindingToGalleryItem(widget.imageUrls);
    super.initState();
  }

  bindingToGalleryItem(List<String> imageUrls) {
    _galleryItems.clear();
    var imageName, tagId;
    imageUrls.forEach((imageUrl) {
      imageName = imageUrl.split('/').last;
      tagId = DateTime.now().microsecondsSinceEpoch;
      _galleryItems.add(
        GalleryItem(
          id: '$imageName-$tagId',
          imageUrl: imageUrl,
        ),
      );
    });
  }

  Widget _buildLoading() {
    return CupertinoActivityIndicator();
  }

  Widget _buildImageCollapses() {
    int imageUrlsLength = widget.imageUrls.length;
    switch (widget.displayType) {
      case DisplayType.ListView:
        return ListView.builder(
          itemCount: imageUrlsLength,
          padding: widget.padding,
          itemBuilder: (context, index) {
            return Card(
                    child: Container(
                      height: widget.imageSize.height,
                      width: widget.imageSize.width,
                      child: GalleryThumbnail(
                        galleryItem: _galleryItems[index],
                        onTap: () => openImageFullScreen(context, index),
                      ),
                    ),
                  );
          },
        );
      case DisplayType.StaggeredGridView:
      default:
        return StaggeredGridView.countBuilder(
          crossAxisCount: widget.crossAxisCount,
          mainAxisSpacing: widget.mainAxisSpacing,
          crossAxisSpacing: widget.crossAxisSpacing,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 12, bottom: 16),
          itemCount: imageUrlsLength > NUM_IMAGE_COLLAPSE
              ? NUM_IMAGE_COLLAPSE
              : imageUrlsLength,
          itemBuilder: (context, int index) {
            return Container(
              height: 252,
              child: imageUrlsLength > NUM_IMAGE_COLLAPSE && index == 3
                  ? buildImageNumbers(context, index)
                  : GalleryThumbnail(
                      galleryItem: _galleryItems[index],
                      onTap: () => openImageFullScreen(context, index),
                    ),
            );
          },
          staggeredTileBuilder: (int index) => StaggeredTile.count(
            crossAxisCellCount(imageUrlsLength, index),
            mainAxisCellCount(imageUrlsLength, index),
          ),
        );
    }
  }

  int crossAxisCellCount(int length, int index) {
    if (length == 1)
      return 6;
    else if (length == 2)
      return 3;
    else if (length == 3) {
      if (index < 1) return 6;
      return 3;
    } else {
      if (index < 1) return 6;
      return 2;
    }
  }

  double mainAxisCellCount(int galleryLength, int index) {
    if (galleryLength == 1) {
      return 4;
    } else if (galleryLength != 2) {
      if (index == 0) return 3;
    }
    return 2;
  }

  Widget buildImageNumbers(
    context,
    int indexOfImage,
  ) {
    int remainNumberImage = widget.imageUrls.length - indexOfImage;
    return GestureDetector(
      onTap: () => openImageFullScreen(context, indexOfImage),
      child: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.expand,
        children: [
          GalleryThumbnail(
            galleryItem: _galleryItems[indexOfImage],
          ),
          Container(
            color: widget.fadingColorCollapse ?? Colors.black.withOpacity(0.7),
            alignment: Alignment.center,
            child: Text(
              "+$remainNumberImage",
              style: widget.remainNumberStyle ??
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

  void openImageFullScreen(context, int indexOfImage) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return GalleryViewWrapper(
          appBarColor: widget.appBarColor,
          titleGallery: widget.titleGallery,
          galleryItem: _galleryItems,
          backgroundDecoration: widget.backgroundImageView ??
              const BoxDecoration(color: Color(0xff374056)),
          initialIndex: indexOfImage,
          scrollDirection: Axis.horizontal,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.imageUrls.isEmpty ? _buildLoading() : _buildImageCollapses();
  }
}
