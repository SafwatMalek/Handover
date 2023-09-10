import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handover/data/model/order/order_model.dart';

abstract class IOrderRepository {
  Future<QuerySnapshot<OrderModel>> getCurrentOrder(String userId);

  Future<void> updateOrderStatus(String orderId, int status);

  Stream<QuerySnapshot<OrderModel>> getOrderListener(String orderId);
}
