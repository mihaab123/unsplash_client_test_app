import 'package:unsplash_client_test_app/models/photo_model.dart';

class SimpleAppState {
  final List<Photo> photos;
  final String searchText;

  const SimpleAppState(this.photos, this.searchText);

  /*const SimpleAppState.initialState()
      : photos = <Photo>[];*/

  SimpleAppState copyWith(List<Photo> list, String s,
      {List<Photo>? photos, String? searchText}) {
    return SimpleAppState(
      photos ?? this.photos,
      searchText ?? this.searchText,
    );
  }

  @override
  String toString() {
    return 'photos is $photos, searchText is $searchText';
  }
}
