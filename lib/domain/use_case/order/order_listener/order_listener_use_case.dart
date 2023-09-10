import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handover/data/model/order/order_model.dart';

abstract class OrderListenerUseCase {
  Stream<QuerySnapshot<OrderModel>> execute(String orderId);
}
