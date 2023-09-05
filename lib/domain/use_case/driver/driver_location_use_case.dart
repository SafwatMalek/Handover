import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handover/data/model/driver/driver_model.dart';

abstract class DriverLocationUseCase {
  Stream<QuerySnapshot<Driver>> execute(String orderId);
}
