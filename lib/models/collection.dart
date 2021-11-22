import 'package:unsplash_client_test_app/models/photo_model.dart';
import 'package:unsplash_client_test_app/models/user.dart';

class Collection {
  final String id;
  final String title;
  final String? description;
  final DateTime publishedAt;
  final DateTime updatedAt;
  final Photo? coverPhoto;
  final User user;
  final bool featured;
  final int totalPhotos;
  final bool private;
  final String? shareKey;
  final CollectionLinks links;

  const Collection({
    Map<String, dynamic>? source,
    required this.id,
    required this.title,
    required this.description,
    required this.publishedAt,
    required this.updatedAt,
    required this.coverPhoto,
    required this.user,
    required this.featured,
    required this.totalPhotos,
    required this.private,
    required this.shareKey,
    required this.links,
  }) : super();

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'published_at': publishedAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'cover_photo': coverPhoto?.toJson(),
      'user': user.toJson(),
      'featured': featured,
      'total_photos': totalPhotos,
      'private': private,
      'share_key': shareKey,
      'links': links.toJson(),
    };
  }

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      source: json,
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      publishedAt: DateTime.parse(json['published_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      coverPhoto: Photo.fromJson(json['cover_photo'] as Map<String, dynamic>),
      user: User.fromJson((json['user'] as Map<String, dynamic>)),
      featured: json['featured'] as bool,
      totalPhotos: json['total_photos'] as int,
      private: json['private'] as bool,
      shareKey: json['shared_key'] as String?,
      links: CollectionLinks.fromJson(json['links'] as Map<String, dynamic>),
    );
  }
}

/// Links for a [Collection].
class CollectionLinks {
  final Uri self;
  final Uri html;
  final Uri photos;
  final Uri related;

  const CollectionLinks({
    Map<String, dynamic>? source,
    required this.self,
    required this.html,
    required this.photos,
    required this.related,
  }) : super();

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'self': self.toString(),
      'html': html.toString(),
      'photos': photos.toString(),
      'related': related.toString(),
    };
  }

  factory CollectionLinks.fromJson(Map<String, dynamic> json) {
    return CollectionLinks(
      source: json,
      self: Uri.parse(json['self'] as String),
      html: Uri.parse(json['html'] as String),
      photos: Uri.parse(json['photos'] as String),
      related: Uri.parse(json['related'] as String),
    );
  }
}
