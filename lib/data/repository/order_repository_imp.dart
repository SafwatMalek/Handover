import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handover/data/model/order/order_model.dart';
import 'package:handover/domain/repository/order_repository.dart';

class OrderRepoImp implements IOrderRepository {
  final orderRef = FirebaseFirestore.instance
      .collection('orders')
      .withConverter<OrderModel>(
        fromFirestore: (snapshots, _) => OrderModel.fromMap(snapshots.data()),
        toFirestore: (order, _) => order.toMap(),
      );

  @override
  Future<QuerySnapshot<OrderModel>> getCurrentOrder(String userId) async {
    return orderRef.where("user_id", isEqualTo: userId).get();
  }

  @override
  Future<void> updateOrderStatus(String orderId, int status) async {
    orderRef.doc(orderId).update({"status": status});
  }

  @override
  Stream<QuerySnapshot<OrderModel>> getOrderListener(String orderId) {
    return orderRef.where("order_id", isEqualTo: orderId).snapshots();
  }
}
