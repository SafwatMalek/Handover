import 'package:flutter/material.dart';
import 'package:handover/data/model/order/order_model.dart';
import 'package:handover/presentation/screens/screens_extensions.dart';

import 'bottom_sheet_status.dart';

class BottomSheetContainer extends StatefulWidget {
  final OrderModel order;
  final Widget child;

  const BottomSheetContainer({
    super.key,
    required this.order,
    required this.child,
  });

  @override
  State<BottomSheetContainer> createState() => _BottomSheetContainerState();
}

class _BottomSheetContainerState extends State<BottomSheetContainer> {
  late BottomSheetStatus _currentStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = BottomSheetStatus.collapse;
  }

  @override
  Widget build(BuildContext context) {
    final isCollapse = _currentStatus == BottomSheetStatus.collapse;

    return GestureDetector(
      onTap: () {
        setState(() {
          isCollapse
              ? _currentStatus = BottomSheetStatus.expand
              : _currentStatus = BottomSheetStatus.collapse;
        });
      },
      child: isCollapse ? _collapseWidget() : _expandedSheet(widget.order),
    );
  }

  Widget _collapseWidget() {
    return Container(
      height: context.screenHeightUnit() * 3,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.amber.shade600,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          )),
      child: const Center(
        child: Divider(
          color: Colors.black38,
          height: 2,
          indent: 150,
          endIndent: 150,
          thickness: 3,
        ),
      ),
    );
  }

  Widget _expandedSheet(OrderModel order) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        //expand
        Container(
          height: context.screenHeightUnit() * 50,
          margin: const EdgeInsets.only(top: 60),
          padding: const EdgeInsets.only(top: 68),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.amber.shade600,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              )),
          child: Column(
            children: [
              const Text(
                "Safwat Malek",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              widget.child
            ],
          ),
        ),
        //image
        Container(
          width: context.screenWidthUnit() * 30,
          decoration: BoxDecoration(
              color: Colors.amber.shade600,
              borderRadius:
                  BorderRadius.circular(context.screenHeightUnit() * 24),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(2, 2),
                    blurRadius: 0.1)
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(context.screenWidthUnit() * 30),
            child: Image.asset("assets/images/cry_cat.png"),
          ),
        ),
      ],
    );
  }
}
