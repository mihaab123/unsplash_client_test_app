import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unsplash_client_test_app/models/photo_model.dart';
import 'package:unsplash_client_test_app/screens/image_screen.dart';

class ImageItem extends StatelessWidget {
  final Photo image;

  const ImageItem(this.image);

  /// Adds rounded corners to a given [widget].
  Widget _addRoundedCorners(Widget widget) =>
      // wrap in ClipRRect to achieve rounded corners
      ClipRRect(borderRadius: BorderRadius.circular(4.0), child: widget);

  /// Returns a placeholder to show until an image is loaded.
  Widget _buildImagePlaceholder({Photo? image}) => Container(
        color: image != null
            ? Color(
                int.parse(image.color.substring(1, 7), radix: 16) + 0x64000000)
            : Colors.grey[200],
      );

  /// Returns a error placeholder to show until an image is loaded.
  Widget _buildImageErrorWidget() => Container(
        color: Colors.grey[200],
        child: Center(
            child: Icon(
          Icons.image_not_supported,
          color: Colors.grey[400],
        )),
      );

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          // item onclick
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) =>
                  ImageScreen(image.id, image.urls.full.toString())));
        },
        // Hero Widget for Hero animation with [ImagePage]
        child: image != null
            ? Hero(
                tag: image.id,
                child: _addRoundedCorners(CachedNetworkImage(
                  imageUrl: image.urls.small.toString(),
                  placeholder: (context, url) =>
                      _buildImagePlaceholder(image: image),
                  errorWidget: (context, url, obj) => _buildImageErrorWidget(),
                  fit: BoxFit.cover,
                )))
            : _buildImagePlaceholder(image: null),
      );
}
