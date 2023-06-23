import 'package:eisteintaste/models/orders_items_model.dart';
import 'package:eisteintaste/models/payment_voucher_model.dart';
import 'package:eisteintaste/global/constant/colors.dart';
import 'package:eisteintaste/global/constant/dimensions.dart';
import 'package:eisteintaste/global/widgets/text.dart';
import 'package:eisteintaste/modules/order/controller/orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersDetailsView extends StatelessWidget {
  final int indexOrder;
  OrdersDetailsView({super.key, required this.indexOrder});

  @override
  Widget build(BuildContext context) {
    OrdersController controller = Get.find<OrdersController>();
    controller.resetOrdersDetailsList();
    if(controller.ordersDetailsMap[controller.ordersList[indexOrder].id] == null){
      controller.requestDetailsOfOrders(indexOrder);
    }
    return Obx( () => controller.isLoadedItems.value ? Container(
            margin: EdgeInsets.all(Dimensions.width15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    controller.currentIndex.value = 0;
                  },
                  child: Container(
                    width: Dimensions.iconSize24,
                    height: Dimensions.iconSize24,
                    child: Icon(Icons.arrow_back_ios)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    bigText('DETALHES DO PEDIDO'),
                  ],
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    smallText('Order #${controller.ordersList[indexOrder].id}', size: Dimensions.font14),
                    SizedBox(
                      width: Dimensions.width5,
                    ),
                    Icon(
                      Icons.fiber_manual_record,
                      size: Dimensions.height3,
                    ),
                    SizedBox(
                      width: Dimensions.width5,
                    ),
                    smallText('27/05/2023 at 19:25', size: Dimensions.font14),
                  ],
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Column(
                    children: [
                      GetBuilder<OrdersController>(
                          init: controller,
                          builder: (controller) {
                            List<dynamic> listItems = controller.ordersDetailsMap[controller.ordersList[indexOrder].id]!;
                            return Column(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.55,
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: listItems.length,
                                    itemBuilder: (context, index) {
                                      PaymentVoucher voucher = listItems[index];
                                      return Container(
                                        margin: EdgeInsets.only(bottom: Dimensions.height20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: Dimensions.listViewImgSizeOrders,
                                                  width:Dimensions.listViewImgSizeOrders,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(
                                                        Dimensions.radius10),
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                                SizedBox(width: Dimensions.width10),
                                                smallText('${voucher.quantity}x ${voucher.productName}', color: Colors.black, size: Dimensions.font12)
                                              ],
                                            ),
                                            smallText('\$ ${voucher.totalPrice}', color: Colors.black),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    bigText('Summary of values',
                                        size: Dimensions.font16),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: Dimensions.height10),
                                  width: double.maxFinite,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: Colors.grey, // cor da borda
                                        width: 1.0, // largura da borda
                                        style: BorderStyle.solid, // estilo da borda
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: Dimensions.height20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          smallText('Subtotal',
                                              color: AppColors.mainBlackColor,
                                              size: Dimensions.font14),
                                          smallText('\$ ${controller.subtotal}',
                                              color: AppColors.mainBlackColor,
                                              size: Dimensions.font14),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Dimensions.height20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          smallText('Discounts',
                                              color: AppColors.mainBlackColor,
                                              size: Dimensions.font14),
                                          smallText('\$ 0.0',
                                              color: AppColors.mainBlackColor,
                                              size: Dimensions.font14),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Dimensions.height20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          smallText('Total',
                                              color: AppColors.mainBlackColor,
                                              size: Dimensions.font14),
                                          smallText('\$ ${controller.subtotal}',
                                              color: AppColors.mainBlackColor,
                                              size: Dimensions.font14),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ) : Container(child: Center(child: CircularProgressIndicator()))
        );
  }
}
