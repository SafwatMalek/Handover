enum OrderStatus {
  onTheWay(1),
  readyToPickup(2),
  pickedUp(3),
  nearToDelivery(4),
  readyToDeliver(5),
  delivered(6);

  const OrderStatus(this.value);

  final int value;
}
