import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:unsplash_client_test_app/models/photo_model.dart';
import 'package:unsplash_client_test_app/models/user.dart';
import 'package:unsplash_client_test_app/widgets/image_item.dart';
import 'package:unsplash_client_test_app/widgets/loading_indicator.dart';
import 'package:unsplash_client_test_app/widgets/unsplash_image_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  /// Stores the current page index for the api requests.
  int page = 0, totalPages = -1;

  /// Stores the currently loaded loaded images.
  List<Photo> images = [];

  /// States whether there is currently a task running loading images.
  bool loadingImages = false;

  /// Stored the currently searched keyword.
  String keyword = "";

  @override
  initState() {
    super.initState();
    // initial image Request
    _loadImages(keyword: "");
  }

  /// Resets the state to the inital state.
  _resetImages() {
    // clear image list
    images = [];
    // reset page counter
    page = 0;
    totalPages = -1;
    // reset keyword
    keyword = "";
    // show regular images
    _loadImages(keyword: '');
  }

  /// Requests a list of [Photo] for a given [keyword].
  /// If the given [keyword] is null, trending images are loaded.
  _loadImages({required String keyword}) async {
    // check if there is currently a loading task running
    if (loadingImages) {
      // there is currently a task running
      return;
    }
    // check if all pages are already loaded
    if (totalPages != -1 && page >= totalPages) {
      // all pages already loaded
      return;
    }
    // set loading state
    // delay setState, otherwise: Unhandled Exception: setState() or markNeedsBuild() called during build.
    await Future.delayed(const Duration(microseconds: 1));
    setState(() {
      // set loading
      loadingImages = true;
      // check if new search
      if (this.keyword != keyword) {
        // clear images for new search
        this.images = [];
        // reset page counter
        page = 0;
      }
      // keyword null
      this.keyword = keyword;
    });
    // load images
    List<Photo> images;
    if (keyword == "") {
      // load images from the next page of trending images
      images =
          await UnsplashImageProvider.loadImages(page: ++page) as List<Photo>;
    } else {
      // load images from the next page with a keyword
      List res = await UnsplashImageProvider.loadImagesWithKeyword(keyword,
          page: ++page);
      // set totalPages
      totalPages = res[0];
      // set images
      images = res[1];
    }

    // TODO: handle errors

    // update the state
    setState(() {
      // done loading
      loadingImages = false;
      // set new loaded images
      this.images.addAll(images);
    });
  }

  /// Asynchronously loads a [UnsplashImage] for a given [index].
  Future<Photo?> _loadImage(int index) async {
    // check if new images need to be loaded
    if (index >= images.length - 2) {
      // Reached the end of the list. Try to load more images.
      //_loadImages(keyword: keyword);
    }

    return index < images.length ? images[index] : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OrientationBuilder(
            builder: (context, orientation) => CustomScrollView(
                    // put AppBar in NestedScrollView to have it sliver off on scrolling
                    slivers: <Widget>[
                      _buildSearchAppBar(),
                      loadingImages
                          ? SliverToBoxAdapter(
                              child:
                                  LoadingIndicator(Colors.grey[400] as Color),
                            )
                          : _buildImageGrid(orientation: orientation),
                    ])));
  }

  /// Returns the SearchAppBar.
  Widget _buildSearchAppBar() => SliverAppBar(
        title: keyword != ""
            ?
            // either search-field or just the title
            TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: 'Search...', border: InputBorder.none),
                onSubmitted: (String keyword) =>
                    // search and display images associated to the keyword
                    //print(""),
                    _loadImages(keyword: keyword),
                autofocus: true,
              )
            : const Text('Unsplash Client',
                style: TextStyle(color: Colors.black87)),
        actions: <Widget>[
          // either search oder clear button
          keyword != ""
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  color: Colors.black87,
                  onPressed: () {
                    // reset the state
                    _resetImages();
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.search),
                  color: Colors.black87,
                  onPressed: () =>
                      // go into searching state
                      setState(() => keyword = "find"),
                )
        ],
        backgroundColor: Colors.grey[50],
      );

  /// Returns a StaggeredTile for a given [image].
  StaggeredTile _buildStaggeredTile(Photo image, int columnCount) {
    // calc image aspect ration
    double aspectRatio = image.height.toDouble() / image.width.toDouble();
    // calc columnWidth
    double columnWidth = MediaQuery.of(context).size.width / columnCount;
    // not using [StaggeredTile.fit(1)] because during loading StaggeredGrid is really jumpy.
    return StaggeredTile.extent(1, aspectRatio * columnWidth);
  }

  /// Returns the grid that displays images.
  /// [orientation] can be used to adjust the grid column count.
  Widget _buildImageGrid({orientation = Orientation.portrait}) {
    // calc columnCount based on orientation
    int columnCount = orientation == Orientation.portrait ? 2 : 3;
    // return staggered grid
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverStaggeredGrid.countBuilder(
        // set column count
        crossAxisCount: columnCount,
        itemCount: images.length,
        // set itemBuilder
        itemBuilder: (BuildContext context, int index) =>
            _buildImageItemBuilder(index),
        staggeredTileBuilder: (int index) =>
            _buildStaggeredTile(images[index], columnCount),
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
      ),
    );
  }

  /// Returns a FutureBuilder to load a [Photo] for a given [index].
  Widget _buildImageItemBuilder(int index) => FutureBuilder(
        // pass image loader
        future: _loadImage(index),
        builder: (context, snapshot) =>
            // image loaded return [_ImageTile]
            ImageItem(snapshot.data as Photo),
      );
}
