import 'package:eisteintaste/models/api_response.dart';
import 'package:eisteintaste/modules/order/provider/orders_provider.dart';
import 'package:get/get.dart';

class OrdersRepository extends GetxService {
  final OrdersProvider ordersProvider;

  OrdersRepository({required this.ordersProvider});

  Future<ApiResponse> getOrdersListById(int userId) async {
    return await ordersProvider.getOrdersListById(userId);
  }
  Future<ApiResponse> getDetailsOfOrders(int orders_id) async {
    return await ordersProvider.getDetailsOfOrders(orders_id);
  }
  Future<ApiResponse> getAllOrders() async {
    return await ordersProvider.getAllOrders();
  }
}