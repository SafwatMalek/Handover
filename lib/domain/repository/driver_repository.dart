import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handover/data/model/driver/driver_model.dart';

abstract class IDriverRepo {
  Stream<QuerySnapshot<Driver>> getDriverLocation(String orderId);
}
