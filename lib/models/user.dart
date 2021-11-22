class User {
  const User({
    Map<String, dynamic>? source,
    required this.id,
    required this.updatedAt,
    required this.username,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.uploadsRemaining,
    required this.portfolioUrl,
    required this.bio,
    required this.location,
    required this.totalLikes,
    required this.totalPhotos,
    required this.totalCollections,
    required this.followedByUser,
    required this.followerCount,
    required this.followingCount,
    required this.downloads,
    required this.instagramUsername,
    required this.twitterUsername,
    required this.profileImage,
    required this.badge,
    required this.links,
  }) : super();

  final String id;
  final DateTime updatedAt;
  final String username;
  final String name;
  final String firstName;
  final String? lastName;
  final String? email;
  final int? uploadsRemaining;
  final Uri? portfolioUrl;
  final String? bio;
  final String? location;
  final int totalLikes;
  final int totalPhotos;
  final int totalCollections;
  final bool? followedByUser;
  final int? followerCount;
  final int? followingCount;
  final int? downloads;
  final String? instagramUsername;
  final String? twitterUsername;
  final ProfileImage profileImage;
  final UserBadge? badge;
  final UserLinks links;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'updated_at': updatedAt.toIso8601String(),
      'username': username,
      'name': name,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'uploads_remaining': uploadsRemaining,
      'portfolio_url': portfolioUrl.toString(),
      'bio': bio,
      'location': location,
      'total_likes': totalLikes,
      'total_photos': totalPhotos,
      'total_collections': totalCollections,
      'followed_by_user': followedByUser,
      'follower_count': followerCount,
      'following_count': followingCount,
      'downloads': downloads,
      'instagram_username': instagramUsername,
      'twitter_username': twitterUsername,
      'profile_image': profileImage.toJson(),
      'badge': badge?.toJson(),
      'links': links.toJson(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      source: json,
      id: json['id'] as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      username: json['username'] as String,
      name: json['name'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      uploadsRemaining: json['uploads_remaining'] as int?,
      portfolioUrl: json["portfolio_url"] == null
          ? null
          : Uri.parse(json['portfolio_url'] as String),
      bio: json['bio'] as String?,
      location: json['location'] as String?,
      totalLikes: json['total_likes'] as int,
      totalPhotos: json['total_photos'] as int,
      totalCollections: json['total_collections'] as int,
      followedByUser: json['followed_by_user'] as bool?,
      followerCount: json['follower_count'] as int?,
      followingCount: json['following_count'] as int?,
      downloads: json['downloads'] as int?,
      instagramUsername: json['instagram_username'] as String?,
      twitterUsername: json['twitter_username'] as String?,
      profileImage:
          ProfileImage.fromJson(json['profile_image'] as Map<String, dynamic>),
      badge: json["badge"] == null
          ? null
          : UserBadge.fromJson(json['badge'] as Map<String, dynamic>),
      links: UserLinks.fromJson(json['links'] as Map<String, dynamic>),
    );
  }
}

/// The profile image of a [User].
class ProfileImage {
  const ProfileImage({
    Map<String, dynamic>? source,
    required this.small,
    required this.medium,
    required this.large,
  }) : super();

  final Uri small;
  final Uri medium;
  final Uri large;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'small': small.toString(),
      'medium': medium.toString(),
      'large': large.toString(),
    };
  }

  factory ProfileImage.fromJson(Map<String, dynamic> json) {
    return ProfileImage(
      source: json,
      small: Uri.parse(json['small'] as String),
      medium: Uri.parse(json['medium'] as String),
      large: Uri.parse(json['large'] as String),
    );
  }
}

/// A badge of a [User].
class UserBadge {
  const UserBadge({
    Map<String, dynamic>? source,
    required this.title,
    required this.primary,
    required this.slug,
    required this.link,
  }) : super();

  final String title;
  final bool primary;
  final String slug;
  final Uri link;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'primary': primary,
      'slug': slug,
      'link': link.toString(),
    };
  }

  factory UserBadge.fromJson(Map<String, dynamic> json) {
    return UserBadge(
      source: json,
      title: json['title'] as String,
      primary: json['primary'] as bool,
      slug: json['slug'] as String,
      link: Uri.parse(json['link'] as String),
    );
  }
}

/// Links for a [User].
class UserLinks {
  const UserLinks({
    Map<String, dynamic>? source,
    required this.self,
    required this.html,
    required this.photos,
    required this.likes,
    required this.portfolio,
    required this.followers,
    required this.following,
  }) : super();

  final Uri self;
  final Uri html;
  final Uri photos;
  final Uri likes;
  final Uri portfolio;
  final Uri followers;
  final Uri following;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'self': self.toString(),
      'html': html.toString(),
      'photos': photos.toString(),
      'likes': likes.toString(),
      'portfolio': portfolio.toString(),
      'followers': followers.toString(),
      'following': following.toString(),
    };
  }

  factory UserLinks.fromJson(Map<String, dynamic> json) {
    return UserLinks(
      source: json,
      self: Uri.parse(json['self'] as String),
      html: Uri.parse(json['html'] as String),
      photos: Uri.parse(json['photos'] as String),
      likes: Uri.parse(json['likes'] as String),
      portfolio: Uri.parse(json['portfolio'] as String),
      followers: Uri.parse(json['followers'] as String),
      following: Uri.parse(json['following'] as String),
    );
  }
}
