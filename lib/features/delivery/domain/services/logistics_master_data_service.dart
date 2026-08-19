import '../models/delivery_order.dart';
import '../models/driver.dart';
import '../models/vehicle.dart';
import '../models/gps_location.dart';

class LogisticsMasterDataService {
  List<DeliveryOrder> getMockDeliveries() => [
        DeliveryOrder(
          id: 'DEL-8821',
          salesOrderId: 'ORD-5521',
          customerId: 'CUST-1001',
          address: '123 Main St, Sector 4',
          status: DeliveryStatus.out_for_delivery,
          destinationGps:
              const GPSLocation(latitude: 40.7128, longitude: -74.0060),
          expectedDeliveryTime: DateTime.now().add(const Duration(minutes: 45)),
        ),
        DeliveryOrder(
          id: 'DEL-8822',
          salesOrderId: 'ORD-5522',
          customerId: 'CUST-1002',
          address: '45 Broadway, Downtown',
          status: DeliveryStatus.assigned,
          destinationGps:
              const GPSLocation(latitude: 40.7306, longitude: -73.9352),
          expectedDeliveryTime: DateTime.now().add(const Duration(hours: 2)),
        ),
      ];

  List<Driver> getMockDrivers() => [
        const Driver(
            id: 'drv_1',
            name: 'Marcus J.',
            phone: '+1 555 111 222',
            licenseNumber: 'LIC-9902',
            status: 'on_duty'),
        const Driver(
            id: 'drv_2',
            name: 'Elena S.',
            phone: '+1 555 333 444',
            licenseNumber: 'LIC-8812',
            status: 'idle_base'),
      ];

  List<Vehicle> getMockVehicles() => [
        const Vehicle(
            id: 'vhc_1',
            plateNumber: 'NY-GZ-101',
            model: 'Yamaha FZ',
            type: VehicleType.bike,
            maxWeightCapacity: 20,
            maxVolumeCapacity: 0.5),
        const Vehicle(
            id: 'vhc_2',
            plateNumber: 'NY-TX-992',
            model: 'Ford Transit',
            type: VehicleType.van,
            maxWeightCapacity: 1200,
            maxVolumeCapacity: 15.0),
      ];
}
