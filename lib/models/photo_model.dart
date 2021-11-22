import 'package:flutter/foundation.dart';
import 'package:unsplash_client_test_app/models/collection.dart';
import 'package:unsplash_client_test_app/models/geolocation.dart';
import 'package:unsplash_client_test_app/models/user.dart';

// ignore_for_file: public_member_api_docs

/// How to sort the photos.
enum PhotoOrder {
  /// Sort from new to old.
  latest,

  /// Sort from old to new.
  oldest,

  /// Sort from most to least popular.
  @Deprecated('This option still exists, but will be removed in the future.')
  popular,

  /// Sort from most to least relevant.
  relevant,
}

/// Filter search results by photo orientation.
enum PhotoOrientation {
  /// Find photos which are wider than tall.
  landscape,

  /// Find photos which are taller than wide.
  portrait,

  /// Find photos with similar width and height.
  squarish,
}

/// Filter results by color.
enum PhotoColor {
  // ignore: constant_identifier_names
  black_and_white,
  black,
  white,
  yellow,
  orange,
  red,
  purple,
  magenta,
  green,
  teal,
  blue
}

/// A photo uploaded to unsplash.
///
/// See: [Unsplash docs](https://unsplash.com/documentation#photos)
class Photo {
  const Photo({
    Map<String, dynamic>? source,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.urls,
    required this.width,
    required this.height,
    required this.color,
    required this.blurHash,
    required this.downloads,
    required this.likes,
    required this.likedByUser,
    required this.description,
    required this.exif,
    required this.location,
    required this.user,
    required this.currentUserCollections,
    required this.links,
    required this.tags,
  }) : super();

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PhotoUrls urls;
  final int width;
  final int height;
  final String color;
  final String? blurHash;
  final int? downloads;
  final int likes;
  final bool likedByUser;
  final String? description;
  final Exif? exif;
  final GeoLocation? location;
  final User user;
  final List<Collection> currentUserCollections;
  final PhotoLinks links;
  final List<Tag>? tags;

  double get ratio => width / height;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'urls': urls.toJson(),
      'width': width,
      'height': height,
      'color': color,
      'blur_hash': blurHash,
      'downloads': downloads,
      'likes': likes,
      'liked_by_user': likedByUser,
      'description': description,
      'exif': exif?.toJson(),
      'location': location?.toJson(),
      'user': user.toJson(),
      'current_user_collections':
          currentUserCollections.map((it) => it.toJson()).toList(),
      'links': links.toJson(),
      'tags': tags?.map((tag) => tag.toJson()).toList(),
    };
  }

  factory Photo.fromJson(Map<String, dynamic> json) {
    //print(json.toString());
    return Photo(
        source: json,
        id: json['id'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
        urls: PhotoUrls.fromJson(json['urls']),
        width: json['width'] as int,
        height: json['height'] as int,
        color: json['color'] as String,
        blurHash: json['blur_hash'] as String?,
        downloads: json['downloads'] as int?,
        likes: json['likes'] as int,
        likedByUser: json['liked_by_user'] as bool,
        description: json['description'] as String?,
        exif: json["exif"] == null
            ? null
            : Exif.fromJson(json['exif'] as Map<String, dynamic>),
        location: json["location"] == null
            ? null
            : GeoLocation.fromJson(json['location'] as Map<String, dynamic>),
        user: User.fromJson(json['user'] as Map<String, dynamic>),
        currentUserCollections:
            (json['current_user_collections'] as List<dynamic>)
                .cast<Map<String, dynamic>>()
                .map((it) => Collection.fromJson(it))
                .toList(),
        links: PhotoLinks.fromJson(json['links'] as Map<String, dynamic>),
        tags: (json['tags'] as List<dynamic>?)
            ?.cast<Map<String, dynamic>>()
            .map((json) => Tag.fromJson(json))
            .toList());
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Photo &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.urls == urls &&
        other.width == width &&
        other.height == height &&
        other.color == color &&
        other.blurHash == blurHash &&
        other.downloads == downloads &&
        other.likes == likes &&
        other.likedByUser == likedByUser &&
        other.description == description &&
        other.exif == exif &&
        other.location == location &&
        other.user == user &&
        listEquals(other.currentUserCollections, currentUserCollections) &&
        other.links == links &&
        listEquals(other.tags, tags);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        urls.hashCode ^
        width.hashCode ^
        height.hashCode ^
        color.hashCode ^
        blurHash.hashCode ^
        downloads.hashCode ^
        likes.hashCode ^
        likedByUser.hashCode ^
        description.hashCode ^
        exif.hashCode ^
        location.hashCode ^
        user.hashCode ^
        currentUserCollections.hashCode ^
        links.hashCode ^
        tags.hashCode;
  }
}

/// Tag for a [Photo].
class Tag {
  const Tag({
    Map<String, dynamic>? source,
    required this.title,
  }) : super();

  final String title;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
    };
  }

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      source: json,
      title: json['title'] as String,
    );
  }
}

/// Links for a [Photo].
class PhotoLinks {
  const PhotoLinks({
    Map<String, dynamic>? source,
    required this.self,
    required this.html,
    required this.download,
    required this.downloadLocation,
  }) : super();

  final Uri self;
  final Uri html;
  final Uri download;
  final Uri downloadLocation;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'self': self.toString(),
      'html': html.toString(),
      'download': download.toString(),
      'download_location': downloadLocation.toString(),
    };
  }

  factory PhotoLinks.fromJson(Map<String, dynamic> json) {
    return PhotoLinks(
      source: json,
      self: Uri.parse(json['self'] as String),
      html: Uri.parse(json['html'] as String),
      download: Uri.parse(json['download'] as String),
      downloadLocation: Uri.parse(json['download_location'] as String),
    );
  }
}

/// Exif metadata for a [Photo].
class Exif {
  const Exif({
    Map<String, dynamic>? source,
    required this.make,
    required this.model,
    required this.exposureTime,
    required this.aperture,
    required this.focalLength,
    required this.iso,
  }) : super();

  final String? make;
  final String? model;
  final String? exposureTime;
  final String? aperture;
  final String? focalLength;
  final int? iso;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'make': make,
      'model': model,
      'exposure_time': exposureTime,
      'aperture': aperture,
      'focal_length': focalLength,
      'iso': iso,
    };
  }

  factory Exif.fromJson(Map<String, dynamic> json) {
    return Exif(
      source: json,
      make: json['make'] as String?,
      model: json['model'] as String?,
      exposureTime: json['exposure_time'] as String?,
      aperture: json['aperture'] as String?,
      focalLength: json['focal_length'] as String?,
      iso: json['iso'] as int?,
    );
  }
}

/// Photo urls for a [Photo].
class PhotoUrls {
  const PhotoUrls({
    Map<String, dynamic>? source,
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
  }) : super();

  final Uri raw;
  final Uri full;
  final Uri regular;
  final Uri small;
  final Uri thumb;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'raw': raw.toString(),
      'full': full.toString(),
      'regular': regular.toString(),
      'small': small.toString(),
      'thumb': thumb.toString(),
    };
  }

  factory PhotoUrls.fromJson(Map<String, dynamic> json) {
    return PhotoUrls(
      source: json,
      raw: Uri.parse(json['raw'] as String),
      full: Uri.parse(json['full'] as String),
      regular: Uri.parse(json['regular'] as String),
      small: Uri.parse(json['small'] as String),
      thumb: Uri.parse(json['thumb'] as String),
    );
  }
}
