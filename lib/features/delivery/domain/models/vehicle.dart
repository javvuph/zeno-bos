enum VehicleType { bike, van, truck, heavy_truck }

class Vehicle {
  final String id;
  final String plateNumber;
  final String model;
  final VehicleType type;
  final double maxWeightCapacity;
  final double maxVolumeCapacity;
  final bool isActive;

  const Vehicle({
    required this.id,
    required this.plateNumber,
    required this.model,
    required this.type,
    required this.maxWeightCapacity,
    required this.maxVolumeCapacity,
    this.isActive = true,
  });
}
