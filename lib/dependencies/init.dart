import 'package:all_document_reader/controllers/favorites_controller.dart';
import 'package:all_document_reader/controllers/home_screen_controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeScreenController>(HomeScreenController());
    Get.put<FavoritesController>(FavoritesController());
  }
}
