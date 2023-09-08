import 'package:handover/domain/repository/order_repository.dart';
import 'package:handover/domain/use_case/order/update_order/update_order_use_case.dart';

class UpdateOrderUseCaseImp implements UpdateOrderUseCase {
  final IOrderRepository _orderRepository;

  UpdateOrderUseCaseImp(this._orderRepository);

  @override
  Future<void> execute(String orderId, int status) async {
    try {
      await _orderRepository.updateOrderStatus(orderId, status);
    } catch (e) {
      throw Exception("Couldn't update status");
    }
  }
}
