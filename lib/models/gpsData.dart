import 'package:cloud_firestore/cloud_firestore.dart';

class gpsData {
  final double latitude;
  final double longitude;
  final DocumentReference reference;

  gpsData.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['latitude'] != null),
        assert(map['longitude'] != null),
        latitude = map['latitude'],
        longitude = map['longitude'];

  gpsData.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$latitude:$longitude>";
}