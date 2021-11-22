import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:unsplash_client_test_app/models/photo_model.dart';
import 'package:unsplash_client_test_app/widgets/info_sheet.dart';
import 'package:unsplash_client_test_app/widgets/unsplash_image_provider.dart';

/// Screen for showing an individual [Photo].
class ImageScreen extends StatefulWidget {
  final String imageId, imageUrl;

  const ImageScreen(this.imageId, this.imageUrl, {Key? key}) : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

/// Provide a state for [ImageScreen].
class _ImageScreenState extends State<ImageScreen> {
  /// create global key to show info bottom sheet
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// Bottomsheet controller
  late PersistentBottomSheetController bottomSheetController;

  /// Displayed image.
  late Photo image;

  @override
  void initState() {
    super.initState();
    // load image
    _loadImage();
  }

  /// Reloads the image from unsplash to get extra data, like: exif, location, ...
  _loadImage() async {
    Photo image = await UnsplashImageProvider.loadImage(widget.imageId);
    setState(() {
      this.image = image;
      // reload bottom sheet if open
      /*if (bottomSheetController != null) {
        _showInfoBottomSheet();
      }*/
    });
  }

  /// Returns AppBar.
  Widget _buildAppBar() => AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading:
            // back button
            IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context)),
        actions: <Widget>[
          // show image info
          IconButton(
              icon: const Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
              tooltip: 'Image Info',
              onPressed: () => bottomSheetController = _showInfoBottomSheet()),
          // open in browser icon button
          IconButton(
              icon: const Icon(
                Icons.open_in_browser,
                color: Colors.white,
              ),
              tooltip: 'Open in Browser',
              onPressed: () {}),
        ],
      );

  /// Returns PhotoView around given [imageId] & [imageUrl].
  Widget _buildPhotoView(String imageId, String imageUrl) => PhotoView(
        imageProvider: NetworkImage(imageUrl),
        initialScale: PhotoViewComputedScale.covered,
        minScale: PhotoViewComputedScale.covered,
        maxScale: PhotoViewComputedScale.covered,
        heroAttributes: PhotoViewHeroAttributes(tag: imageId),
        loadingBuilder: (context, progress) => const Center(
            child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
        )),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // set the global key
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          _buildPhotoView(widget.imageId, widget.imageUrl),
          // wrap in Positioned to not use entire screen
          Positioned(top: 0.0, left: 0.0, right: 0.0, child: _buildAppBar()),
        ],
      ),
    );
  }

  /// Shows a BottomSheet containing image info.
  PersistentBottomSheetController _showInfoBottomSheet() {
    return _scaffoldKey.currentState!.showBottomSheet(
      (context) => InfoSheet(image),
    );
  }
}
