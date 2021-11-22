import 'package:flutter/material.dart';
import 'package:unsplash_client_test_app/models/geolocation.dart';
import 'package:unsplash_client_test_app/models/photo_model.dart';
import 'package:unsplash_client_test_app/widgets/loading_indicator.dart';

class InfoSheet extends StatelessWidget {
  final Photo image;

  const InfoSheet(this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => /*Container*/ Card(
        margin: const EdgeInsets.only(top: 16.0),
        elevation: 10.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: image != null
                ? <Widget>[
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: <Widget>[
                          _buildUserProfileImage(
                              image.user.profileImage.medium.toString()),
                          Text(
                            '${image.user.firstName} ${image.user.lastName}',
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              '${image.createdAt}'.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.black26,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // show description
                    _buildDescriptionWidget(image.description.toString()),
                    // show location
                    _buildLocationWidget(image.location as GeoLocation),
                    // show exif data
                    _buildExifWidget(image.exif as Exif),
                    // filter null views
                  ].where((w) => w != null).toList()
                : <Widget>[const LoadingIndicator(Colors.black26)]),
        /*decoration: new BoxDecoration(
            color: Colors.grey[50],
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0))),*/
      );

  /// Builds a round image widget displaying a profile image from a given [url].
  Widget _buildUserProfileImage(String url) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage(url),
        ),
      );

  /// Builds widget displaying a given [description] for an image.
  Widget _buildDescriptionWidget(String description) => description != null
      ? Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 8.0, bottom: 16.0),
          child: Text(
            '$description',
            style: const TextStyle(
              color: Colors.black38,
              fontSize: 16.0,
              letterSpacing: 0.1,
            ),
          ),
        )
      : Container();

  /// Builds a widget displaying the [location], where the image was captured.
  Widget _buildLocationWidget(GeoLocation location) => location != null
      ? Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, right: 16.0),
          child: Row(
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.black54,
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${location.city}, ${location.country}'.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),
        )
      : Container();

  /// Builds a widget displaying all [exif] data
  Widget _buildExifWidget(Exif exif) => exif != null
      ? Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, right: 16.0),
          child: Row(
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.photo_camera,
                    color: Colors.black54,
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                      child: Text(
                        '${exif.model}',
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      )),
                  Row(
                    children: <Widget>[
                      // display exif info
                      _buildExifInfoItem('ƒ${exif.aperture}'),
                      _buildExifInfoItem('${exif.exposureTime}'),
                      _buildExifInfoItem('${exif.focalLength}mm'),
                      _buildExifInfoItem('ISO${exif.iso}'),
                    ],
                  ),
                ],
              )
            ].where((w) => w != null).toList(),
          ))
      : Container();

  /// Builds exif info item that displays given [data].
  Widget _buildExifInfoItem(String data) => data != null
      ? Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
          child: Text(
            data,
            style: const TextStyle(
                color: Colors.black26,
                fontSize: 12.0,
                fontWeight: FontWeight.bold),
          ))
      : Container();
}
