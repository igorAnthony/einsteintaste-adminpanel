class Orders {
  final int? id;
  final int? customerId;
  final String? totalAmount;
  final int? orderStatus;
  final String? createdAt;
  final String? updatedAt;

  Orders({
    required this.id,
    required this.customerId,
    required this.totalAmount,
    required this.orderStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Orders.fromJson(Map<String, dynamic> json) {
    
    return Orders(
      id: json['id'],
      customerId: json['customer_id'],
      totalAmount: json['total_amount'],
      orderStatus: json['order_status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}