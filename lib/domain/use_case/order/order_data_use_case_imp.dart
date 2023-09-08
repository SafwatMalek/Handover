import 'package:handover/data/model/order/order_model.dart';
import 'package:handover/domain/repository/order_repository.dart';

import 'order_data_use_case.dart';

class OrderDataUseCaseImp implements OrderDataUseCase {
  final IOrderRepository _orderRepository;

  OrderDataUseCaseImp(this._orderRepository);

  @override
  Future<OrderModel> execute(String id) async {
    try {
      var orderSnapshot = await _orderRepository.getCurrentOrder(id);
      return orderSnapshot.docChanges.first.doc.data()!;
    } catch (e) {
      throw Exception("Order not found: $e");
    }
  }
}
