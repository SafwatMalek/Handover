import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handover/data/model/order/order_model.dart';
import 'package:handover/domain/repository/order_repository.dart';
import 'package:handover/domain/use_case/order/order_listener/order_listener_use_case.dart';

class OrderListenerUseCaseImp implements OrderListenerUseCase {
  final IOrderRepository _orderRepository;

  OrderListenerUseCaseImp(this._orderRepository);

  @override
  Stream<QuerySnapshot<OrderModel>> execute(String orderId) {
    return _orderRepository.getOrderListener(orderId);
  }
}
