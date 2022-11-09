import 'package:get/get.dart';
import 'package:sqlapi/controller/DBhelper.dart';

class HomeController extends GetxController{
  RxList l1 = [].obs;
  void getData()async{
    l1.value = (await DBHelper.ints.readDB()) as List;



  }
}