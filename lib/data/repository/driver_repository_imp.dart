import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handover/data/model/driver/driver_model.dart';
import 'package:handover/domain/repository/driver_repository.dart';

class DriverRepoImp implements IDriverRepo {
  final driverRef =
      FirebaseFirestore.instance.collection('driver').withConverter<Driver>(
            fromFirestore: (snapshots, _) => Driver.fromMap(snapshots.data()!),
            toFirestore: (driver, _) => driver.toMap(),
          );

  @override
  Stream<QuerySnapshot<Driver>> getDriverLocation(String orderId) {
    return driverRef.where("current_order", isEqualTo: orderId).snapshots();
  }
}
