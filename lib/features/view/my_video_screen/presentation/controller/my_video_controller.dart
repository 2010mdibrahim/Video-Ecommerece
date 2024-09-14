import 'package:e_commerce/features/view/my_video_screen/data/model/my_video_model.dart';
import 'package:get/get.dart';

import '../../../../../core/di/app_component.dart';
import '../../domain/repository/my_video_repository.dart';
import '../../domain/usecase/my_video_pass_usecase.dart';

class MyVideoController extends GetxController{

var isLoading = false.obs;
var myVideoModel = MyVideosModel().obs;


  @override
  void onInit() {
    myVideoList();
    super.onInit();
  }

  myVideoList() async {
    try {
      isLoading.value = true;
      MyVideoPassUseCase productCategoryUseCase =
      MyVideoPassUseCase(locator<MyVideoRepository>());
      var response = await productCategoryUseCase();
      if (response?.data != null && response?.data is MyVideosModel) {
        myVideoModel.value = response?.data ?? MyVideosModel();
      } else {
        print('No data found');
      }
    } catch (e) {
      print("This is an error: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}