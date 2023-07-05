import 'package:eisteintaste/global/constant/dimensions.dart';
import 'package:eisteintaste/global/widgets/containerSalesInfo.dart';
import 'package:eisteintaste/global/widgets/text.dart';
import 'package:eisteintaste/models/chartData.dart';
import 'package:eisteintaste/modules/order/controller/orders_controller.dart';
import 'package:eisteintaste/modules/overview/controller/overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class OverviewView extends StatefulWidget{
  const OverviewView({super.key});

  @override
  State<OverviewView> createState() => _OverviewViewState();
}

class _OverviewViewState extends State<OverviewView> {

  @override
  Widget build(BuildContext context) {
    OverviewController overviewController = Get.find<OverviewController>();
    OrdersController ordersController = Get.find<OrdersController>();
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(child: bigText("Overview"),),
                  
                ],
              ),
            ),
            Obx(
              ()=> ordersController.isLoaded.value == true ? Container(
                margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                height: MediaQuery.of(context).size.height*0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: Dimensions.height10),
                      height: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          containerSalesInfo("Total orders",'${ordersController.totalQuantOrders.value}'),
                          containerSalesInfo("Last 30 days", '\$ ${ordersController.totalFaturation.value},00'),
                          containerSalesInfo("Total",'3'),    
                        ],
                      )
                    ),
                    SizedBox(height: Dimensions.height30),
                    bigText("Sales Chart"),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: Dimensions.height10),
                      height: 300,
                      width: 600,
                            child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            series: <ChartSeries>[
                              LineSeries<ChartData, String>(
                                dataSource: getChartData(),
                                xValueMapper: (ChartData data, _) => data.day,
                                yValueMapper: (ChartData data, _) => data.quantity,
                              ),
                            ],
                          ),
                          ),
                  ],
                ),
              ) : Container(
                height: MediaQuery.of(context).size.height*0.9,
                child: Center(
                  child: CircularProgressIndicator(),
                )
              ),
            )
          ],
      ),
    ));
  }
  
}
List<ChartData> getChartData() {
  List<ChartData> chartData = [];
  OverviewController overviewController = Get.find<OverviewController>();
  overviewController.salesData.forEach((dateString, quantity) {
    DateTime date = DateFormat('dd/MM/yyyy').parse(dateString);
    int day = date.day;
    String dayWithMonth = overviewController.monthMap[date.month]! + " $day";
    chartData.add(ChartData(dayWithMonth, quantity));
  });
  return chartData;
}
