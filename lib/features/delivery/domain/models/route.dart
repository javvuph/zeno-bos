import 'delivery_stop.dart';
import 'gps_location.dart';

class DeliveryRoute {
  final String id;
  final String name;
  final List<DeliveryStop> stops;
  final double totalDistanceKm;
  final int totalEstimatedMinutes;
  final List<GPSLocation> polyline; // For map rendering

  const DeliveryRoute({
    required this.id,
    required this.name,
    required this.stops,
    this.totalDistanceKm = 0.0,
    this.totalEstimatedMinutes = 0,
    this.polyline = const [],
  });
}
