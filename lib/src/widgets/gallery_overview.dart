import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_collapse/src/model/gallery_item.dart';
import 'package:image_collapse/src/widgets/gallery_thumbnail.dart';

const NUM_IMAGE_COLLAPSE = 4;

/// ListView type
class GalleryListView extends StatelessWidget {
  const GalleryListView({
    Key? key,
    required this.galleryList,
    this.padding,
    this.imageSize = const Size(double.infinity, 150),
  }) : super(key: key);

  final List<Gallery> galleryList;
  final EdgeInsetsGeometry? padding;
  final Size? imageSize;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: galleryList.length,
      padding: padding,
      itemBuilder: (context, index) {
        return Card(
          child: SizedBox(
            height: imageSize?.height,
            width: imageSize?.width,
            child: GalleryThumbnail(
              galleryItem: galleryList[index],
              onTap: () => onTapFullScreenView(
                context,
                indexOfImage: index,
                galleryList: galleryList,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Staggered gridView type
class GalleryStaggeredGridView extends StatelessWidget {
  const GalleryStaggeredGridView({
    Key? key,
    required this.galleryList,
    required this.crossAxisCount,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    this.padding,
    this.remainNumberStyle,
    this.imageSize = const Size(double.infinity, 150),
  }) : super(key: key);

  final List<Gallery> galleryList;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final EdgeInsetsGeometry? padding;
  final TextStyle? remainNumberStyle;
  final Size? imageSize;

  @override
  Widget build(BuildContext context) {
    final galleryLength = galleryList.length;
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      itemCount: galleryLength > NUM_IMAGE_COLLAPSE ? NUM_IMAGE_COLLAPSE : galleryLength,
      itemBuilder: (context, int index) {
        return SizedBox(
          height: 252,
          child: galleryLength > NUM_IMAGE_COLLAPSE && index == 3
              ? GalleryRemainder(
                  remainNumber: galleryLength - NUM_IMAGE_COLLAPSE + 1,
                  indexOfImage: index,
                  remainderStyle: remainNumberStyle,
                  galleryList: galleryList,
                )
              : GalleryThumbnail(
                  galleryItem: galleryList[index],
                  onTap: () => onTapFullScreenView(
                    context,
                    indexOfImage: index,
                    galleryList: galleryList,
                  ),
                ),
        );
      },
      staggeredTileBuilder: (int index) => StaggeredTile.count(
        crossAxisCellCount(galleryLength, index),
        mainAxisCellCount(galleryLength, index),
      ),
    );
  }

  int crossAxisCellCount(int length, int index) {
    if (length == 1) {
      return 6;
    } else if (length == 2) {
      return 3;
    } else if (length == 3) {
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

  Widget buildGalleryRemain(
    context,
    int indexOfImage,
  ) {
    var remainNumber = galleryList.length - indexOfImage;
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
              '+$remainNumber',
              style: remainNumberStyle ??
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
