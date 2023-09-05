import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handover/data/model/driver/driver_model.dart';
import 'package:handover/domain/repository/driver_repository.dart';

import 'driver_location_use_case.dart';

class DriverLocationUseCaseImp implements DriverLocationUseCase {
  final IDriverRepo _driverRepo;

  DriverLocationUseCaseImp(this._driverRepo);

  @override
  Stream<QuerySnapshot<Driver>> execute(String orderId) {
    return _driverRepo.getDriverLocation(orderId);
  }
}
