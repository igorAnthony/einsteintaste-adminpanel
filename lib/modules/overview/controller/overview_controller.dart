import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';

class OverviewController extends GetxController{

List<DateTime> orderDates = []; // Armazena as datas das vendas
Map<String, int> salesData = {}; // Mapa para armazenar o dia e a quantidade de produtos vendidos
Map<int, String> monthMap = {
  1: 'Jan',
  2: 'Feb',
  3: 'Mar',
  4: 'Apr',
  5: 'May',
  6: 'Jun',
  7: 'Jul',
  8: 'Aug',
  9: 'Sep',
  10: 'Oct',
  11: 'Nov',
  12: 'Dec',
};


  void setDataInSalesData(DateTime date){
    print("entrei aq");
    String day = DateFormat('dd/MM/yyyy').format(date);
    
    if (salesData.containsKey(day)) {
      salesData[day] = salesData[day]! + 1;
    } else {
      salesData[day] = 1;
    }

    salesData.forEach((day, quantity) {
      print('Dia: $day, Quantidade de produtos vendidos: $quantity');
      update();
    });
  }

}