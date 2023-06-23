import 'package:eisteintaste/global/constant/dimensions.dart';
import 'package:eisteintaste/global/widgets/text.dart';
import 'package:eisteintaste/models/orders_model.dart';
import 'package:eisteintaste/modules/order/controller/orders_controller.dart';
import 'package:eisteintaste/modules/order/views/orders_details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersListView extends StatefulWidget{
  const OrdersListView({super.key});

  @override
  State<OrdersListView> createState() => _OrdersListViewState();
}

class _OrdersListViewState extends State<OrdersListView> {

  @override
  Widget build(BuildContext context) {
    OrdersController ordersController = Get.find<OrdersController>();
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(child: bigText("Orders list"),),
            ],
          ),
        ),
        Container(
          child: Obx(
            () => ordersController.isLoaded.value == true ? GetBuilder<OrdersController>(
                init: ordersController,
                builder: (ordersController) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(Dimensions.height5),
                      margin: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: Dimensions.idColumn,
                                child:  smallText('Order ID', color: Colors.black, textAlign: TextAlign.center),

                              ),
                              SizedBox(
                                width: Dimensions.nameColumn,
                                child: smallText('Customer', color: Colors.black)
                              ),
                              SizedBox(
                                width: Dimensions.idColumn,
                                child: smallText("Address ID", color: Colors.black)),
                              SizedBox(
                              width: Dimensions.dateColumn,
                              child: smallText("Created at", color: Colors.black, textAlign: TextAlign.center)),
                            ],
                          ),
                          Container(
                            width: Dimensions.totalAmountColumn,
                            child: smallText('Total', color: Colors.black, textAlign: TextAlign.center)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.9,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: ordersController.ordersList.length,
                        itemBuilder: (context, index) {
                          Orders order = ordersController.ordersList[index];
                          return GestureDetector(
                            onTap: () {
                              ordersController.children[1] = OrdersDetailsView(indexOrder: index);
                              ordersController.currentIndex.value = 1;
                            },
                            child: Container(
                              padding: EdgeInsets.all(Dimensions.height10),
                              margin: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius5),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFe8e8e8),
                                    blurRadius: Dimensions.shadowBlurRadius,
                                    offset: Offset(0, 5),
                                  ),
                                ]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: Dimensions.idColumn,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height10),
                                          child: smallText('#${order.id}', color: Colors.black, textAlign: TextAlign.center),
                                        ),
                                      ),
                                      Container(
                                        width: Dimensions.nameColumn,
                                        child: smallText('${ordersController.userMap[order.customerId]}', color: Colors.black)
                                      ),
                                      Container(
                                        width: Dimensions.idColumn,
                                        child: smallText("1", color: Colors.black, textAlign: TextAlign.center)),
                                      Container(
                                        width: Dimensions.dateColumn,
                                        child: smallText(
                                          "${ordersController.convertDateTimeToString(DateTime.parse(order.createdAt!))}", 
                                          color: Colors.black, 
                                          textAlign: TextAlign.center
                                        )),
                                    ],
                                  ),
                                  
                                  Container(
                                    width: Dimensions.totalAmountColumn,
                                    child: smallText('${order.totalAmount}', color: Colors.black, textAlign: TextAlign.center)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }) : Container(height: MediaQuery.of(context).size.height * 0.9, child: Center(child: CircularProgressIndicator()),),
          ),
        ),
      ],
    );
  }
  
}
