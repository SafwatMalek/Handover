import 'package:flutter/material.dart';
import 'package:handover/data/model/order/order_model.dart';
import 'package:handover/data/model/order/order_status.dart';
import 'package:handover/presentation/screens/screens_extensions.dart';
import 'package:handover/presentation/widget/stepper/stepper_component.dart';
import 'package:handover/presentation/widget/stepper/stepper_steps.dart';

class TrackingView extends StatefulWidget {
  final OrderModel order;

  const TrackingView({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<TrackingView> createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: context.screenHeightUnit() * 4),
      child: StepperComponent(
        paddingHorizontal: context.screenWidthUnit() * 4,
        steps: [
          Steps(
              getOrderStatus(
                widget.order.status,
                OrderStatus.onTheWay.value,
              ),
              "On the way"),
          Steps(
              getOrderStatus(
                widget.order.status,
                OrderStatus.pickedUp.value,
              ),
              "Picked up delivery"),
          Steps(
              getOrderStatus(
                widget.order.status,
                OrderStatus.nearToDelivery.value,
              ),
              "Near delivery destination"),
          Steps(
              getOrderStatus(
                widget.order.status,
                OrderStatus.delivered.value,
              ),
              "Delivered Package"),
        ],
      ),
    );
  }

  StepsState getOrderStatus(int status, int type) {
    if (status == type) {
      return StepsState.active;
    } else if (status > type) {
      return StepsState.complete;
    } else {
      return StepsState.inActive;
    }
  }
}
