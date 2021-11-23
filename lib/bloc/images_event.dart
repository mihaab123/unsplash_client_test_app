import 'package:rebloc/rebloc.dart';

class LoadImagesAction extends Action {}

class SearchImagesAction extends Action {
  final String searchKey;

  SearchImagesAction(this.searchKey);
}

class ResetSearchAction extends Action {}
