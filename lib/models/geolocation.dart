class GeoLocation {
  const GeoLocation({
    Map<String, dynamic>? source,
    required this.name,
    required this.city,
    required this.country,
    required this.position,
  }) : super();

  final String? name;
  final String? city;
  final String? country;
  final GeoPosition position;

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'city': city,
      'country': country,
      'position': position,
    };
  }

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      source: json,
      name: json['name'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      position: GeoPosition.fromJson(json['position'] as Map<String, dynamic>),
    );
  }
}

/// A precise geographical position on earth, in [latitude] and [longitude].
class GeoPosition {
  const GeoPosition({
    Map<String, dynamic>? source,
    required this.latitude,
    required this.longitude,
  }) : super();

  final double? latitude;
  final double? longitude;

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory GeoPosition.fromJson(Map<String, dynamic> json) {
    return GeoPosition(
      source: json,
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
    );
  }
}
