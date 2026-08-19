class GPSLocation {
  final double latitude;
  final double longitude;
  final DateTime? timestamp;

  const GPSLocation({
    required this.latitude,
    required this.longitude,
    this.timestamp,
  });

  @override
  String toString() => '$latitude, $longitude';
}
