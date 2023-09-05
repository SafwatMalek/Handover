class User {
  String orderId;
  String userId;
  String userName;

  User({
    required this.orderId,
    required this.userId,
    required this.userName,
  });

  Map<String, dynamic> toMap() {
    return {
      'current_order_id': orderId,
      'id': userId,
      'name': userName,
    };
  }

  factory User.fromMap(Map<String, dynamic>? map) {
    return User(
      orderId: map?['current_order_id'],
      userId: map?['id'],
      userName: map?['name'],
    );
  }

  @override
  String toString() {
    return 'User{orderId: $orderId, userId: $userId, userName: $userName}';
  }
}
