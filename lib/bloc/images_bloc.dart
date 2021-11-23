import 'dart:async';

import 'package:rebloc/rebloc.dart';
import 'package:unsplash_client_test_app/bloc/images_event.dart';
import 'package:unsplash_client_test_app/bloc/images_state.dart';
import 'package:unsplash_client_test_app/models/photo_model.dart';
import 'package:unsplash_client_test_app/widgets/unsplash_image_provider.dart';

class ImagesBloc extends Bloc<SimpleAppState> {
  @override
  Stream<WareContext<SimpleAppState>> applyAfterware(
      Stream<WareContext<SimpleAppState>> input) {
    return input;
  }

  @override
  Stream<WareContext<SimpleAppState>> applyMiddleware(
      Stream<WareContext<SimpleAppState>> input) {
    input.listen((context) async {
      if (context.action is LoadImagesAction) {
        List<Photo> list =
            await UnsplashImageProvider.loadImages(page: 0) as List<Photo>;
        context.state.copyWith(list, "");
      }
    });

    return input;
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Stream<Accumulator<SimpleAppState>> applyReducer(
      Stream<Accumulator<SimpleAppState>> input) {
    // TODO: implement applyReducer
    throw UnimplementedError();
  }
}
