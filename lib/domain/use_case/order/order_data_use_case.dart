import 'package:handover/data/model/order/order_model.dart';

abstract class OrderDataUseCase {
  Future<OrderModel> execute(String id);
}
