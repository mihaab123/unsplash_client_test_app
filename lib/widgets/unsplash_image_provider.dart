import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:unsplash_client_test_app/models/photo_model.dart';

class UnsplashImageProvider {
  /// Asynchronously loads a [Photo] for a given [id].
  static Future<Photo> loadImage(String id) async {
    String url = 'https://api.unsplash.com/photos/$id';
    // receive image data from unsplash
    var data = await _getImageData(url);
    // return image
    return Photo.fromJson(data);
  }

  /// Asynchronously load a list of trending [Photo].
  /// Returns a list of [Photo].
  /// [page] is the page index for the api request.
  /// [perPage] sets the length of the returned list.
  static Future<List> loadImages({int page = 1, int perPage = 10}) async {
    String url = 'https://api.unsplash.com/photos?page=$page&per_page=$perPage';
    // receive image data from unsplash
    var data = await _getImageData(url);
    // generate Photo List from received data
    List<Photo> images = List<Photo>.generate(data.length, (index) {
      return Photo.fromJson(data[index]);
    });
    // return images
    return images;
  }

  /// Asynchronously load a list of [Photo] associated to a given [keyword].
  /// Returns a list where the first element is the [totalPages] available and the second element is a list of [UnsplashImage].
  /// [page] is the page index for the api request.
  /// [perPage] sets the length of the returned list.
  static Future<List> loadImagesWithKeyword(String keyword,
      {int page = 1, int perPage = 10}) async {
    // Search for image associated with the keyword
    String url =
        'https://api.unsplash.com/search/photos?query=$keyword&page=$page&per_page=$perPage&order_by=popular';
    // receive image data from unsplash associated to the given keyword
    var data = await _getImageData(url);
    // generate Photo List from received data
    List<Photo> images = List<Photo>.generate(data['results'].length, (index) {
      return Photo.fromJson(data['results'][index]);
    });
    int totalPages = data['total_pages'];
    // return Images
    return [totalPages, images];
  }

  /// Receive image data from a given [url] and return the JSON decoded the data.
  static dynamic _getImageData(String url) async {
    // setup
    var dio = Dio();
    dio.options
      ..responseType = ResponseType.json
      ..baseUrl = url
      ..connectTimeout = 5000 //5s
      ..receiveTimeout = 5000
      ..validateStatus = (int? status) {
        return status != null && status > 0;
      }
      ..headers = {
        HttpHeaders.userAgentHeader: 'dio',
        'Authorization':
            'Client-ID _Br3MXX_greC_pre3zw_a4DfMdJxqJXKw7wXSjaA7cM',
      };
    var response = await dio.get(url);

    // Process the response
    if (response.statusCode == 200) {
      // response: OK

      return response.data;
    } else {
      // something went wrong :(
      debugPrint("Http error: ${response.statusCode}");
      // return empty list
      return [];
    }
  }
}
